#!/bin/bash

set -e

if [ "$(whoami)" != "root" ]; then
  echo
  echo "This script must be run as root:"
  echo "  sudo bash $0 $*"
  echo
  exit 1
fi

echo "Installing prereqs..."
rm /etc/apt/apt.conf.d/20auto-upgrades.ucf-dist
apt-get -y autoremove
apt-get -y install build-essential libssl-dev linux-headers-$(uname -r)
echo "Installing virtualbox..."
wget http://download.virtualbox.org/virtualbox/5.0.10/virtualbox-5.0_5.0.10-104061~Ubuntu~trusty_amd64.deb
dpkg -i virtualbox-5.0_5.0.10-104061~Ubuntu~trusty_amd64.deb
apt-get -fy install
rm virtualbox-5.0_5.0.10-104061~Ubuntu~trusty_amd64.deb
echo "Installing vagrant..."
apt-get -y install vagrant

git clone https://gerrit.wikimedia.org/r/wikimedia/discovery/experimental /srv/dashboards

cd /srv/dashboards

vagrant up
