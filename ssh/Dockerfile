FROM lavenderflowerdew/alpine-base:latest

LABEL maintainer "lavender.flowerdew@gmail.com"

ARG PUB_KEY
ENV PUB_KEY $PUB_KEY

RUN apk update && apk upgrade && \
    apk --no-cache add \
      gnupg \
      openssh

# Setup SSH
RUN sed -i s~#PermitRootLogin.*~PermitRootLogin\ no~ /etc/ssh/sshd_config && \
    sed -i s~#Port\ 22~Port\ 3791~ /etc/ssh/sshd_config && \
    sed -i s~#Banner\ none~Banner\ /etc/motd~ /etc/ssh/sshd_config && \
    sed -i s~#UseDNS\ no~UseDNS\ no~ /etc/ssh/sshd_config && \
    sed -i s~#PasswordAuthentication.*~PasswordAuthentication\ no~ /etc/ssh/sshd_config && \
    sed -i s~#ClientAliveInterval.*~ClientAliveInterval\ 900~ /etc/ssh/sshd_config && \
    sed -i s~#ClientAliveCountMax.*~ClientAliveCountMax\ 0~ /etc/ssh/sshd_config && \
    sed -i s~#IgnoreRhosts.*~IgnoreRhosts\ yes~ /etc/ssh/sshd_config && \
    sed -i s~#HostbasedAuthentication.*~HostbasedAuthentication\ no~ /etc/ssh/sshd_config && \
    sed -i s~#PermitEmptyPasswords.*~PermitEmptyPasswords\ no~ /etc/ssh/sshd_config && \
    sed -i s~#UsePrivilegeSeparation.*~UsePrivilegeSeparation\ yes~ /etc/ssh/sshd_config && \
    sed -i s~#SyslogFacility\ AUTH~SyslogFacility\ AUTH~ /etc/ssh/sshd_config && \
    sed -i s~#LogLevel\ INFO~LogLevel\ INFO~ /etc/ssh/sshd_config && \
    sed -i s~#StrictModes\ yes~StrictModes\ yes~ /etc/ssh/sshd_config && \
    sed -i s~#MaxAuthTries\ 6~MaxAuthTries\ 6~ /etc/ssh/sshd_config && \
    sed -i s~#MaxSessions\ 10~MaxSessions\ 20~ /etc/ssh/sshd_config && \
    sed -i s~#AllowTcpForwarding\ yes~AllowTcpForwarding\ no~ /etc/ssh/sshd_config && \
    sed -i s~#X11Forwarding\ no~X11Forwarding\ no~ /etc/ssh/sshd_config && \
    rm /etc/motd && \
    addgroup -S sshusers && \
    addgroup flower sshusers && \
    addgroup root sshusers && \
    echo "AllowGroups sshusers" >> /etc/ssh/sshd_config && \
    echo "Protocol 2" >> /etc/ssh/sshd_config && \
    ssh-keygen -A && \
    cd /home/flower && \
    mkdir -p /home/flower/.ssh && \
    echo "$PUB_KEY" >> /home/flower/.ssh/authorized_keys

COPY rootfs /

# Clean Up
RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*

USER flower
ENV KEYS 82D2B62C

RUN chmod 600 /home/flower/.ssh/authorized_keys && \
    chmod 700 /home/flower/.ssh && \
    set -e; for key in $KEYS; do \
      found=''; \
      for server in \
        pgp.mit.edu \
        ha.pool.sks-keyservers.net \
        hkp://keyserver.ubuntu.com:80 \
        hkp://p80.pool.sks-keyservers.net:80 \
      ; do \
        echo "  trying $server for $key"; \
        gpg --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$key" && found=yes && break; \
      done; \
      test -z "$found" && echo >&2 "error: failed to fetch $key from several disparate servers -- network issues?" && exit 1; \
    done; \
    exit 0

EXPOSE 3791

# Start container
USER root
CMD ["/usr/sbin/sshd", "-D", "-e"]
