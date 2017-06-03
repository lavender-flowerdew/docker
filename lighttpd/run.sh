#!/bin/bash
set -e

if [ "$1" = 'httpd-fastcgi' ]; then
  ip=`host $2 | awk '/has address/ { print $4 ; exit }'`
  ip2=`host $3 | awk '/has address/ { print $4 ; exit }'`
  cp /home/flower/lighttpd.conf /home/flower/lighttpd-fastcgi.conf
  cat <<EOT >> /home/flower/lighttpd-fastcgi.conf
fastcgi.server = (
  "/home/flower/www" =>
  (( "host" => "$ip",
     "port" => 9000,
     "check-local" => "disable",
     "fix-root-scriptname" => "enable"
  )),
  ".sh" =>
  (( "host" => "$ip",
     "port" => 9001,
     "check-local" => "disable",
     "fix-root-scriptname" => "enable"
  ))
)
\$HTTP["url"] =~ "^/proxy/" {
    proxy.server = (
        "" => ( (
            "host" => "$ip2"
        ) )
    )
}
EOT
  shift 3
  echo "Running $@ with /home/flower/lighttpd-fastcgi.conf"
  cat /home/flower/lighttpd-fastcgi.conf
fi

exec "$@"
