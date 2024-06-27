#!/bin/bash
# This script refreshes all Python virtual environments

[ "$1" = "--force" ] && force=true || force=false

refresh_venv() {
    requirement_file=${1#./}  # Remove "./" --> ./services/...

    if $force; then
        rm -r .venv
    fi

    if [ ! -d .venv ]; then
        printf "$GREEN  • Virtual environment creation processing...\n$NO_COLOR"
        python3.11 -m venv .venv --upgrade-deps
    fi

    source .venv/bin/activate

    if ! cmp -s $requirement_file .venv/$requirement_file || ! cmp -s $DEPENDENCIES_PATH .venv/$DEPENDENCIES_FILENAME; then
        printf "$GREEN  • Updating local dependencies...\n$NO_COLOR"
        pip install --upgrade pip
        pip install -r $1

        pip uninstall -y restAPI # Mandatory because we NOT upgrade package version in pyproject.toml

        cat $DEPENDENCIES_PATH | jq -r '.[]' | while IFS= read -r dependency; do
            printf "$GREEN\n  • Updating $dependency\n$NO_COLOR"
            dependency="${dependency//<USERNAME>/$RESTAPI_PACKAGE_USERNAME}"
            dependency="${dependency//<TOKEN>/$RESTAPI_PACKAGE_TOKEN}"
            pip install --upgrade "$dependency"
        done

        mkdir -p $(dirname .venv/$requirement_file)
        cp $requirement_file .venv/$requirement_file
        cp $DEPENDENCIES_PATH .venv/$DEPENDENCIES_FILENAME
    fi

    deactivate
}
export -f refresh_venv

# Refresh local venv (use for local linting)
# TODO Improve by seeking the requirements of each service
printf "$BLUE\nWill refresh every venv...$NO_COLOR"
printf "$GREEN\n  • Local venv$NO_COLOR"

requirements=$(find . -name requirements.txt -not \( -path '*/dist/*' -o -path '*/.venv/*' \) -print)
while IFS= read -r requirement_file; do
    refresh_venv $requirement_file
done <<< "$requirements"

# Refresh venv for each service (used for deployment)
cd src
printf "$GREEN\n  • restAPI$NO_COLOR"
refresh_venv requirements.txt
