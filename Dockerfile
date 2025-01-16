FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    curl \
    git \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

WORKDIR /var/www/laravel-api

COPY laravel-api/ .

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer install --no-dev --optimize-autoloader --prefer-dist

RUN mkdir -p /var/www/laravel-api/storage /var/www/laravel-api/bootstrap/cache

RUN chown -R www-data:www-data /var/www/laravel-api/storage /var/www/laravel-api/bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]
