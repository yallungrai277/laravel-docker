#!/bin/sh

cd /var/www/html

# Runs command every minute
php artisan schedule:work > /tmp/cron.log