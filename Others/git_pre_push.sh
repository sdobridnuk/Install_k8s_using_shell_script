FILE=./php-cs-fixer.phar
if [ ! -f "$FILE" ]; then
   curl -L -O https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v3.12.0/php-cs-fixer.phar
fi
./php-cs-fixer.phar fix laravel/Modules --allow-risky=yes 
./php-cs-fixer.phar fix laravel/Themes --allow-risky=yes 
echo 'done'