#!/bin/bash - 

#
# Date: 02/18/2021
#
sudo apt install libxml2-dev libxslt1-dev
cd /mnt/clusterfs && git clone https://github.com/CTFd/CTFd.git
/mnt/clusterfs/usr/bin/python3 -m venv venv_ctfd
. venv_ctfd/bin/activate
pip install wheel cython
/mnt/clusterfs/venv_ctfd/bin/pip install -r /mnt/clusterfs/CTFd/requirements.txt
