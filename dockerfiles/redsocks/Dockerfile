FROM alpine:latest

ADD overlay /
WORKDIR /

ENV PROXY_SERVER=localhost
ENV PROXY_PORT=1080

RUN apk add --no-cache redsocks iptables bash bind-tools

ENTRYPOINT ["/bin/sh","/start.sh"]
