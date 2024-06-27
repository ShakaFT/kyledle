#!/bin/bash
# This script setups multiple environment variables used by Bash Scripts

export RED="\033[0;31m"
export GREEN="\033[0;32m"
export BLUE="\033[1;34m"
export NO_COLOR="\033[0m"

export DEPENDENCIES_FILENAME="dependencies.json"
export DEPENDENCIES_PATH=$(pwd)/$DEPENDENCIES_FILENAME
export GOOGLE_APPLICATION_CREDENTIALS=$KYLEDLE_GCP
export GOOGLE_CLOUD_PROJECT="kyledle"

gcloud config set account tornicelliflorent@gmail.com
gcloud config set project $GOOGLE_CLOUD_PROJECT 2> /dev/null
export $(grep -v '^#' .env | xargs)  # Load .env
