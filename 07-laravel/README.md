# 07 - Laravel Application

FIXME: `Parse error: syntax error, unexpected token ")" in /var/www/html/vendor/symfony/http-foundation/Request.php on line 774`

Commands:
 - Create laravel project using compose utility cointainer: `docker-compose run --rm composer create-project --prefer-dist laravel/laravel=9  .`
 - Up containers: `docker-compose up -d --build server`
 - Run artisan migrate to teste mysql container: `docker-compose run --rm artisan migrate` FIXME: Permission error