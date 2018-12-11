#!/bin/bash

set -ex

if [ -d archive ]; then
    cd archive
    apt-ftparchive packages . > Packages

    sudo su -c 'echo "deb [trusted=yes] file:$(pwd)/ ./" >>  /etc/apt/sources.list'

    sudo apt-get update
fi

sudo DEBIAN_FRONTEND=noninteractive apt-get install --allow-unauthenticated -y icinga2 icinga2-ido-mysql mysql-server

sudo icinga2 feature list

sudo icinga2 daemon -C
