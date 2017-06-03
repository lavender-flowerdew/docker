#!/bin/bash

set -e

if [ $1 == "start" ]; then
  f=/etc/nginx/custom/cluster.conf
  echo "Creating addtional configuration at"
  cat <<EOT >> $f
$CLUSTER_CONF
EOT
  echo "Additional conf is:"
  cat $f
  shift 1
  echo "Starting nginx"
  (nginx)
  echo "Done"
fi
