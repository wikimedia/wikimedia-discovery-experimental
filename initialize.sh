#!/bin/bash

set -e

if [ "$(whoami)" != "root" ]; then
  echo
  echo "This script must be run as root:"
  echo "  sudo bash $0 $*"
  echo
  exit 1
  fi

echo "Installing vagrant..."
apt-get -y install virtualbox vagrant

vagrant up
