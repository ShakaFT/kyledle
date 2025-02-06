#!/bin/bash
# This script should be used to deploy Kyledle on VPS

git pull

wait_for_service() {
    local url=$1
    local max_retries=60
    local sleep_time=1

    echo "Waiting for service at $url to be ready..."
    for i in $(seq 1 $max_retries); do
        if curl -s --head --fail "$url" >/dev/null; then
            echo "Service at $url is ready!"
            return 0
        fi
        echo "Service not ready, retrying in $sleep_time seconds... ($i/$max_retries)"
        sleep $sleep_time
    done

    echo "Service at $url failed to start after $max_retries attempts."
    exit 1
}

if [ "$1" = "prod" ]; then
    sudo supervisorctl restart kyledle-prod-backend
    wait_for_service "http://localhost:8082"
    sudo supervisorctl restart kyledle-prod-frontend
    wait_for_service "http://localhost:5175"
    sudo supervisorctl restart kyledle-prod-nginx
elif [ "$1" = "dev" ]; then
    sudo supervisorctl restart kyledle-dev-backend
    wait_for_service "http://localhost:8081"
    sudo supervisorctl restart kyledle-dev-frontend
    wait_for_service "http://localhost:5174"
else
    echo "Exit! Missing first parameter"
    exit 1
fi
