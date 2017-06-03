#!/bin/bash

set -e

if [ $1 == "start" ]; then
  f=/etc/nginx/custom
  echo "Creating addtional configuration..."
  echo "$CLUSTER_CONF"

  l=$f/locations.conf
  s=$f/servers.conf
  ss=./servers-conf

  IN="$CLUSTER_CONF"

  locations=$(echo $IN | tr ";" "\n")

  for details in $locations
  do
      IFS='~' read group location hosts  <<< "$details"
      cat <<EOT >> $l
location ~ /$location/([^/]+) {
  gzip off;
  include /etc/nginx/common/fastcgi_params;
  fastcgi_pass $group;
}
EOT
  done

  for details in $locations
  do
      IFS='~' read group location hs  <<< "$details"
      hosts=$(echo $hs | tr "," "\n")
      for host in $hosts
      do
          line=$(echo $host | tr "-" " ")
          echo "    server $line;" >> $ss
      done

      servers=`cat $ss`
      rm -f $ss
      cat <<EOT >> $s
upstream $group {
    $servers
}
EOT
  done

  echo "Additional conf is:"
  cat $l
  cat $s
  shift 1
  echo "Starting nginx"
  (nginx)
  echo "Done"
fi
