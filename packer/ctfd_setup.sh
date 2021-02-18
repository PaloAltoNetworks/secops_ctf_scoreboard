#!/bin/bash - 
#===========================================================
#          FILE: ctfd_setup.sh
#         USAGE: bash ctfd_setup.sh 
#   DESCRIPTION: 
#        AUTHOR: Franklin Diaz (fdiaz@paloaltonetworks.com), 
#  ORGANIZATION: 
#       CREATED: 03/31/2020 16:42
#      REVISION:  0.2
#============================================================

if [ ! -d "/home/ubuntu/CTFd" ]; then
  cd /home/ubuntu && git clone https://github.com/CTFd/CTFd.git
  cd /home/ubuntu/CTFd && sudo bash prepare.sh
  sudo apt -y install docker-compose
  sudo bash /home/ubuntu/CTFd/scripts/install_docker.sh
  sudo chmod a+rw /var/run/docker.sock
fi
if [[ $(pip) ]]; then
  echo "found pip2"
else
  sudo add-apt-repository universe
  sudo apt update 
  sudo apt -y install python2
  curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
  sudo python2 get-pip.py
fi
if [[ $(pip3) ]]; then
  sudo apt -y install python3-pip
fi
if [[ $(docker ps | grep -v COMMAND) ]]; 
then
  echo "docker running"
  exit 0
else
  echo "starting docker"
  sudo docker run -d --rm -p 8000:8000 -it ctfd/ctfd
fi
