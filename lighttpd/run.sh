#!/bin/bash
set -e

if [ "$1" = 'httpd' ]; then
    exec /usr/sbin/lighttpd $@
fi

exec "$@"
