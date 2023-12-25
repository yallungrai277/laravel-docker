#!/bin/sh

cd /var/www/html

php artisan migrate --force
php artisan db:seed --force
php artisan optimize:clear