// JS based modifications to the Datasette web UI.

const is_safari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);

let s_down = false;

document.addEventListener('keydown', (e) => {
    if (e.code == "KeyS") {
        s_down = true;
        return;
    }
    s_down = false;
});

document.addEventListener('keyup', (e) => {
    s_down = false;
});


// When an ID is clicked whilst pressing 's', open the URL in Stripe.
window.on_id_click = (e) => {
    if (s_down) {
        // New window steals focus preventing keyup event.
        s_down = false;


        const q = e.currentTarget.innerHTML;
        const url = `https://dashboard.stripe.com/search?query=${q}`;

        window.open(url, '_blank');
        e.preventDefault();
    }

};

// E.g.
// - sub_sched_1JjpgUJo6Ja94JKPoY0NKwgB
// - rcpt_KmF4yOeNTb1bPiL1OxF8MzIuzZyIred
const id_re = /\b([a-z]{2,6}_(?:[a-z]{2,6}_)?(?=.{1,40}[A-Z])[a-zA-Z\d]{10,40})\b/g;

const td_replace_ids_with_links = (el) => {
    if (!("querySelectorAll" in el)) {
        return;
    }
    for (const cell of el.querySelectorAll("td")) {
        const orig = cell.innerHTML;


        if ("querySelectorAll" in cell && cell.querySelectorAll("a").length > 0) {
            // Ignore cells with links in them (datasette will add <a> to URLs).
            continue;
        }

        const replace = `<a onclick="on_id_click(event)" href="/-/search?q=$&">$&</a>`;
        const new_content = orig.replaceAll(id_re, replace);

        cell.innerHTML = new_content;
    }
};


const create_el = (html_string) => {
    var div = document.createElement('div');
    div.innerHTML = html_string.trim();

    // Change this to div.childNodes to support multiple top-level nodes.
    return div.firstChild;
};

const watch_dom_replace_td_links_on_add = () => {
    const cb = (mut_list, observer) => {
        for (const m of mut_list) {
            for (const x of m.addedNodes) {
                td_replace_ids_with_links(x);
            }
        }
    };


    const observer = new MutationObserver(cb);
    const config = {
        attributes: true,
        childList: true,
        subtree: true
    }
    observer.observe(document, config);
    // observer.disconnect();
};


// Signs the user out of HTTP basic auth.
// - An invalid sign in attempt clears the previous `Authorization` header saved in the browser cache.
// - Using `http://signout:pass@127.0.0.1/` does sign the user out, but seems to force the browser to keep the user/pass in the URL.
//      - This is an issue as it can not be unset, even with a correct sign in (that sends the real credentials via the auth header, along with the fake url credentials too).
const sign_out = (event = null) => {
    if (event) {
        event.preventDefault();
    }

    // JS xhr caches responses preventing a sign out.
    const no_cache = (new Date()).getTime();

    // Note: `fetch` will not allow setting auth header.
    // Invalid sign in clears browser cache, prevents it sending the `Authorization` header.
    const x = new XMLHttpRequest();
    x.open("GET", window.location.href + `?no_cache=${no_cache}`, true, "signout", "");
    x.withCredentials = true;
    x.onreadystatechange = () => {
        if (x.readyState === 4) {
            // Trigger the sign in dialog.
            setTimeout(() => {
                window.location.href = window.location.href;
                if (is_safari) {
                    // If the password is saved in macOS/Safari, it must be deleted from the Keychain.
                    window.open(`https://superuser.com/a/1296581`, "_blank");
                }
            }, 1000);
        }
    };
    x.send();
};


// HTTP basic auth is cached/sticky by default in browsers.
// - Do not keep auth details in cache forever (E.g. for browsers that are never closed, like sleeping laptops).
// - Closing the browser will clear the auth details (except on Safari with "remember = yes").
const sign_out_after_inactivity = () => {
    const k = 'last_page_load';
    const now = new Date();

    let last = localStorage.getItem(k);

    // Set last req to now.
    localStorage.setItem(k, now.toISOString());

    if (last === null) {
        return;
    }

    const last_seconds = (new Date(last)).getTime() / 1000;
    const now_seconds = now.getTime() / 1000;

    // 14 days.
    const max_seconds_without_activity = 14 * 24 * 60 * 60;

    if ((now_seconds - last_seconds) > max_seconds_without_activity) {
        sign_out();
        return;
    }
};


const add_tdog_log_to_menu = () => {
    const el = document.querySelector(".nav-menu-inner ul");


    if (el !== null) {
        el.appendChild(create_el(`<li><a href="/tdog/cli_log.txt">tdog CLI log</a></li>`));
        el.appendChild(create_el(`<li><a href="/tdog/stripe.sqlite">Download DB</a></li>`));
        el.appendChild(create_el(`<li><a href="#" onclick="sign_out(event)">Sign out</a></li>`));
    }

    const ft = document.querySelector("footer.ft");
    ft.innerHTML = `${ft.innerHTML} & <a href="https://github.com/tabledog/datasette-stripe" title="Table Dog">tdog</a>`;
};


document.addEventListener("DOMContentLoaded", () => {
    td_replace_ids_with_links(document);
    watch_dom_replace_td_links_on_add();
    add_tdog_log_to_menu();
    sign_out_after_inactivity();
});
