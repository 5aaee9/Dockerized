FROM golang:1.11-alpine as builder

RUN apk add --no-cache git && \
    go get github.com/aliyun/ossutil

FROM alpine
COPY --from=builder /go/bin/ossutil /usr/bin/ossutil
