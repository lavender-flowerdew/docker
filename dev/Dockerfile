FROM lavenderflowerdew/alpine-sbt:openjdk-8-sbt-0.13.8

MAINTAINER Lavender Flowerdew <lavender.flowerdew@gmail.com>

# Development Tools Install
USER root
RUN apk update && apk upgrade && \
    apk --no-cache add \
      openssh \
      openjdk8 \
      vim

# Setup SSH
RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config && \
    ssh-keygen -A

COPY rootfs /

# Clean Up
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

EXPOSE 22

# Start container
CMD ["/usr/sbin/sshd", "-D", "-e"]
