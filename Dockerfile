FROM php:7.1.3-apache

# Copy the PHP settings into place
COPY docker/php.ini /usr/local/etc/php/

# Enable mod_rewrite
RUN a2enmod rewrite

# Install zlib (required for Composer stuff)
RUN apt-get update && apt-get install -y zlib1g-dev

# Rewrite Apache document root location
RUN sed -i 's/\/var\/www\/html/\/var\/www\/html\/public/g' /etc/apache2/sites-available/000-default.conf

# Install PHP extensions
RUN docker-php-ext-install zip pdo pdo_mysql

# Change owner of Apache root directory
RUN chown -R www-data:www-data /var/www/html

# Create user for simplicity
RUN useradd -ms /bin/bash revolution
