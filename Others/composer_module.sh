php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php
php -r "unlink('composer-setup.php');"
php -r "unlink('composer.lock');"
#---------------------------------------------------------------------------
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs thecodingmachine/safe

#---------------------------------------------------------------------------
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev laravel/pint
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev nunomaduro/phpinsights
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev nunomaduro/larastan
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev vimeo/psalm
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev psalm/plugin-laravel
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev enlightn/enlightn
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev driftingly/rector-laravel
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev symplify/phpstan-rules
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev rector/phpstan-rules
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev rector/rector
php -d memory_limit=-1 composer.phar require -W --ignore-platform-reqs --dev thecodingmachine/phpstan-safe-rule

#----------------------------------------------------------------------------
./vendor/bin/psalm-plugin enable psalm/plugin-laravel
./vendor/bin/psalm --alter --safe-types --issues=MissingReturnType

