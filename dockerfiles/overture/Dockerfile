FROM alpine:latest as builder
ENV VERSION=v1.5
RUN apk add wget unzip && \
    cd / && \
    mkdir temp && \
    cd temp && \
    wget https://github.com/shawn1m/overture/releases/download/$VERSION/overture-linux-amd64.zip &&\
    unzip overture-linux-amd64.zip

FROM alpine
COPY --from=builder /temp/overture-linux-amd64 /usr/bin/overture

ENTRYPOINT [ "/usr/bin/overture" ]
CMD [ "-c", "/data/config.json" ]
