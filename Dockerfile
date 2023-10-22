# Development Container
FROM node:20-alpine3.17 AS dev
RUN corepack enable

WORKDIR /app

EXPOSE 3000
