ARG NODE_IMAGE
ARG PHP_IMAGE

FROM ${NODE_IMAGE} AS node

FROM ${PHP_IMAGE} as php

# Install required extensions for Laravel, other extensions are already installed and present in the php fpm alpine image.
RUN docker-php-ext-install bcmath pdo pdo_mysql

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer
COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY . .

RUN composer install --no-interaction --prefer-dist

# Copy node binaries by. @todo figure out a better way to handle this in alpine php image that uses alpine linux.
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

# Add a command here that runs npm run production.

CMD ["php-fpm", "-F"]
