#!/bin/sh
set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

[ -z "$KEY" ] && KEY=nokey;
HOST=$(hostname)

wget -O netclient https://github.com/gravitl/netmaker/releases/download/latest/netclient
chmod +x netclient
sudo ./netclient join --name $HOST -t $KEY

rm -f netclient
