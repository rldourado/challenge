# Challenge

## Instructions

#### Prerequisites

- Docker with Compose - Follow instructions [here](https://docs.docker.com/engine/install/ubuntu/ "Install Docker Engine on Ubuntu")
- k3d (💻 [Install Instructions](https://k3d.io/))
- kubectl (💻 [Install Instructions](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/))
- postman (💻 [Install Instructions](https://www.postman.com/))
- helm (💻 [Install Instructions](https://helm.sh/))
- wrk benchmark tool (💻 [Install Instructions](https://github.com/wg/wrk))

#### How to build and run locally

Copy `.env-sample` to `.env` and edit the last one setting up environment variables like example bellow:

```
MARIADB_DATABASE=challenge
MARIADB_USER=challenge
MARIADB_PASSWORD=changeme
MARIADB_ROOT_PASSWORD=changemeroot
MARIADB_LOCAL_PORT=3306
MARIADB_DOCKER_PORT=3306

NODE_LOCAL_PORT=3000
NODE_DOCKER_PORT=3000

TYPEORM_CONNECTION=mysql
TYPEORM_HOST=mariadb
TYPEORM_USERNAME=challenge
TYPEORM_PASSWORD=changeme
TYPEORM_DATABASE=challenge
TYPEORM_PORT=3306
TYPEORM_SYNCHRONIZE=true
TYPEORM_LOGGING=true
TYPEORM_ENTITIES=./dist/**/entity/*.js,./src/entity/*.js
```

Then run:

```
$ docker compose up -d
```

This will run a MariaDB locally (accessible by `$MARIADB_LOCAL_PORT` port) and the app (on `$NODE_LOCAL_PORT` port).

To see if the database and application is running, just use:

```
$ docker compose ps
```

To stop both:

```
$ docker compose down
```

#### Running Locally inside a k8s cluster

To simulate k8s cluster locally using k3d (k3s in docker):

```
cd infra
./k3d-run.sh
```

To stop k3s cluster and clean:

```
./k3d-destroy.sh
```

#### Testing

Create test posts

```
cd infra
./load-test.sh
```

#### Benchmark Application

```
wrk -t50 -c500 -d30s http://localhost:8080/posts
```

Get all posts

```
curl -v http://localhost:8080/posts
```

Get one post

```
curl -v http://localhost:8080/posts/<id>
```

## Github Actions

#### Secrets:

USER_NAME <br />
USER_EMAIL <br />
DOCKER_USERNAME <br />
DOCKER_PASSWORD <br />

AWS_ACCESS_KEY_ID <br />
AWS_SECRET_ACCESS_KEY <br />
KUBECONFIG <i>(base64 encoded)</i> <br />

#### Variables:

AWS_REGION <br />
NAMESPACE <br />

#### Status

[![Build](https://github.com/rldourado/challenge/actions/workflows/build.yml/badge.svg)](https://github.com/rldourado/challenge) [![Linter](https://github.com/rldourado/challenge/actions/workflows/linter.yml/badge.svg)](https://github.com/rldourado/challenge) [![Deploy](https://github.com/rldourado/challenge/actions/workflows/deploy.yml/badge.svg)](https://github.com/rldourado/challenge)
