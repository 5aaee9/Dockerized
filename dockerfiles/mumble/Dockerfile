FROM alpine AS download

ENV MUMBLE_VERSION=1.3.0-rc1

RUN apk add wget && \
    cd / && \
    wget https://dl.mumble.info/murmur-static_x86-$MUMBLE_VERSION.tar.bz2 && \
    tar -jxvf murmur-static_x86-$MUMBLE_VERSION.tar.bz2

FROM alpine
ENV MUMBLE_VERSION=1.3.0-rc1
COPY --from=download /murmur-static_x86-$MUMBLE_VERSION/murmur.x86 /usr/bin/murmur

ENTRYPOINT [ "/usr/bin/murmur", "-ini", "/data/murmur.ini", "-fg" ]
