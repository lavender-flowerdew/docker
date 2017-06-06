FROM lavenderflowerdew/alpine-base:latest

LABEL maintainer "lavender.flowerdew@gmail.com"

RUN mkdir -p /home/flower/www /home/flower/conf /home/flower/bin

COPY ./bin /home/flower/bin
COPY ./www /home/flower/www
COPY ./conf /home/flower/conf

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk --no-cache add \
    	linux-vanilla-dev \
      make \
      perl \
      perl-fcgi && \
    /home/flower/bin/prep.sh && \
    cd /home/flower && \
    apk del linux-vanilla-dev && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* && \
    chmod -R +x /home/flower/bin/*.pl /home/flower/www/*.pl && \
    chown -R flower:flower /home/flower/www && \
    touch /home/flower/logs/perl-fastcgi.log && \
    chown flower:flower /home/flower/logs/perl-fastcgi.log && \
    rm -rf /root/.cpanm /root/.local /home/flower/bin/prep.sh

EXPOSE 9000

WORKDIR /home/flower

ENTRYPOINT ["/home/flower/bin/run.sh","pfastcgi","start","tail","-f","/home/flower/logs/perl-fastcgi.log"]
