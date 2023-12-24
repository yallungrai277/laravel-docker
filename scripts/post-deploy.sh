#!/bin/sh

cd /var/www/html

php artisan migrate
php artisan db:seed
php artisan optimize:clear