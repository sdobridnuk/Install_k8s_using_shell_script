#!/bin/bash

ORG=privacyfed
GIT_OUTPUT_DIRECTORY=${2:-"/var/www/${ORG}_repos"}
PER_PAGE=100
GITHUB_TOKEN=

# Stampa il token GitHub all'inizio
echo "GitHub Token: $GITHUB_TOKEN"

for ((PAGE=1; ; PAGE+=1)); do
    while read REPO_NAME ; do
        # Filtra solo le repository che iniziano con "module_" o "theme_"
        if [[ $REPO_NAME == module_* ]] || [[ $REPO_NAME == theme_* ]]; then
            echo "Cloning $REPO_NAME..."
            # Usa il token GitHub come password per il clone
            git clone https://$GITHUB_TOKEN@github.com/$ORG/$REPO_NAME.git $GIT_OUTPUT_DIRECTORY/$REPO_NAME >/dev/null 2>&1 ||
                { echo "ERROR: Unable to clone!" ; continue ; }
            echo "done"
        fi
    done < <(curl -u :$GITHUB_TOKEN -s "https://api.github.com/orgs/$ORG/repos?per_page=$PER_PAGE&page=$PAGE" | jq -r ".[]|.name")
done
