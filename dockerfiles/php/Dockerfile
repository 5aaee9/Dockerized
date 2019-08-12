FROM bitnami/minideb:stretch as nginx-builder
RUN install_packages ca-certificates curl wget gnupg && \
    wget https://github.com/bazelbuild/bazel/releases/download/0.23.2/bazel_0.23.2-linux-x86_64.deb && \
    install_packages \
        pkg-config \
        zip \
        g++ \
        zlib1g-dev \
        unzip \
        python-dev \
        cmake \
        build-essential \
        autoconf \
        automake \
        libjemalloc-dev \
        libssl-dev \
        git \
        software-properties-common \
        bash-completion \
        openjdk-8-jdk && \
    dpkg -i bazel_0.23.2-linux-x86_64.deb && \
    cd /usr/local/src && \
    git clone https://nginx.googlesource.com/nginx && \
    cd nginx && \
    bazel build :nginx-google.deb
FROM php:7.3-fpm
COPY config/nginx /etc/nginx

COPY --from=nginx-builder /usr/local/src/nginx/bazel-bin/nginx-google.deb .
COPY config/entrypoint.sh /entrypoint.sh
RUN dpkg -i nginx-google.deb && \
    rm -f nginx-google.deb && \
    apt-get update && \
    apt-get install \
        zlib1g-dev \
        libzip-dev \
        libcurl4-openssl-dev \
        libpng-dev \
        libjpeg62-turbo-dev \
        libfreetype6-dev \
        cron \
        git \
        supervisor \
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
    mkdir -p /app/public && \
    chmod +x entrypoint.sh

COPY config/supervisord.conf /etc/supervisord.conf
COPY config/supervisor /etc/supervisor
WORKDIR /app

