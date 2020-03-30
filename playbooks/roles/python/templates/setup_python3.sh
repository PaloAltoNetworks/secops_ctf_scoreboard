#!/bin/bash
#
# Author: @theDevilsVoice
# Date: 07/28/2019
if [ -n "$(command -v yum)" ]; 
then 
  yum install -y wget gcc make zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel 
readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
fi
if [ -n "$(command -v apt)" ]; 
then
  apt update
  DEBIAN_FRONTEND="noninteractive" apt install -y wget gcc make zlib1g-dev libffi-dev libssl-dev libncurses5-dev libsqlite3-dev \
      libreadline-dev libtk8.5 libgdm-dev libdb4o-cil-dev libpcap-dev
fi 

if [ ! -f "/tmp/Python-3.7.3.tgz" ];
then
  cd /tmp && \
  wget https://www.python.org/ftp/python/3.7.3/Python-3.7.3.tgz
  tar xzf /tmp/Python-3.7.3.tgz
fi 
# Run the script
cd /tmp/Python-3.7.3 && ./configure --enable-optimizations --prefix=/usr/local --enable-shared && \
make altinstall

# python is installed to /usr/local/bin

if [ -n "$(command -v yum)" ]; 
then 
  echo "/usr/local/lib" > /etc/ld.so.conf.d/franklin.conf
  rm -f /usr/bin/python && ln -s /usr/local/bin/python3.7 /usr/bin/python && ln -s /usr/local/bin/python3.7 /usr/bin/python3
fi
echo "export LD_LIBRARY_PATH=/usr/local/lib" >> /root/.bashrc

