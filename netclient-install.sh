#!/bin/sh
set -e

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check release
if [ -f /etc/redhat-release ]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
fi

if [ "${release}" == "centos" ]; then
    yum -y install wireguard wireguard-tools > /dev/null 2>&1
else
    apt-get update > /dev/null 2>&1
    apt-get -y install wireguard wireguard-tools > /dev/null 2>&1
fi

[ -z "$KEY" ] && KEY=nokey;
[ -z "$NAME" ] && NAME=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 20);

wget -O netclient https://github.com/gravitl/netmaker/releases/download/latest/netclient
chmod +x netclient

if [[ ${#NAME} -ne 0 ]]; then
   sudo ./netclient join -t $KEY --name $NAME
else
   sudo ./netclient join -t $KEY   
fi

rm -f netclient
