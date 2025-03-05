##SET ORG AND GIT OUTPUT DIRECTORY

ORG=laraxot
GIT_OUTPUT_DIRECTORY=${2:-"/var/www/${ORG}_repos"}
PER_PAGE=100

for ((PAGE=1; ; PAGE+=1)); do
    while read REPO_NAME ; do
        git clone https://github.com/$ORG/$REPO_NAME.git $GIT_OUTPUT_DIRECTORY/$REPO_NAME >/dev/null 2>&1 ||
            { echo "ERROR: Unable to clone!" ; continue ; }
        echo "done"
    done < <(curl -u :$GITHUB_TOKEN -s "https://api.github.com/orgs/$ORG/repos?per_page=$PER_PAGE&page=$PAGE" | jq -r ".[]|.name")
done