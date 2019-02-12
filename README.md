# Postgres wal2json example

This repo provides a minimal config for reading [Postgres logical
replication][1] data using the [wal2json][2] plugin.

This is not intended in any way to be put into production. Instead it's a
starting point for understanding how to configure wal2json and an easy way of
testing configuration changes.

## Getting started

You'll first need to install Docker if you haven't already.

Docker Compose is used to set up two containers, one acting as the master
database instance and the second as a listener that's receiving replication data
in the `wal2json` format.

To build the containers for the first time, run:

```
docker-compose build
```

You can then start the containers by running:

```
docker-compose up
```

And stop them by running:

```
docker-compose down
```

The master database is mapped to local port 5500, and you can connect to it
using `psql`:

```
psql --port 5500 --host 0.0.0.0 --user postgres
```

The subscriber uses [pg_recvlogical][3] to connect to the master and write the
logical replication data to STDOUT in the `wal2json` format.

You can check the replication status by running this query on the master:

```
SELECT * FROM pg_stat_replication;
```

[1]: https://www.postgresql.org/docs/11/logical-replication.html
[2]: https://github.com/eulerto/wal2json
[3]: https://www.postgresql.org/docs/11/app-pgrecvlogical.html

## Understanding the configuration

It'll help to have some familiarity with Docker.

The `docker-compose.yml` file configures two services, `master` and `listener`.
The two containers share a network called `db` so that they can communicate.

To understand how the `master` and `listener` containers are configured, look at
the files in the `master` and `listener` directories. There are comments in each
file to explain what's going on.
