#!/bin/bash
# Program:
#       This program shows "test" in your screen.
# History:
# 2025/03/07    make dockerfile to install python environment   First release

#先備份
mv /etc/apt/sources.list.d/ubuntu.sources /etc/apt/sources.list.d/ubuntu.sources.bak


echo "Types: deb deb-src" > /etc/apt/sources.list.d/ubuntu.sources
echo "URIs: http://tw.archive.ubuntu.com/ubuntu/" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Suites: noble noble-updates noble-backports noble-proposed" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Components: main restricted universe multiverse" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg" >> /etc/apt/sources.list.d/ubuntu.sources
echo "" >> /etc/apt/sources.list.d/ubuntu.sources
echo "" >> /etc/apt/sources.list.d/ubuntu.sources
echo "" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Types: deb deb-src" >> /etc/apt/sources.list.d/ubuntu.sources
echo "URIs: http://security.ubuntu.com/ubuntu/" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Suites: noble-security" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Components: main restricted universe multiverse" >> /etc/apt/sources.list.d/ubuntu.sources
echo "Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg" >> /etc/apt/sources.list.d/ubuntu.sources

#在設定DNS
echo "" >> /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf


#安裝工具
apt-get update
apt-get install -y iputils-ping
apt-get install -y wget
apt-get install -y vim

#安裝開發環境
apt-get install -y build-essential


#安裝Python
#apt install software-properties-common
#add-apt-repository ppa:deadsnakes/ppa
#apt install python3.11.9
wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tgz
tar xzf Python-3.11.4.tgz
cd Python-3.11.4/
./configure --enable-optimizations
make -j $(nproc)
#make altinstall
make install
#alias python="python3.11"
apt install -y python3-pip
apt install -y libpq-dev python3-dev
apt-get install -y virtualenv
#apt install -y python3.12-venv
#apt-get install -y python3.12-dev python3.12-venv
cd ~
virtualenv --python="/usr/bin/python3" python-virtualenv && source python-virtualenv/bin/activate
