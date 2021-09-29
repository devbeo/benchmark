#!/bin/sh
set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

[ -z "$KEY" ] && KEY=nokey;
[ -z "$NAME" ] && NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20);

wget -O netclient https://github.com/gravitl/netmaker/releases/download/latest/netclient
chmod +x netclient

if [[ ${#myvar} -ne 0 ]]; then
   sudo ./netclient join -t $KEY --name $NAME 
fi
sudo ./netclient join -t $KEY
rm -f netclient
