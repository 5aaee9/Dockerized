FROM php:7.3-apache
ENV APACHE_CONFDIR /etc/apache2

COPY config/apache2 ${APACHE_CONFDIR}

RUN apt-get update && \
    apt-get install \
        zlib1g-dev \
        libzip-dev \
        libcurl4-openssl-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        cron \
        git \
        -y && \
    docker-php-ext-install \
        pdo \
        pdo_mysql \
        mbstring \
        bcmath \
        zip \
        curl \
        mysqli \
        gd \
        opcache && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    apt clean autoclean -y && \
    apt autoremove -y && \
    apt-get remove --purge && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    a2disconf docker-php && \
    a2enconf site && \
    a2enmod rewrite && \
    mkdir -p /app/public

WORKDIR /app
