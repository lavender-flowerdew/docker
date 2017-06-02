FROM lavenderflowerdew/alpine-base:latest

LABEL maintainer "lavender.flowerdew@gmail.com"

RUN cd /usr/share && \
    wget http://192.168.99.1:9999/texlive-20160523b-texmf.tar.xz && \
    tar -xf texlive-20160523b-texmf.tar.xz && \
    ln -s /usr/share/texlive-20160523-texmf/texmf-dist /usr/share/texmf-dist && \
    echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk --no-cache add \
      wget \
      xz \
      poppler@edge \
      icu-libs@edge \
      harfbuzz@edge \
      harfbuzz-icu@edge \
      texlive-full@testing && \
    rm -rf ${RM_DIRS} /usr/share/texlive-20160523b-texmf.tar.xz /usr/share/man /tmp/* /var/cache/apk/* \
      /usr/share/texlive-20160523-texmf/texmf-dist/source /usr/share/texlive-20160523-texmf/texmf-dist/doc
