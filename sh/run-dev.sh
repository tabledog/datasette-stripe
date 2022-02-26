#!/bin/bash
# Exit immediately on failure.
set -e;

parent_dir=`dirname "$BASH_SOURCE"`;
"$parent_dir"/build.sh;

docker run -it \
    -e NODE_ENV='development' \
    -e STRIPE_SECRET_KEY='rk_test_...' \
    -v /host/data:/data \
    -p 3000:3000 \
    datasette-stripe;