// @see https://fly.io/docs/reference/secrets/
// - Set with `flyctl secrets set STRIPE_SECRET_KEY=rk_test_...`

const {
    STRIPE_SECRET_KEY: secret_key = null,
    TDOG_LICENSE: tdog_license = null,
} = process.env;


// @see https://github.com/tabledog/tdog/blob/master/config-creator/config.ts
const config = {
    "cmd": {
        "args": {
            "from": {
                "stripe": {
                    secret_key,
                    "max_requests_per_second": null
                }
            },
            "options": {
                "watch": true,
                "poll_freq_ms": 1000
            },
            "to": {
                "sqlite": {
                    "file": "/data/stripe.sqlite"
                }
            }
        },
        "fn": "download"
    },
    "log": "info"
};

if (typeof tdog_license === "string") {
    config.license = {
        key: tdog_license
    };
}


console.log(JSON.stringify(config, null, 4));