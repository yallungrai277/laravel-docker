# Similar replica to ./docker/php/Dockerfile.prod -> just here for more visibility and needs to be tested on actual setup.
# Builds a production ready image ready to be used straight away without installing any composer or npm packages. 
# In future may be extend to have nginx here as well. 
ARG PHP_IMAGE=php:8.2-fpm-alpine
ARG NODE_IMAGE=node:16-alpine

FROM $NODE_IMAGE as node
FROM $PHP_IMAGE as php

LABEL maintainer="Sudip Rai <yallungrai277@gmail.com>"
LABEL description="Laravel production ready docker image"

ENV USER=laravel
ENV GROUP=laravel

RUN adduser -g ${GROUP} -s /bin/sh -D ${USER}

# Replace user and group.
RUN sed -i "s/user = www-data/user = ${USER}/" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i "s/group = www-data/group = ${GROUP}/" /usr/local/etc/php-fpm.d/www.conf

# Install required plugins
RUN docker-php-ext-install bcmath pdo pdo_mysql pcntl opcache

# Opcache for performance and caching
COPY ./docker/php/conf/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install Composer
COPY --from=composer:2.5.8 /usr/bin/composer /usr/bin/composer

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

COPY . .

# Also set the env to prod.
RUN mv -f .env.prod .env

RUN composer install && composer dump-autoload --optimize

RUN chmod +x scripts/prepare-storage.sh && ./scripts/prepare-storage.sh

# Create symlinks
RUN php artisan storage:link

# Copy node binaries from the previous node stage.
COPY --from=node /usr/lib /usr/lib
COPY --from=node /usr/local/share /usr/local/share
COPY --from=node /usr/local/lib /usr/local/lib
COPY --from=node /usr/local/include /usr/local/include
COPY --from=node /usr/local/bin /usr/local/bin

RUN chown -R ${USER}:${GROUP} .

RUN npm install && npm run build

# launch PHP-FPM with the specified configuration file, and it will restart gracefully
# when the container receives a stop signal.
CMD ["php-fpm", "-y", "/usr/local/etc/php-fpm.conf", "-R"]
