FROM golang:1.18.10-alpine3.17 as builder
# Set up dependencies
ENV PACKAGES make git libc-dev bash gcc
ENV GO111MODULE  on
ENV BINARY_NAME softversion

ARG GITUSER=bamboo
ARG GITPASS=FS_Q5LmxwExwK6hFN9Fs
ARG GOPRIVATE=gitlab.bianjie.ai
ARG GOPROXY=http://192.168.0.60:8081/repository/go-bianjie/,http://nexus.bianjie.ai/repository/golang-group,https://goproxy.cn,direct


COPY  . $GOPATH/src
WORKDIR $GOPATH/src

# Install minimum necessary dependencies, build binary
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache $PACKAGES && \
    git config --global url."https://${GITUSER}:${GITPASS}@gitlab.bianjie.ai".insteadOf "https://gitlab.bianjie.ai" && make all

FROM alpine:3.17
ENV TZ           Asia/Shanghai
ENV BINARY_NAME softversion
WORKDIR /root/
COPY --from=builder /go/src/softversion /usr/local/bin
RUN apk add --no-cache tzdata && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

CMD $BINARY_NAME