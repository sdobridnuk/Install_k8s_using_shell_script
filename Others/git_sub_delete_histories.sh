git submodule foreach git checkout --orphan newBranch
git submodule foreach git add -A  # Add all files and commit them
git submodule foreach git commit -am "first"
git submodule foreach git branch -D master  # Deletes the master branch
git submodule foreach git branch -m master  # Rename the current branch to master
git submodule foreach git push -f origin master  # Force push master branch to github
git submodule foreach git gc --aggressive --prune=all     # remove the old files