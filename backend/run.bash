#!/bin/bash
# This script should be used to run restAPI locally.

export REDIS_HOST="redis"

if [ "$1" = "prod" ]; then
    export ENVIRONMENT="prod"
    export NGINX_PORT=80
    export REDIS_PORT=6381
    export WEB_PORT=8082
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env/.env.prod -p kyledle-prod up --build
    exit 0
elif [ "$1" = "dev" ]; then
    export ENVIRONMENT="dev"
    export NGINX_PORT=81
    export REDIS_PORT=6380
    export WEB_PORT=8081
    docker-compose -f docker-compose.yml -f docker-compose.prod.yml --env-file .env/.env.dev -p kyledle-dev up --build
    exit 0
fi

# Refresh Python Virtual Environment
REQUIREMENTS_FILENAME=requirements.txt
VENV_PATH=.venv
VENV_REQUIREMENTS_PATH=$VENV_PATH/$REQUIREMENTS_FILENAME

if [ ! -d $VENV_PATH ]; then
    echo "Virtual environment creation processing..."
    python3.12 -m venv $VENV_PATH --upgrade-deps
fi

source $VENV_PATH/bin/activate

if ! cmp -s $REQUIREMENTS_FILENAME $VENV_REQUIREMENTS_PATH; then
    echo "Updating local dependencies..."
    pip install --upgrade pip
    pip install -r $REQUIREMENTS_FILENAME

    cp $REQUIREMENTS_FILENAME $VENV_REQUIREMENTS_PATH
fi

# Docker Compose
export ENVIRONMENT="local"
export REDIS_PORT=6379
export WEB_PORT=8080
docker-compose -f docker-compose.yml -p kyledle-local up --build