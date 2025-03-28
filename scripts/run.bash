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
export GOOGLE_APPLICATION_CREDENTIALS=$KYLEDLE_GCP
export PYTHONPATH=$PYTHONPATH:$current_directory/python_utils  # Use to import python_utils module
export RELATIVE_SCRIPT_PATH=$1
export SCRIPT_PATH=$(dirname $current_directory/$1)

python "$@"
