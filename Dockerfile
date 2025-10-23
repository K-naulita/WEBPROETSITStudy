FROM php:8.2-apache

RUN apt-get update && apt-get install -y \
    git unzip libpq-dev && \
    docker-php-ext-install pdo pdo_pgsql

COPY . /var/www/html

WORKDIR /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader

EXPOSE 8080

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
