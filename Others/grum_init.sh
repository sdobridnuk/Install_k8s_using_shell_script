composer global require --dev phpro/grumphp

git submodule foreach grumphp configure
git submodule foreach grumphp git:init
git submodule foreach grumphp grumphp git:pre-commit

grumphp configure
grumphp git:init
grumphp git:pre-commit








