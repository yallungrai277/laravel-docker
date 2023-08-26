## Laravel Docker

Laravel setup with docker.

## Stack

-   Inertia
-   Vue2
-   Laravel 10.10
-   Mariadb
-   Redis
-   Vite
-   Node / NPM

## Installation

-   cp .env.example .env (Required for setting app name for docker containers, configure any env variables as you need, any changes in container specific variables may need tweaking in other areas, so best to leave as it is and proceed)
-   docker compose build --no-cache && docker compose up -d (Build up all containers)
-   docker exec -it dockerize-laravel_app composer install (Please check your container names depeding on your .env file, it should be APP_NAME_app)
-   docker exec -it dockerize-laravel_app php artisan migrate
-   docker exec -it dockerize-laravel_app php artisan db:seed
-   docker exec -it dockerize-laravel_app php artisan storage:link (Create storage symlink)

Note: The container is set up so that there is already a vite server for development purposes.

## Urls

You can access the services in following urls. Check `docker-compose.yml` for available containers.

-   `localhost` (Laravel app)
-   `localhost:1025` (MailHog)
-   `localhost:8080` (Phpmyadmin)
-   `localhost:5173` (Vite server)

## Installing packages

1. Composer packages

To install composer packages or any composer related commands run the command inside the `dockerize-laravel_app` container. Please check the container using `docker compose ps`.

> docker exec -it dockerize-laravel_app composer require spatie/laravel-permission

2. Npm packages

To install node packages run command inside the `dockerize-laravel_node` container. Please check the container name before hand.

> docker exec -it dockerize-laravel_node npm install sass

## Ssh into container

To ssh inside a container.

> docker exec -it **container_name** /bin/sh

## Queues

In order to process queues [`laravel horizon`](https://laravel.com/docs/10.x/horizon) has been used. Run horizon via command:

> docker exec -it dockerize-laravel_app php artisan horizon (Check container names if you have modified .env APP_NAME)

## Test

1. Unit test

> docker exec -it dockerize-laravel_app php artisan test --testsuite=Unit

2. Feature test

> docker exec -it dockerize-laravel_app php artisan test --testsuite=Feature
