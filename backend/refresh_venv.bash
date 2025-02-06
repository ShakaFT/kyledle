#!/bin/bash
# This script refreshes the local Python virtual environment

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