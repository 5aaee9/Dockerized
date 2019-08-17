FROM golang:1.12.1

ENV GOPATH /go
ENV USER root

RUN apt-get install make git && \
    git clone https://github.com/cloudflare/cfssl.git $GOPATH/src/github.com/cloudflare/cfssl && \
    cd $GOPATH/src/github.com/cloudflare/cfssl && \
    make

FROM bitnami/minideb:stretch
COPY --from=0 /go/src/github.com/cloudflare/cfssl/bin/ /usr/bin

VOLUME [ "/etc/cfssl" ]
WORKDIR /etc/cfssl

EXPOSE 8888

ENTRYPOINT ["cfssl"]
CMD ["--help"]
