ARG PHP_IMAGE

FROM ${PHP_IMAGE} as php

ENV USER=laravel
ENV GROUP=laravel

# Add user by first creating a group, attaching the user to /bin/sh shell with name laravel.
RUN adduser -g ${GROUP} -s /bin/sh -D ${USER}

# Replace user and group.
RUN sed -i "s/user = www-data/user = ${USER}/" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${GROUP}/" /usr/local/etc/php-fpm.d/www.conf
# Depending on host machine the group and user for our files and directories
# can be copied over from our local machine to containers and sometimes causing permission
# issues hence, we combat this by creating our own group and user.

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

# launch PHP-FPM with the specified configuration file, and it will restart gracefully
# when the container receives a stop signal.
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
