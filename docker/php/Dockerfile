ARG PHP_IMAGE

FROM ${PHP_IMAGE} as php

# Install required extensions for Laravel, other extensions are already installed and present in the php fpm alpine image.
# pcntl required for laravel/horizon
RUN docker-php-ext-install bcmath pdo pdo_mysql pcntl

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer
COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY . .

RUN composer install --no-interaction --prefer-dist

CMD ["php-fpm", "-F"]
