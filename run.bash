#!/bin/bash
# This script should be used to run restAPI locally.

# Clear Docker Images Cache
trap 'docker rmi $(docker images -f "dangling=true" -q) > /dev/null 2>&1' EXIT

function run_in_parrallel {
    # Open new terminal tab (on MacOS only)
    osascript <<EOF
    tell application "iTerm2"
        tell current window
            set originalTab to current tab
            create tab with default profile
            tell current session of current tab
                write text "$1"
            end tell
            select originalTab
        end tell
    end tell
EOF
}

RUN_FRONTEND=true
RUN_BACKEND=true
if [[ "$@" =~ "-frontend" || "$@" =~ "-front" || "$@" =~ "-f" ]]; then
    RUN_BACKEND=false
elif [[ "$@" =~ "-backend" || "$@" =~ "-back" || "$@" =~ "-b" ]]; then
    RUN_FRONTEND=false
fi

export PROJECT_NAME="kyledle"
export REDIS_HOST="redis"
BACKEND_COMMAND="docker-compose -f docker-compose-backend.yml -f docker-compose-backend.prod.yml --env-file .env/.env.$1 -p $PROJECT_NAME-backend-$1 up --build"
FRONTEND_COMMAND="docker-compose -f docker-compose-frontend.prod.yml --env-file .env/.env.$1 -p $PROJECT_NAME-frontend-$1 up --build"

if [ "$1" = "prod" ]; then
    export BACKEND_PORT=8082
    export ENVIRONMENT="prod"
    export FRONTEND_PORT=5175
    export REDIS_PORT=6381
elif [ "$1" = "dev" ]; then
    export BACKEND_PORT=8081
    export ENVIRONMENT="dev"
    export FRONTEND_PORT=5174
    export REDIS_PORT=6380
else # local
    export BACKEND_PORT=8080
    export ENVIRONMENT="local"
    export FRONTEND_PORT=5173
    export REDIS_PORT=6379
    BACKEND_COMMAND="docker-compose -f docker-compose-backend.yml -p $PROJECT_NAME-backend-local --profile local up --build"
    FRONTEND_COMMAND="cd frontend && npm i && npm run dev"
fi

export ORIGINS="http://localhost:$FRONTEND_PORT"
export VITE_API_URL="http://localhost:$BACKEND_PORT"

PARRALLEL_COMMAND=$(
    cat <<EOF
export BACKEND_PORT=$BACKEND_PORT
export ENVIRONMENT=$ENVIRONMENT
export FRONTEND_PORT=$FRONTEND_PORT
export ORIGINS=$ORIGINS
export PROJECT_NAME=$PROJECT_NAME
export REDIS_HOST=$REDIS_HOST
export REDIS_PORT=$REDIS_PORT
cd $(pwd)
eval $BACKEND_COMMAND
EOF
)

if $RUN_BACKEND && $RUN_FRONTEND; then
    run_in_parrallel "$PARRALLEL_COMMAND"
elif $RUN_BACKEND; then
    eval "$BACKEND_COMMAND"
fi

if $RUN_FRONTEND; then
    eval "$FRONTEND_COMMAND"
fi
