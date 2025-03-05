git submodule foreach $( readlink -f -- "$0";)
git config pull.rebase true
git config remote.origin.push HEAD
git config core.autocrlf true
git config core.safecrlf false
git config submodule.recurse true
git config core.fileMode false
git config advice.skippedCherryPicks false
git remote set-branches --add origin master
git push --recurse-submodules=on-demand
git branch --set-upstream-to=origin/master master

