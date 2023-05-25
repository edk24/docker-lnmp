FROM php:7.4.33-fpm-alpine

# ENV TIME_ZONE=Asia/Shanghai
# ENV BUILD_DEPS='autoconf gcc g++ make bash'

# Tencent mirrors
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.cloud.tencent.com/g' /etc/apk/repositories

# Install php extension
RUN apk --no-cache add libpng autoconf g++ libxml2-dev make git libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev libzip libzip-dev freetype freetype-dev gettext-dev \
	# GD extension
    && docker-php-ext-configure gd \
    --with-jpeg=/usr/include/ \
    --with-freetype=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    # Ohter extension
    && docker-php-ext-install \
    zip \
    pcntl \
    bcmath \
    pdo_mysql \ 
    fileinfo \
    simplexml \
    xml \
    opcache

# Install redis for php
RUN pecl channel-update pecl.php.net \
    && pecl install redis \
    && docker-php-ext-enable redis gd zip pcntl bcmath pdo_mysql

# Install composer
RUN curl -o /usr/local/bin/composer https://mirrors.cloud.tencent.com/composer/composer.phar \
    && chmod +x /usr/local/bin/composer \
    && /usr/local/bin/composer config -g repo.packagist composer https://mirrors.cloud.tencent.com/composer/ \
    && mkdir -p /var/www/html && mkdir -p /.composer

# Create website directory
# RUN mkdir -p /usr/share/nginx/html


# WORKDIR /usr/share/nginx/html

# Crontab
# RUN echo "* * * * * cd /var/www/html && php think Check > /dev/null 2>&1 &" >> /var/spool/cron/crontabs/root

# reference
# - gd配置freetype报错: https://github.com/docker-library/php/issues/931