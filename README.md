# Django Starter

A basic Django boilerplate. 



Packages:
- uv
- picocss
- alpinejs


## Quickstart

In development:

- clone repo;
- uv sync;
- create the .env file;
- make migrate;
- make dev;

In production:

- update Caddyfile with your domain;
- docker network create web (one-time);
- switch DEBUG to 0;
- make collectstatic;
- make build;
- make start;
- make stop;
- make applogs;
- make proxylogs;







