#!/bin/bash
# This script should be used to run the REST API locally.

source scripts/setup_env.bash
./scripts/refresh_venv.bash > /dev/null

cd src
source .venv/bin/activate
python main.py
