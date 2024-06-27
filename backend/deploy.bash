#!/bin/bash
# This script should be used to run deploy restAPI.

source scripts/setup_env.bash
./scripts/refresh_venv.bash

cd src

printf "$BLUE\n\nWill build restAPI...\n$NO_COLOR"

deploy_command="gcloud app deploy --no-cache --quiet --project $GOOGLE_CLOUD_PROJECT --version main --promote dist/app.yaml"

if [[ -d $targeted_service && $service != "$targeted_service" ]]; then
    continue
fi

source .venv/bin/activate

rm -rf dist
rsync -av --exclude '.venv' ./ dist/ >/dev/null

# Dependencies
cat $DEPENDENCIES_PATH | jq -r '.[]' | while IFS= read -r dependency; do
    dependency="${dependency//<USERNAME>/$RESTAPI_PACKAGE_USERNAME}"
    dependency="${dependency//<TOKEN>/$RESTAPI_PACKAGE_TOKEN}"
    echo "$dependency" >> dist/requirements.txt
done

# app.yaml config
yq eval ".env_variables.KYLEDLE_API_KEY_HEADER = \"$KYLEDLE_API_KEY_HEADER\"" -i "dist/app.yaml"
yq eval ".env_variables.KYLEDLE_API_KEY = \"$KYLEDLE_API_KEY\"" -i "dist/app.yaml"

deactivate

printf "$BLUE\nWill deploy services...\n\n$NO_COLOR"
eval "$deploy_command"
