FROM php:7.1.3-apache

# Copy the PHP settings into place
COPY docker/php.ini /usr/local/etc/php/

# Enable mod_rewrite
RUN a2enmod rewrite

# Install zlib (required for Composer stuff)
RUN apt-get update && apt-get install -y zlib1g-dev

# Install PHP extensions
RUN docker-php-ext-install zip pdo pdo_mysql

# Install composer
RUN cd /usr/src && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
