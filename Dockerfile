FROM golang:1.15.5-alpine3.12

# Set up dependencies
ENV PACKAGES go make git libc-dev bash
ENV BINARY_NAME softversion

COPY . $REPO_PATH
WORKDIR $REPO_PATH

VOLUME $REPO_PATH/logs

# Install minimum necessary dependencies, build binary
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && apk add --no-cache $PACKAGES tzdata ca-certificates && \
    cd $REPO_PATH && make all

CMD $BINARY_NAME

