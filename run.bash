#!/bin/bash
# This script should be used to run restAPI locally.

export REDIS_HOST="redis"

if [ "$1" = "prod" ]; then
    export ENVIRONMENT="prod"
    export NGINX_PORT=80
    export REDIS_PORT=6381
    export WEB_PORT=8082
    docker-compose -f docker-compose-backend.yml -f docker-compose-backend.prod.yml --env-file .env/.env.prod -p kyledle-prod up --build
    exit 0
elif [ "$1" = "dev" ]; then
    export ENVIRONMENT="dev"
    export NGINX_PORT=81
    export REDIS_PORT=6380
    export WEB_PORT=8081
    docker-compose -f docker-compose-backend.yml -f docker-compose-backend.prod.yml --env-file .env/.env.dev -p kyledle-dev up --build
    exit 0
fi

export ENVIRONMENT="local"
export REDIS_PORT=6379
export WEB_PORT=8080
docker-compose -f docker-compose.local.yml -f docker-compose-backend.yml -p kyledle-local up --build
