FROM php:7.1.3-apache

# Copy the PHP settings into place
COPY docker/php.ini /usr/local/etc/php/

# Enable mod_rewrite
RUN a2enmod rewrite

# Install things required by the PHP extensions (and other stuff)
RUN apt-get update && apt-get install -y  \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
		zlib1g-dev \
		curl \
		vim \
		g++ \
		libmagickwand-dev \
		imagemagick \
		make \
		libtool

# Install PHP extensions
RUN docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip pdo_mysql mcrypt \
	&& pecl install imagick \
    && docker-php-ext-enable imagick

# Install composer
RUN cd /usr/src && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
