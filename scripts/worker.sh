#!/bin/sh

cd /var/www/html

PHP_MEMORY_LIMIT=10000M

while [ 1 -gt 0 ]; do # This creates an infinite loop.
  php -d memory_limit=${PHP_MEMORY_LIMIT} artisan horizon > /tmp/horizon.log
  sleep 3
done