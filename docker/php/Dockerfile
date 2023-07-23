FROM php:8.2-fpm-alpine as php

# Install required extensions for Laravel, other extensions are already installed and present in the php fpm alpine image.
RUN docker-php-ext-install bcmath pdo pdo_mysql

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer
COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY . .

RUN composer install --no-interaction --prefer-dist
