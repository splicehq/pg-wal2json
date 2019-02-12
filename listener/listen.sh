#!/bin/bash

set -e

# Wait for the master database server to become available on port 5432.
wait-for-it master:5432

# Connect to the master and create a replication slot configured to use wal2json.
pg_recvlogical --dbname "$REP_DB" --slot "$REP_SLOT" --create-slot --plugin wal2json

# Start receiving data from the master and pretty print the output to STDOUT.
pg_recvlogical --dbname "$REP_DB" --slot "$REP_SLOT" --start --option pretty-print=1 --file -
