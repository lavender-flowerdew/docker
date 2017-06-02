FROM lavenderflowerdew/alpine-server:latest

MAINTAINER Lavender Flowerdew <lavender.flowerdew@gmail.com>

# Install nginx
RUN apk update && apk upgrade && \
    apk --no-cache add \
      nginx && \
    rm -rf /var/cache/apk/* && \
    chown -R nginx:www-data /var/lib/nginx

# Add the files
ADD root /

# Expose the ports for nginx
EXPOSE 80 443

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    rc-update add nginx

CMD ["nginx","-g","daemon off;"]
