FROM alpine:latest

MAINTAINER Lavender Flowerdew <lavender.flowerdew@gmail.com>

RUN apk update && apk upgrade && \
    apk --no-cache add \
    bash \
    ca-certificates \
    curl \
    openssl && \
    update-ca-certificates

# Users
RUN echo 'root:root' | chpasswd
RUN addgroup -S flower && adduser -S -g flower flower .
RUN echo 'flower:flower' | chpasswd

# Clean Up
RUN rm -rf /var/cache/apk/*

# Set Up Environment
WORKDIR /home/flower

# Start container
CMD ["/bin/sh", "-i"]
