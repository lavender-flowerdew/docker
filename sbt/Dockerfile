FROM lavenderflowerdew/ssh:latest

ARG INSTALL_SBT_VERSION=0.13.15
ARG SBT_VERSION=0.13.8
ARG JDK_VERSION=8
ARG SCALA_VERSION=2.11.11
ARG PLAY_VERSION=2.5.14

LABEL maintainer "lavender.flowerdew@gmail.com" java.version=$JDK_VERSION

# Development Tools Install
RUN apk update && apk upgrade && \
    apk --no-cache add \
      git \
      openjdk${JDK_VERSION} \
      vim

# Install SBT
RUN cd /usr/share && \
    wget -O sbt.zip "https://bintray.com/sbt/native-packages/download_file?file_path=sbt%2F${INSTALL_SBT_VERSION}%2Fsbt-${INSTALL_SBT_VERSION}.zip" && \
    unzip sbt.zip && \
    rm sbt.zip && \
    ln -s /usr/share/sbt/conf /etc/sbt && \
    ln -s /usr/share/sbt/bin/sbt /usr/bin && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

# Set Up Development Environment
USER flower
RUN mkdir -p /home/flower && \
    cd /home/flower/ && \
    mkdir -p /home/flower/tmp1/project && \
    cd tmp1 && \
    echo 'object Hi { def main(args: Array[String]) = println("Hi!") }' >> hw.scala && \
    echo "sbt.version=${SBT_VERSION}" >> ./project/build.properties && \
    /usr/share/sbt/bin/sbt compile && \
    cd /home/flower/ && \
    /usr/share/sbt/bin/sbt new playframework/play-java-seed.g8 --name=tmp --organization=com.example --scala_version=${SCALA_VERSION} --play_version=${PLAY_VERSION} && \
    cd tmp && \
    /usr/share/sbt/bin/sbt compile && \
    cd /home/flower/ && \
    rm -rf /home/flower/tmp*

# Start container
EXPOSE 3791
CMD ["/usr/sbin/sshd", "-D", "-e"]
