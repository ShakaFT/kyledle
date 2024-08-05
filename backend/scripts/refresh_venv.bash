#!/bin/bash
# This script refreshes Python virtual environments

REQUIREMENTS_FILENAME=requirements.txt
LOCAL_REQUIREMENTS_PATH=src/$REQUIREMENTS_FILENAME
VENV_PATH=src/.venv
VENV_REQUIREMENTS_PATH=$VENV_PATH/$REQUIREMENTS_FILENAME

if [ ! -d $VENV_PATH ]; then
    printf "$GREEN\nVirtual environment creation processing...\n$NO_COLOR"
    python3.12 -m venv $VENV_PATH --upgrade-deps
fi

source $VENV_PATH/bin/activate

if ! cmp -s $LOCAL_REQUIREMENTS_PATH $VENV_REQUIREMENTS_PATH; then
    printf "$GREEN\nUpdating local dependencies...\n$NO_COLOR"
    pip install --upgrade pip
    pip install -r $LOCAL_REQUIREMENTS_PATH

    cp $LOCAL_REQUIREMENTS_PATH $VENV_REQUIREMENTS_PATH
fi
