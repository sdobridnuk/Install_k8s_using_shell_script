git submodule foreach git checkout master --
git submodule foreach git pull origin master --force --allow-unrelated-histories --prune
git submodule update --remote --recursive --init --force --checkout
git submodule foreach git add -A
git submodule foreach git commit -am "up" || true
git add -A
git commit -am "up" || true
git submodule foreach git push --set-upstream origin master
git push --set-upstream origin master
git submodule foreach git push --progress "origin" master:master
git push
git submodule foreach git rebase origin/master
git rebase origin/master
git submodule foreach git branch -u origin/master master
git branch -u origin/master master
git submodule foreach git remote set-head origin -a
git remote set-head origin -a
git submodule foreach git checkout master --
git checkout master --
#read -p "Press [Enter] key to exit..."

