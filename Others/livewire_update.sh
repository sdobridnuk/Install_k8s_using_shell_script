php -d memory_limit=-1 composer.phar -W  update livewire/livewire
php artisan optimize:clear
php artisan livewire:publish
