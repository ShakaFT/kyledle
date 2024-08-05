#!/bin/bash
# This script should be used to run the REST API locally.

source scripts/setup_env.bash
source scripts/refresh_venv.bash

cd src
python main.py
