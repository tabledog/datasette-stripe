const fs = require('fs');
const {createReadStream} = require("fs");
const util = require('util');
const exec = util.promisify(require('child_process').exec);
const http = require('http');
const https = require('https');

// Config
const proxy = {
    ip: "0.0.0.0",
    port: 3000
}

// Forward HTTP requests to this server.
const target = {
    // Use a unix socket to be absolutely certain that traffic cannot reach the unprotected instance from outside of this container/vm/machine.
    // - Listening on 127.0.0.1 may still be an issue as tunnels can forward external traffic (SSH/SOCKS).
    socketPath: '/tmp/datasette.sock',
    // hostname: '127.0.0.1',
    // port: 8081,
}

const tdog_log_file = '/data/logs/tdog.txt';
const tdog_db = '/data/stripe.sqlite';


let node_env = "production";
if ("NODE_ENV" in process.env) {
    if (/^(development|production)$/.test(process.env["NODE_ENV"])) {
        node_env = process.env["NODE_ENV"];
    }
}

const is_dev = node_env === "development";
const is_prod = node_env === "production";


// Block password guesses after this many incorrect per day.
const max_incorrect_daily_pass_guesses_per_ip = 30;

// Protect against the case when an attacker may have a large pool of IP addresses.
// - In that case, block requests for all IP's for the rest of the day.
const max_incorrect_daily_pass_guesses = 500;


const get_stripe_key = () => {
    if (!(
        "STRIPE_SECRET_KEY" in process.env &&
        typeof process.env.STRIPE_SECRET_KEY === "string" &&
        process.env.STRIPE_SECRET_KEY.length > 0
    )) {
        console.error("STRIPE_SECRET_KEY env var not set.");
        process.exit(1);
    }

    return process.env.STRIPE_SECRET_KEY;
};


const get_today = () => (new Date().toISOString().slice(0, 10));

const guesses = {
    // Today, format yyyy-mm-dd
    date: get_today(),
    total_guesses: 0,
    ips: {}
};

const get_count_incorrect_guesses_for_ip_today = (ip) => {
    const today = get_today();

    // Clear guess count every day.
    if (guesses.date !== today) {
        guesses.date = today;
        guesses.total_guesses = 0;
        guesses.ips = {};
    }

    if (ip in guesses.ips) {
        return guesses.ips[ip].guess_count;
    }

    return 0;
};

const increment_guess_count_for_ip = (ip) => {
    if (!(ip in guesses.ips)) {
        guesses.ips[ip] = {
            guess_count: 0
        };
    }
    guesses.total_guesses++;
    guesses.ips[ip].guess_count++;
}

const to_auth = (u, p) => {
    const b64 = Buffer.from(u + ':' + p).toString('base64');
    return `Basic ${b64}`;
}

const is_stripe_key_active = (key) => {
    return new Promise((resolve, rej) => {
        const opts = {
            hostname: 'api.stripe.com',
            port: 443,
            path: '/v1/events?limit=1',
            method: 'HEAD',
            auth: `${key}:`
        }

        https.request(opts, (res) => {
            resolve(res.statusCode === 200);
        }).on('error', (err) => {
            console.error(err);
            rej(null);
        }).end();
    });
};

let is_stripe_key_active_cached = null;
const get_cached_is_stripe_key_active = () => {
    return is_stripe_key_active_cached;
};

const watch_stripe_key_active = async () => {
    const one = async () => {
        try {
            is_stripe_key_active_cached = await is_stripe_key_active(get_stripe_key());
        } catch (e) {
            // Do not crash server on occasional HTTP/network errors; just retry later.
            is_stripe_key_active_cached = false;
            console.error(e);
        }
    };

    // On server-start check the key right away.
    await one();

    return setInterval(one, 30 * 1000);
};


const stripe_key_matches_config = (http_req_key) => {
    const config_key = get_stripe_key();

    return (
        typeof http_req_key === "string" &&
        http_req_key === config_key
    )
};


// @see https://dev.to/edemagbenyo/nodejs-authentication-with-http-basic-access-part-1-ii2
const ret_401 = (res, ip, message, trigger_pw_prompt = false) => {
    const headers = {
        'Content-Type': 'text/plain',
        'TableDog-Auth-Error': message
    }

    if (trigger_pw_prompt) {
        headers['WWW-Authenticate'] = 'Basic';
    }

    log_ip(ip, `401 ${message}`);
    res.writeHead(401, headers);
    res.end(`${message}`);
};

