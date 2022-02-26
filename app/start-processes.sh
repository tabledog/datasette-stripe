#!/bin/bash
# This script starts multiple processes when the Docker container first starts.
# - Bash "background" and "foreground" used.
# - Fly.io inserts its own init process as PID 1, so this cannot be used.


# Turn on bash's job control.
set -m

# Check Stripe key is valid, if not do not start server.
KEY_VALID=$(curl -s -o /dev/null -w "%{http_code}" https://api.stripe.com/v1/events -u "$STRIPE_SECRET_KEY": -d limit=1 -G -I);
if [[ $KEY_VALID != '200' ]]; then
    echo "Error: Stripe API key ending '${STRIPE_SECRET_KEY: -3}' is not valid.";
    exit 1;
fi
echo "Stripe API key ending '${STRIPE_SECRET_KEY: -3}' is valid.";


# Volume mounted at /data.
mkdir -p /data/logs;

# @todo/maybe Logs: send to remote log collector.
# - Use Vector to copy logs from files, write to remote log collector, and truncate the log file after x hours.
# - Make the logs immutable for audit trail.
# - Prevent filling up disk.
# - Fly env vars to use to ID log: FLY_REGION/FLY_APP_NAME/FLY_ALLOC_ID.

# Store a copy of logs on volume, put in background (job 1).
TDOG_CONFIG=$(node /app/get-tdog-config.js);
tdog --json "$TDOG_CONFIG" >> /data/logs/tdog.txt 2>&1 &

# Wait for `tdog` to create `db.sqlite` (schema only, download begins after).
sleep 2;

# When: License/config invalid. No connection.
if [ ! -f /data/stripe.sqlite ]; then
    echo "Error: stripe.sqlite file does not exist. Check the tdog CLI logs for details.";
    exit 1;
fi

# Create FTS tables if they do not exist.
FTS_TABLES_EXIST=$(sqlite3 /data/stripe.sqlite "SELECT count(*) FROM sqlite_master WHERE type='table' AND name='td_metadata_fts';");
if [[ $FTS_TABLES_EXIST == '0' ]]; then
    # - Only create the indexes on first run.
    # - Wait until the download has completed, then create the FTS indexes (avoid impacting INSERT performance during the initial download).
    # - First download writes all contained within a single SQLite write transaction.
    # - Datasette will find these indexes and offer a "search" UI.
    node /app/sql-fts/get-sql-fts.js /data/stripe.sqlite > /app/sql-fts/fts-all-tables.sql;
    sleep 5 && sqlite3 -cmd ".timeout 2000000000" /data/stripe.sqlite < /app/sql-fts/fts-all-tables.sql &
fi


# Unix socket used to ensure that the unprotected Datasette instance cannot be reached by any network (internal or external).
# -h 0.0.0.0 == Reachable externally.
# -h 127.0.0.1 == Not reachable from outside.


datasette \
    --uds /tmp/datasette.sock \
    --metadata metadata.json \
    --static static:/app/static \
    /data/stripe.sqlite \
    2>&1 | tee --append /data/logs/datasette.txt &



node /app/auth-proxy/http-basic-auth.js 2>&1 | tee --append /data/logs/http-proxy.txt;


# fg %1