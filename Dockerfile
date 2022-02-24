FROM datasetteproject/datasette:latest

WORKDIR /app

# This adds a lot of build time:
# Note: datasette-jq requires `apt-get install build-essential` which places a C compiler in $PATH.

RUN apt-get update && apt-get install --yes curl sqlite3 htop xz-utils;


# Install Node.js (used for the HTTP proxy).
# @see https://github.com/nodejs/help/wiki/Installation#how-to-install-nodejs-via-binary-archive-on-linux
RUN curl --output node.tar.xz https://nodejs.org/dist/v16.14.0/node-v16.14.0-linux-x64.tar.xz && \
    mkdir -p /usr/local/lib/nodejs && \
    tar -xJvf node.tar.xz -C /usr/local/lib/nodejs && \
    rm node.tar.xz;

ENV PATH="/usr/local/lib/nodejs/node-v16.14.0-linux-x64/bin:${PATH}"

# Install tdog
RUN (cd ${HOME} && curl -O https://raw.githubusercontent.com/tabledog/tdog/0.4.0/archive/0.4.0/packages/apt-get/tdog_0.4.0-1_amd64.deb);
RUN apt-get install --yes -f ~/tdog_0.4.0-1_amd64.deb;


# Will be replaced with a volume at runtime.
RUN mkdir /data;

# Datasette plugins.
RUN datasette install datasette-rure && \
    datasette install datasette-copyable && \
    datasette install datasette-search-all && \
    datasette install datasette-graphql;


# Other Datasette plugins:
# datasette-auth-passwords
# Note: This slows down every HTTP request when using Docker/QEMU (probably due to cryptography functions taking a long time to emulate).
# datasette-cors
# datasette-write
# datasette-configure-fts
# datasette-saved-queries
# Note: This requires a database lock and results in the Datasette server exiting (E.g. during tdog first download when it has a 10 minute+ DB lock).
# datasette install datasette-backup
# Note: This loads the SQL dump into RAM which crashes the Datasette server.

# Copy to container image.
COPY app /app

# .sh used to start multiple processes.
RUN chmod +x /app/start-processes.sh

# HTTP auth proxy (not Datasette instance).
EXPOSE 3000
CMD ./start-processes.sh