FROM lavenderflowerdew/ssh

ARG SBT_VERSION=0.13.8
ARG JDK_VERSION=8

LABEL maintainer "lavender.flowerdew@gmail.com"
LABEL java.version=$JDK_VERSION

# Development Tools Install
RUN apk update && apk upgrade && \
    apk --no-cache add \
      git \
      openjdk${JDK_VERSION} \
      vim

# Install SBT
RUN cd /usr/share && \
    wget -O sbt.zip "https://bintray.com/sbt/native-packages/download_file?file_path=sbt%2F${SBT_VERSION}%2Fsbt-${SBT_VERSION}.zip" && \
    unzip sbt.zip && \
    rm sbt.zip && \
    ln -s /usr/share/sbt/conf /etc/sbt && \
    ln -s /usr/share/sbt/bin/sbt /usr/bin

# Clean Up
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*


# Set Up Development Environment
USER flower
RUN cd /home/flower/ && \
    mkdir -p /home/flower/dev && \
    /usr/share/sbt/bin/sbt && \
    rm -rf /home/flower/target /home/flower/project

# Start container
EXPOSE 3791
USER root
CMD ["/usr/sbin/sshd", "-D", "-e"]
