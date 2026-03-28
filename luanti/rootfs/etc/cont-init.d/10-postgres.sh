#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

bashio::log.info "Initializing PostgreSQL database directory..."

mkdir -p /data/postgres
chown -R postgres:postgres /data/postgres

if [ ! -s /data/postgres/PG_VERSION ]; then
    bashio::log.info "Running initdb..."
    su-exec postgres initdb -D /data/postgres
    
    # Configure authentication for local trust
    echo "host all all 127.0.0.1/32 trust" >> /data/postgres/pg_hba.conf
    echo "local all all trust" >> /data/postgres/pg_hba.conf
fi
