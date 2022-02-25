FROM oberd/php-8.0-apache

RUN apt-get update -y && apt-get install -y ssh  \
    libpng-dev \
    libmagickwand-dev \
    libjpeg-dev \
    libmemcached-dev \
    zlib1g-dev libzip-dev \
    git \
    unzip \
    subversion \
    ca-certificates \
    libicu-dev\
    libxml2-dev \
    libmcrypt-dev \
    libmemcached11 \
    libmemcachedutil2 \
    build-essential \
    libmemcached-dev \
    libz-dev \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN pecl install memcached mcrypt-1.0.4 && docker-php-ext-enable memcached mcrypt
RUN docker-php-ext-install gd mysqli exif pdo pdo_mysql opcache intl
RUN docker-php-ext-configure intl

# setup Composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer


RUN ln -s /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/expires.load

RUN a2enmod rewrite
RUN a2enmod expires

WORKDIR /var/www
