#!/bin/sh

cd /var/www/html

php artisan migrate --force
php artisan db:seed
php artisan optimize:clear