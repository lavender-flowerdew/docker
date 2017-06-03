FROM lavenderflowerdew/alpine-base:latest

LABEL maintainer "lavender.flowerdew@gmail.com"

RUN mkdir /home/flower/www

COPY ./lighttpd.conf /home/flower/
COPY ./www /home/flower/www

RUN apk update && \
    apk upgrade && \
    apk --no-cache add \
      bind-tools \
      lighttpd \
      lighttpd-mod_auth \
      lighttpd-mod_webdav && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* && \
    touch /home/flower/access.log && \
    chown -R flower:flower /home/flower/*

EXPOSE 80

WORKDIR /home/flower

ENTRYPOINT ["lighttpd","-D","-f","lighttpd.conf"]
