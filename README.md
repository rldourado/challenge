# Challenge

[![Linter](https://github.com/rldourado/challenge/actions/workflows/linter.yml/badge.svg)](https://github.com/rldourado/challenge)

[![Deploy](https://github.com/rldourado/challenge/actions/workflows/deploy.yml/badge.svg)](https://github.com/rldourado/challenge)

## Instructions

#### Prerequisites

- Docker with Compose - Follow instructions [here](https://docs.docker.com/engine/install/ubuntu/ "Install Docker Engine on Ubuntu")

#### How to build and run locally

Copy `.env-sample` to `.env` and edit the last one setting up environment variables like example bellow:

```
MARIADB_DATABASE=chalenge
MARIADB_USER=chalenge
MARIADB_PASSWORD=changeme
MARIADB_ROOT_PASSWORD=changemeroot
MARIADB_LOCAL_PORT=3306
MARIADB_DOCKER_PORT=3306

NODE_LOCAL_PORT=3000
NODE_DOCKER_PORT=3000
```

Then run:

```
$ docker compose up -d
```

This will run a MariaDB locally (acessible by `$MARIADB_LOCAL_PORT` port) and the app (on `$NODE_LOCAL_PORT` port).

To see if the database and application is running, just use:

```
$ docker compose ps
```

To stop both:

```
$ docker compose down
```

## Github Actions
#### Secrets:

AWS_ACCESS_KEY_ID <br />
AWS_SECRET_ACCESS_KEY <br />
KUBECONFIG <i>(base64 encoded)</i> <br />

#### Variables:

AWS_REGION <br />
NAMESPACE <br />
