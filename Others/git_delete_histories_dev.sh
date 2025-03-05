git checkout --orphan newBranch
git add -A  # Add all files and commit them
git commit -am .
git branch -D dev  # Deletes the dev branch
git branch -m dev  # Rename the current branch to dev
git gc --aggressive --prune=all     # remove the old files
git push -f origin dev  # Force push dev branch to github
git gc --aggressive --prune=all     # remove the old files
git gc --auto
