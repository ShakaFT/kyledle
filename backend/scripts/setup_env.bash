#!/bin/bash
# This script setups multiple environment variables used by Bash Scripts

export RED="\033[0;31m"
export GREEN="\033[0;32m"
export BLUE="\033[1;34m"
export NO_COLOR="\033[0m"

export $(grep -v '^#' .env | xargs)  # Load .env
