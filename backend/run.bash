#!/bin/bash
# This script should be used to run restAPI locally.

if [[ "$1" =~ ^(prod|dev) ]]; then
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env/.env.$1 -p kyledle-$1 up
else
    docker-compose -f docker-compose.yml --env-file .env/.env -p kyledle-local up
fi
