#!/bin/sh

# Run this cmd from within the php container.
cd /var/www/html

mkdir -p storage/framework/cache storage/framework/sessions storage/framework/testing storage/framework/views storage/app/public
