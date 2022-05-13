FROM bitnami/minideb:stretch as nginx-builder
RUN install_packages ca-certificates apt-transport-https curl wget gnupg && \
    curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg && \
    mv bazel.gpg /etc/apt/trusted.gpg.d/ && \
    echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list && \
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
        bazel \
        bazel-4.0.0 \
        openjdk-8-jdk && \
    cd /usr/local/src && \
    git clone https://nginx.googlesource.com/nginx && \
    cd nginx && \
    sed -i 's/zlib-1.2.11/zlib-1.2.12/g' bazel/repositories.bzl && \
    sed -i 's/c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1/91844808532e5ce316b3c010929493c0244f3d37593afd6de04f71821d5136d9/g' bazel/repositories.bzl && \
    bazel build :nginx-google.deb
FROM php:8-fpm-bullseye

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
        libonig-dev \
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
    apt clean autoclean -y && \
    apt autoremove -y && \
    apt-get remove --purge && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    mkdir -p /app/public && \
    chmod +x /entrypoint.sh

COPY config/nginx /etc/nginx
COPY config/supervisord.conf /etc/supervisord.conf
COPY config/supervisor /etc/supervisor

WORKDIR /app
ENTRYPOINT [ "/entrypoint.sh" ]
