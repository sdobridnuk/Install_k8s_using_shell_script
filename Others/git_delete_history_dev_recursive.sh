git submodule foreach $( readlink -f -- "$0";)
git checkout --orphan newBranch
git add --renormalize -A
git add -A  # Add all files and commit them
git commit -am "first"
git branch -D dev  # Deletes the dev branch
git branch -m dev  # Rename the current branch to dev
git gc --aggressive --prune=all     # remove the old files
<<<<<<< HEAD
git push -uf origin dev  # Force push dev branch to github
=======
<<<<<<< HEAD
git push -uf origin dev  # Force push dev branch to github
=======
git push -u origin dev  # Force push dev branch to github
git pull origin dev 
>>>>>>> dev
>>>>>>> c498389 (up)
git gc --aggressive --prune=all     # remove the old files