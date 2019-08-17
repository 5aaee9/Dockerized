FROM alpine:edge
LABEL maintainer="Indexyz <jiduye@gmail.com>"

ENV USERNAME=admin \
    PASSWORD=p@ssw0rd

COPY files/start.sh /start.sh
COPY files/settings.json /etc/transmission-daemon/settings.json

RUN apk add --no-cache transmission-daemon curl && \
    mkdir -p /transmission/{downloads,seeds} && \
    mkdir -p /etc/transmission-daemon && \
    mkdir /seeds && \
    chmod +x /start.sh && \
    # Better web contoral
    curl -sSL https://raw.githubusercontent.com/ronggang/transmission-web-control/master/release/install-tr-control-cn.sh -o install.sh && \
    sh install.sh auto && \
    rm -f install.sh

ENTRYPOINT ["sh"]

CMD ["/start.sh"]
