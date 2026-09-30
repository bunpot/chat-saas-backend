#!/bin/bash
set -e

sleep 5

php artisan migrate --force
php artisan config:cache
php artisan route:cache
php artisan view:cache

php artisan reverb:start --host=0.0.0.0 --port=8080 &

php-fpm -D
nginx -g 'daemon off;'