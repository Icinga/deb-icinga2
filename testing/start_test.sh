#!/bin/bash

set -ex

if [ -d archive ]; then
    cd archive
    apt-ftparchive packages . > Packages

    sudo su -c 'echo "deb [trusted=yes] file:$(pwd)/ ./" >>  /etc/apt/sources.list'

    sudo apt-get update
fi

sudo bash -xe <<ROOTSHELL
    export DEBIAN_FRONTEND=noninteractive

    if ! apt-get install -y default-mysql-server; then
        # Fallback to non-metapackage on older distributions
        apt-get install -y mysql-server
    fi

    apt-get install --allow-unauthenticated -y icinga2 icinga2-ido-mysql

    icinga2 feature list
    icinga2 daemon -C
ROOTSHELL
