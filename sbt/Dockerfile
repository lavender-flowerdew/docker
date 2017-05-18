FROM lavenderflowerdew/ssh:latest

ARG SBT_VERSION=0.13.15
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
    ln -s /usr/share/sbt/bin/sbt /usr/bin && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

# Set Up Development Environment
USER flower
RUN cd /home/flower/ && \
    mkdir -p /home/flower/dev && \
    /usr/share/sbt/bin/sbt && \
    rm -rf /home/flower/target /home/flower/project

USER root
RUN mkdir -p /root && \
    cd /root/ && \
    mkdir -p /root/tmp1/project && \
    cd tmp1 && \
    echo 'object Hi { def main(args: Array[String]) = println("Hi!") }' >> hw.scala && \
    echo "sbt.version=0.13.8" >> ./project/build.properties && \
    /usr/share/sbt/bin/sbt compile && \
    cd .. && \
    /usr/share/sbt/bin/sbt new playframework/play-java-seed.g8 --name=tmp --organization=com.example --scala_version=2.11.11 --play_version=2.5.14 && \
    cd tmp && \
    /usr/share/sbt/bin/sbt compile && \
    cd .. && \
    rm -rf /root/tmp

# Start container
EXPOSE 3791
CMD ["/usr/sbin/sshd", "-D", "-e"]
