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

RUN groupadd -g 1000 www-data && \
    useradd -u 1000 -g www-data -m -s /bin/bash www-data

WORKDIR /var/www/laravel-api

COPY laravel-api/composer.json laravel-api/composer.lock ./

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-dev --optimize-autoloader --prefer-dist

COPY laravel-api/ .

RUN chown -R www-data:www-data /var/www/laravel-api/storage /var/www/laravel-api/bootstrap/cache

USER www-data

EXPOSE 9000

CMD ["php-fpm"]
