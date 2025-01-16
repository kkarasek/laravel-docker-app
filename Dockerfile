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
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && curl -f https://get.pnpm.io/v6.16.js | node - add --global pnpm

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

COPY laravel-api/package.json laravel-api/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

RUN chown -R www-data:www-data /var/www/laravel-api/storage /var/www/laravel-api/bootstrap/cache

EXPOSE 9000

CMD ["php-fpm"]