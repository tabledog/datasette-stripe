# Datasette, Stripe and `tdog`

Or: Stripe Sigma Alternative

- [Datasette](https://datasette.io/) is a web GUI for exploring SQLite datasets.
- [Stripe](https://stripe.com/) handles online payments. [Sigma](https://stripe.com/sigma) is their SQL analytics web
  GUI.
- [Table Dog](https://table.dog) is a CLI that converts your Stripe account to a SQLite database file.

This repo is a web app that runs Datasette and the `tdog` CLI in a single container to give you a fast real-time SQL
interface to your Stripe account.

Demo: [https://datasette-stripe.fly.dev/stripe](https://datasette-stripe.fly.dev/stripe).

## Notable features

- Full text search across all of your Stripe data.
	- Hold `s` when clicking ID's to open in the Stripe web UI.
- Real time.
	- Polls `/events`, applies changes to your SQLite database.
- Sharable URL's.
	- Share queries as URLs with your team.
	- Export tables to Excel.
- Snapshot your SQLite database.
	- Download with `curl`, HTTP basic auth mirrors Stripes API.
	- Save to file based storage (Dropbox etc) so that you can reproduce query results.
	- Use a local DB GUI.
	- Query using Python or another language.
- Health checks.
	- `/tdog/health.json` allows uptime monitoring (attach
	  to [Google Cloud Monitoring](https://cloud.google.com/monitoring/alerts)).
- GraphQL and JSON API's included.
	- Datasette allows you to use `curl` to get any SQL or GraphQL result set as JSON.
	- This allows you to do [complex joins very efficiently](https://simonwillison.net/2020/Aug/7/datasette-graphql/) as
	  they are powered by SQLite underneath.
	- These APIs can be used from a backend server to query Stripe state without having to handle webhooks or SQL servers and schemas.
- Mirrors your Stripe API key.
	- Revoke your key to block all HTTP access to the instance.
- Very responsive.
	- The combination of SQLite and a Fly.io instance at the network "edge" minimize any network hops.
- Single Docker container.
	- Can be run on your local laptop or other Docker environment.

## Security

HTTPS/TLS and HTTP basic auth protects the Datasette instance (and the Stripe/SQLite data loaded into it). See the
proxy [readme.md](./app/auth-proxy/readme.md) for more details.

## Docker Run

Run a local copy with these commands:
- `git clone https://github.com/tabledog/datasette-stripe && cd datasette-stripe`
- `docker build . -t datasette-stripe`
- `docker run -it -e NODE_ENV='development' -e STRIPE_SECRET_KEY='rk_test...' -v /host/data:/data -p 3000:3000 datasette-stripe`
- You will now have:
	- A Datasette instance running at `http://127.0.0.1:3000` (use HTTPS in production).
	- A SQLite database containing your Stripe account located at `/host/data/stripe.sqlite`.
- Note: The env var `TDOG_LICENSE` should be set to your [tdog license](https://table.dog/high-detail.html#pricing) for production Stripe accounts.

## Run this web app for free with Fly.io

Fly.io is like Heroku for Docker containers. They deploy your web app to the closest region to you, manage HTTPS/TLS
certificates and OS updates. You give them a single Docker container (this repo), and they handle the rest.

**1. Create a Fly.io account**

- [Install the CLI](https://fly.io/docs/hands-on/installing/).
- `fly auth signup`

**2. Create Fly app.**

- Your app name will become your URL name: `https://{your_app_name}.fly.dev/`
- `git clone` this repo, cd to it in your terminal.
- Change `app` name in fly.toml to `{your_app_name}` (must be globally unique).
- `fly apps create`
	- View current app with `fly status`.
	- The current app will be the one named in `fly.toml`. Commands operate on this app.

**3. Create volume.**

- Run `fly volumes create volume_tdog --region lhr --size 1;`
- This is where the `stripe.sqlite` database and logs are stored. These persist between VM reboots.

**4. Set secrets.**

- Create a new restricted key with **read-only** for
  everything [https://dashboard.stripe.com/apikeys](https://dashboard.stripe.com/apikeys).
- `fly secrets set STRIPE_SECRET_KEY=rk_test_...`
- `fly secrets set TDOG_LICENSE=...` [tdog license](https://table.dog/high-detail.html#pricing).
- API keys are never hard coded into Docker images or logs.
- Remember to clear your shell history after setting this.

**5. Deploy instance.**

- `fly deploy`
- `fly open`
	- Opens URL to app in your browser.
	- The HTTP basic auth username is the same as the `STRIPE_SECRET_KEY`, leave the password blank. This is identical
	  to Stripes API authentication.
	- The `tdog` CLI will do a full download on first boot which could take a while, view the progress via the logs (link in the top right burger menu of Datasette).
- `fly logs`
	- Fly.io VM provisioning logs - any issues will be shown here.
- `fly ssh console`
	- `htop` to see processes.

**Deleting.**

- `fly apps destroy {your_app_name}`
	- This will destroy the volume and secrets that belong to this app.

**Related**

- [Fly billing page](https://fly.io/organizations/personal) - Keep an eye on usage here. A single VM can be left on for
  free under the "free tier".
- If you like the demo but are non-technical, I can set up a Datasette instance for your Stripe account.
	- Contact me at [table.dog.hq@gmail.com](mailto:table.dog.hq@gmail.com). Thanks!