// const ret_200_redirect_home = (res) => {
//     res.writeHead(200, {
//         'Content-Type': 'text/html'
//     });
//     res.end(`<script>window.location.href = window.location.href</script>`);
// };


const get_user_from_headers = (req) => {
    const a = req.headers.authorization;
    if (!a) {
        return null;
    }

    const [user, pass] = Buffer.from(a.split(' ')[1], 'base64').toString().split(':');
    if (user.length === 0) {
        return null;
    }

    return user;
};

const log = (msg) => {
    console.log(`[${(new Date).toISOString()}] INFO ${msg}`);
}

const log_ip = (ip, msg) => {
    log(`[${ip}] ${msg}`);
}

// Important: This proxy should only be used behind a proxy that terminates HTTPS/TLS and sets the `X-Forwarded-For` header to the real client's IP.
// - TLS will encrypt the connection to protect the plain text HTTP basic auth password.
// - The TLS-terminating proxy will ensure that `X-Forwarded-For` is set to the real IP (and not input by an attacker).
const get_real_ip = (req) => {
    // No proxy used during dev.
    let ip = req.socket.remoteAddress;

    const is_proxy_used = ('x-forwarded-for' in req.headers && typeof req.headers['x-forwarded-for'] === "string" && req.headers['x-forwarded-for'].length > 7);
    if (is_prod && !is_proxy_used) {
        console.error("Could not read client IP. Ensure that the TLS-terminating proxy sets the header x-forwarded-for. In dev or local-only mode, set NODE_ENV=development to ignore this error (traffic will NOT be encrypted; password exposed to network).");
        process.exit(1);
    }

    if (is_prod) {
        // This is a CSV of the proxy path, first item is the client address, subsequent ones are IP of proxies.
        ip = req.headers['x-forwarded-for'].replaceAll(/\s/g, "").split(",")[0];
    }

    // @see https://fly.io/docs/reference/runtime-environment/
    if ("Fly-Client-IP" in req.headers) {
        if (req.headers["Fly-Client-IP"] !== ip) {
            console.error(`HTTP request header for Fly-Client-IP should match x-forwarded-for. ${req.headers["Fly-Client-IP"]} vs ${ip}.`);
            process.exit(1);
        }
    }

    return ip;
};


const run_auth_checks = (client_req, client_res, ip) => {

    // No password given.
    const stripe_key_from_req = get_user_from_headers(client_req);
    if (stripe_key_from_req === null) {
        ret_401(client_res, ip, 'No Stripe key passed in HTTP request basic auth `user` field. Set it in the HTTP request header `authorization: Basic ...` (identical to the official Stripe API).', true);
        return {result_sent: true};
    }

    // Too many guesses.
    if (
        get_count_incorrect_guesses_for_ip_today(ip) >= max_incorrect_daily_pass_guesses_per_ip ||
        guesses.total_guesses >= max_incorrect_daily_pass_guesses
    ) {
        ret_401(client_res, ip, 'Too many incorrect auth guesses.');
        return {result_sent: true};
    }


    // @todo/maybe One Stripe API key per staff user.
    // - Can revoke each staff user individually.
    //      - Check key is valid for each request, poll in background.
    // - Datasette server gets its own key.

    // Key does not match.
    if (!stripe_key_matches_config(stripe_key_from_req)) {
        increment_guess_count_for_ip(ip);
        log_ip(ip, `Incremented daily guess count for IP, current IP count is ${get_count_incorrect_guesses_for_ip_today(ip)}, current total count is ${guesses.total_guesses}.`);
        ret_401(client_res, ip, 'Incorrect Stripe key. Please check you have the correct one from the Stripe developer console.', true);
        return {result_sent: true};
    }

    // Stripe key is not active.
    if (!get_cached_is_stripe_key_active()) {
        ret_401(client_res, ip, 'Stripe key is not active. Has it been disabled?', true);
        return {result_sent: true};
    }

    return {result_sent: false};
};

