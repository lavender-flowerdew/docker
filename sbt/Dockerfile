FROM lavenderflowerdew/ssh

ARG SBT_VERSION=0.13.8
ARG JDK_VERSION=8

LABEL maintainer "lavender.flowerdew@gmail.com"
LABEL java.version=$JDK_VERSION

# Development Tools Install
RUN apk update && apk upgrade && \
    apk --no-cache add \
      git \
      openjdk$JDK_VERSION \
      vim

# Install SBT
RUN cd /usr/share && \
    wget https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.zip && \
    unzip sbt-$SBT_VERSION.zip && \
    rm sbt-$SBT_VERSION.zip && \
    ln -s /usr/share/sbt/conf /etc/sbt && \
    ln -s /usr/share/sbt/bin/sbt /usr/bin

# Clean Up
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*


# Set Up Development Environment
RUN cd /home/flower/ && \
    mkdir -p /home/flower/dev && \
    /usr/share/sbt/bin/sbt && \
    rm -rf /home/flower/target /home/flower/project

# Start container
CMD ["/bin/bash", "-i"]
