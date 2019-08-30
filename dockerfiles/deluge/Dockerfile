FROM alpine:edge
LABEL maintainer="Indexyz <jiduye@gmail.com>"

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add --update --no-cache apk-tools && \
    apk add --no-cache ca-certificates curl openssl p7zip unrar unzip && \
    apk add --no-cache 	--repository "http://nl.alpinelinux.org/alpine/edge/main" libressl2.7-libcrypto libressl2.7-libssl boost-python boost-system && \
    apk add --update --no-cache bash py-pip deluge@testing && \
    rm -rf /var/cache/apk/* && \
    pip install --upgrade pip && \
    pip install --upgrade setuptools && \
    pip2 install incremental constantly packaging automat service_identity && \
    rm -rf /root/.cache && \
    mkdir /config && \
    echo "#!/bin/sh" > /start && \
    echo "set -e" >> /start && \
    echo "deluged -c /config" >> /start && \
    echo "deluge-web -c /config" >> /start && \
    chmod +x /start

CMD ["/start"]
