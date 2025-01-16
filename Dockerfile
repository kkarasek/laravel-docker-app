FROM php:8.2-fpm

WORKDIR /var/www/laravel-api

RUN apt-get update && apt-get install -y \
    zip \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    git \
    npm \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN chown -R www-data:www-data /var/www/laravel-api/storage /var/www/laravel-api/bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]