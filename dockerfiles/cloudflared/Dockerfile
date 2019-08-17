FROM alpine

RUN apk add --no-cache wget && \
    wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz && \
    tar zxvf cloudflared-stable-linux-amd64.tgz && \
    mv cloudflared /cloudflared


FROM bitnami/minideb:stretch

RUN install_packages ca-certificates

COPY --from=0 /cloudflared /usr/bin

ENTRYPOINT ["cloudflared"]
