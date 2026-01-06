#!/bin/sh
set -e
# install gettext for envsubst
apt-get update && apt-get install -y gettext-base

export DISTRO_NAME=$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')

envsubst < /home/vagrant/confs/index.html > /usr/share/nginx/html/index.html

nginx -g 'daemon off;'
