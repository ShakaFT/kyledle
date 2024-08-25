#!/bin/bash
# This script should be used to run a Python script.

if [ ! -d .venv ]; then
    echo "Virtual environment creation processing...\n"
    python3.12 -m venv .venv --upgrade-deps
fi

source .venv/bin/activate

if ! cmp -s requirements.txt .venv/requirements.txt; then
    echo "Updating local dependencies...\n"
    pip install --upgrade pip
    pip install -r requirements.txt
    cp requirements.txt .venv/requirements.txt
fi

if [ -z $1 ]; then
    echo "Exit -> The path to the Python script to execute is missing..."
    exit 0
fi

current_directory=$(dirname $(readlink -f $0))
export GOOGLE_APPLICATION_CREDENTIALS="$current_directory/credentials_kyledle.json"
export SCRIPT_PATH=$(dirname $current_directory/$1)

export BACKEND_PATH="../backend"
export FRONTEND_PATH="../frontend"

python "$@"
