FROM lavenderflowerdew/alpine-base:latest

RUN echo "https://s3-us-west-2.amazonaws.com/alpine-ghc/8.0" >> /etc/apk/repositories
ADD https://raw.githubusercontent.com/mitchty/alpine-ghc/master/mitch.tishmack%40gmail.com-55881c97.rsa.pub \
    /etc/apk/keys/mitch.tishmack@gmail.com-55881c97.rsa.pub
RUN apk update
RUN apk add alpine-sdk git ca-certificates ghc cabal stack zlib-dev linux-headers \
    dpkg fakeroot sed gawk grep
RUN stack update
RUN stack config set system-ghc --global true
RUN mkdir -p /etc/stack
RUN echo "build: { split-objs: true }" > /etc/stack/config.yaml
RUN mkdir -p /usr/src/

WORKDIR /usr/src/
RUN git clone https://github.com/lavender-flowerdew/pandoc.git && \
    cd pandoc && \
    git remote add upstream https://github.com/jgm/pandoc.git && \
    git fetch upstream && \
    git checkout master && \
    git merge upstream/master

WORKDIR /usr/src/pandoc
RUN stack install --stack-yaml stack.pkg.yaml --only-dependencies \
    --flag 'pandoc:embed_data_files' \
    --test --ghc-options '-O2 -optc-Os -optl-static -fPIC' \
    pandoc pandoc-citeproc

RUN stack setup

RUN stack install pandoc pandoc-citeproc

# RUN bash linux/make_tarball.sh && \
#     apk del ghc stack alpine-sdk linux-headers musl-dev gmp-dev zlib-dev make && \
#     rm -rf /usr/share/man /tmp/* /var/cache/apk/* /root/pandoc /root/.stack/

CMD ["bash"]
