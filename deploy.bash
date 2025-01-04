#!/bin/bash
# This script should be used to deploy Kyledle on VPS

git pull

if [ "$1" = "prod" ]; then
    sudo supervisorctl restart kyledle-prod-backend
    sudo supervisorctl restart kyledle-prod-frontend
elif [ "$1" = "dev" ]; then
    sudo supervisorctl restart kyledle-dev-backend
    sudo supervisorctl restart kyledle-dev-frontend
else
    echo "Exit! Missing first parameter"
    exit 1
fi
