#!/usr/bin/sh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

mkdir -p /etc/prometheus
mkdir -p /var/lib/grafana
cp $SCRIPTPATH/src/prometheus/* /etc/prometheus/
docker compose -f $SCRIPTPATH/src/stack.yml -p prometheus up --detach