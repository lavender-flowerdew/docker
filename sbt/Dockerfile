FROM lavenderflowerdew/alpine-base:latest

MAINTAINER Lavender Flowerdew <lavender.flowerdew@gmail.com>

LABEL java.version=1.8

# Development Tools Install
RUN apk update && apk upgrade && \
    apk --no-cache add \
      git \
      openjdk8 \
      vim

# Install SBT
RUN cd /usr/share && \
    wget https://github.com/sbt/sbt/releases/download/v0.13.15/sbt-0.13.15.zip && \
    unzip sbt-0.13.15.zip && \
    rm sbt-0.13.15.zip && \
    ln -s /usr/share/sbt/conf /etc/sbt && \
    ln -s /usr/share/sbt/bin/sbt /usr/bin

# Clean Up
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*


# Set Up Development Environment
WORKDIR /home/flower
USER flower
RUN cd /home/flower/ && \
    mkdir -p /home/flower/dev && \
    /usr/share/sbt/bin/sbt && \
    rm -rf /home/flower/target /home/flower/project

# Start container
CMD ["/bin/bash", "-i"]