const health_check = async (client_req, client_res, ip) => {
    let datasette_server = false;
    let tdog_cli_heartbeat = false;
    let sqlite_db_integrity_check = false;


    // Used to attach health monitoring (SMS admin on issue, graph of historical uptime records).
    if (client_req.url === "/tdog/health.json") {
        // log_ip(ip, `200 /tdog/health.json`);
        client_res.writeHead(200, {'Content-Type': 'application/json'});


        try {
            const a = await exec(`curl -s -o /dev/null -w "%{http_code}" --unix-socket ${target.socketPath} http://x`);
            datasette_server = (a.stdout === '200');


            const b = await exec(`sqlite3 ${tdog_db} "SELECT heartbeat_ts FROM td_metadata LIMIT 1"`);
            if (typeof b.stdout === 'string' && b.stdout.length > 4) {
                const seconds_since_last_events_apply = (((new Date()).getTime() / 1000) - (new Date(b.stdout).getTime() / 1000));
                // Note: this needs to match the config for polling frequency, and take into account reboots/deploys.
                if (seconds_since_last_events_apply < (60 * 10)) {
                    tdog_cli_heartbeat = true;
                }
            }

            sqlite_db_integrity_check = /^ok/.test((await exec(`sqlite3 ${tdog_db} "PRAGMA integrity_check"`)).stdout);
        } catch (e) {
            console.error(e);
        }

        const x = {
            ok: datasette_server && tdog_cli_heartbeat && sqlite_db_integrity_check,
            items: {
                tdog_cli_heartbeat,
                datasette_server,
                sqlite_db_integrity_check
            }
        };

        client_res.end(`${JSON.stringify(x, null, 4)}`);
        return true;
    }

    return false;
}


// @see https://nodejs.org/en/knowledge/advanced/streams/how-to-use-stream-pipe/
const on_req = async (client_req, client_res) => {
    const ip = get_real_ip(client_req);

    if (await health_check(client_req, client_res, ip)) {
        return;
    }

    const {result_sent} = run_auth_checks(client_req, client_res, ip);
    if (result_sent) {
        return;
    }
    // If no 401 response at this stage, user has authenticated successfully.


    // Datasette crashes when statically serving content that can change.
    if (client_req.url === "/tdog/cli_log.txt") {
        log_ip(ip, `200 /tdog/cli_log.txt`);
        client_res.writeHead(200, {'Content-Type': 'text/plain'});
        const log = createReadStream(tdog_log_file);
        log.pipe(client_res, {
            end: true
        });
        return;
    }

    // Datasette loads the backup SQL dump into RAM which crashes VM.
    // - Datasette also does not allow SQLite file download unless CLI started in immutable mode.
    if (client_req.url === "/tdog/stripe.sqlite") {
        const now_ms = (new Date()).getTime();
        const target_db_file = `/tmp/bu-${now_ms}.sqlite`;
        await exec(`sqlite3 ${tdog_db} ".backup ${target_db_file}"`);
        const db_file = createReadStream(target_db_file);

        log_ip(ip, `200 /tdog/stripe.sqlite`);
        client_res.writeHead(200, {
            'Content-Type': `application/x-sqlite3`,
            'Content-disposition': 'attachment;filename=stripe.sqlite'
        });

        const stream = db_file.pipe(client_res, {
            end: true
        });
        stream.on('finish', () => fs.unlinkSync(target_db_file));

        return;
    }


    // Datasette instance will log all granted requests.

    const opts = {
        ...target,
        path: client_req.url,
        method: client_req.method,
        headers: client_req.headers
    };

    const proxy_req = http.request(opts, (proxy_res) => {
        // When using unix socket, Datasette does not log IP of requests.
        // - Log the IP for use as an audit trail.
        log_ip(ip, `Forwarding ${client_req.url}`);

        client_res.writeHead(proxy_res.statusCode, proxy_res.headers);

        proxy_res.pipe(client_res, {
            end: true
        });
    }).on('error', (err) => {
        client_res.writeHead(502, {'Content-Type': 'text/plain'});
        // Issue: Some Datasette plugins require write access to the SQLite DB (`saved-queries`), and will exit the Datasette server if they cannot attain a lock. tdog will lock the DB for 10 min+ during the first download.
        // Fix, temp: Do not use plugins that require DB lock on boot up.
        // Fix: Serve `tdog` log from this proxy, link to it in this message, allow `flyctl reboot` when download is complete.
        client_res.end(`Could not reach Datasette server.`);
    });

    client_req.pipe(proxy_req, {
        end: true
    });
}


const start_server = () => {
    watch_stripe_key_active().then(() => {
        http.createServer(on_req).listen(proxy.port, proxy.ip);
        log(`HTTP proxy listening on ${proxy.ip}:${proxy.port}, forwarding HTTP requests to ${JSON.stringify(target)}.`)
    });
};


start_server();

