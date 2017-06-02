FROM lavenderflowerdew/alpine-base:latest

LABEL maintainer "lavender.flowerdew@gmail.com"

RUN mkdir /home/flower/www

COPY ./lighttpd.conf /home/flower/
COPY ./run.sh /home/flower
COPY ./www /home/flower/www

RUN apk update && \
    apk upgrade && \
    apk --no-cache add \
      lighttpd \
      lighttpd-mod_auth \
      lighttpd-mod_webdav && \
    rm -rf /usr/share/man /tmp/* /var/cache/apk/* && \
    chown -R flower:flower /home/flower/www

EXPOSE 80

WORKDIR /home/flower

ENTRYPOINT ["./run.sh"]

CMD ["/usr/sbin/lighttpd", "-f", "/home/flower/lighttpd.conf", "-D"]
