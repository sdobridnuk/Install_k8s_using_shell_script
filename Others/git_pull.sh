
git submodule foreach $( readlink -f -- "$0"; );
git submodule update --progress --init --recursive --force --merge --rebase --remote
git checkout master --
git pull origin master --autostash --recurse-submodules --allow-unrelated-histories --prune --progress -v --rebase
#read -p "Press [Enter] key to exit..."
echo "-------- END PULL [$(pwd)]----------";
