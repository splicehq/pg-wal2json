#!/bin/bash

set -e

# The postgresql.conf file is the main config file for the PG server.
cat <<EOF >> "/etc/postgresql/postgresql.conf"
# Enable SSL.
ssl = on
ssl_cert_file = '/ssl/server.crt'
ssl_key_file = '/ssl/server.key'

# Tell the server to listen for connections on all network interfaces.
listen_addresses = '*'

# The wal_level must be set to "logical".
wal_level = logical
EOF

# Create a database that changes will be published from.
createdb "$REP_DB"

# Create a replication role with login permission. These credentials will be used to connect to the
# master from the listener instance.
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<EOSQL
CREATE ROLE $REP_USER WITH REPLICATION LOGIN PASSWORD '$REP_PASSWORD';
EOSQL
