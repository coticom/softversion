FROM golang:1.15.5-alpine3.12

# Set up dependencies
ENV PACKAGES go make git libc-dev bash
ENV BINARY_NAME softversion
ENV GOPATH       /root/go
ENV REPO_PATH    $GOPATH/src/gitlab.bianjie.ai/rainbow/rainbow-server
ENV PATH         $GOPATH/bin:$PATH
ENV TZ           Asia/Shanghai
ENV GO111MODULE  on

ARG GOPROXY=https://goproxy.cn,direct

RUN mkdir -p $GOPATH/bin $REPO_PATH

COPY . $REPO_PATH
WORKDIR $REPO_PATH

VOLUME $REPO_PATH/logs

# Install minimum necessary dependencies, build binary
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk add --no-cache $PACKAGES tzdata ca-certificates && \
    cd $REPO_PATH && make all

CMD $BINARY_NAME

