# HTTP Basic Auth proxy

Authentication mirrors [Stripe's HTTP Basic Authentication](https://stripe.com/docs/api/authentication).

**This proxy:**

- A. Receives plain HTTP requests from an HTTPS/TLS terminating proxy (e.g. from Fly.io).
- B. Checks if the Basic auth username matches the Stripe key set via the environment variable `STRIPE_SECRET_KEY`.
- C. If so, it forwards the plain HTTP request to the Datasette instance.

## Protection from brute force password guessing.

This proxy protects against brute force password guessing by blocking requests from IP's once they have reached a daily
quota. A global daily quota is also set in the case of an attacker with a large pool of IP addresses.

## End user can revoke their API key.

An end user can block all requests to their Datasette instance by revoking their API key in the Stripe developer
console. This proxy polls the API key to make sure if it is still active, if not all requests are blocked.

In this way the Datasette instance acts as a light SQL based data-cache/proxy/wrapper to their Stripe account.

## Datasettes HTTP API.

Datasette provides an HTTP API that can be used from HTTP clients in scripts (e.g. Python, curl). HTTP basic
authentication is used to enable this (similar to the official Stripe API).

HTTP API examples:

- SQL request, JSON response.
- GraphQL request, JSON response.
- Backup URL, plain text/SQL dump.

## Assumptions

- Single server that is always on.
	- State stored in RAM; rebooting the process clears the state.
	- If the process crashes, the Fly VM will reboot which will slow the guess rate by at least 10s per guess.
		- A process manager that "fast-restarts" the process on fail would be an issue (a fix would be to persist the
		  guess state to disk).
	- Will not work with Cloud Run or other "scale out" container schedulers (single instance needed for SQLite db
	  anyway).

# Future changes

- Write in Golang.
	- Issue: Node.js install adds 130MB to Docker image (via nodesource.com).
	- Issue: Node.js uses 50MB RAM (but very little CPU).
		- Datasette uses RAM for large downloads E.g. (`/-/backup/stripe.sql`), which results
		  in `Out of memory: Killed process`.
			- Fix: Increase VM RAM, use SQLite backup API + Node.js streams (db-a -> db-b -> stream over HTTP).

- Google Authenticator 2FA for users who will not be using the Datasette HTTP API.

# Alternatives

- Datasette `datasette-auth-passwords` plugin.
	- This works, but the issue is that it does not allow:
		- Rate limiting incorrect guesses (but uses a strong-slow-to-compute hash function so does not need it).
		- Using the username as the password to mimic the Stripe API.
		- Polling the Stripe API to ensure the API key is still valid.

- Nginx/Caddy/lighthttpd.
	- These all have support for HTTP basic auth, but would require significant config to store state for the
	  IP/incorrect-guess counters.
		- Question: Guess rate limiting may not be needed as Stripe's keys are large (62^100).
	- Directly coding logic in Node.js/Golang seems easier that starting with a config language and adding
	  scripting/state to it.

# Related

- [https://www.quora.com/Why-does-Stripe-use-HTTP-Basic-Auth-with-a-token-instead-of-a-header](https://www.quora.com/Why-does-Stripe-use-HTTP-Basic-Auth-with-a-token-instead-of-a-header)
	