#!/bin/bash - 
#===============================================================================
#
#          FILE: ctfd.sh
# 
#         USAGE: ./ctfd.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 03/31/2020 16:42
#      REVISION:  ---
#===============================================================================

git clone https://github.com/CTFd/CTFd.git
bash CTFd/prepare.sh
bash CTFd/scripts/install_docker.sh
newgrp docker
docker run -p 8000:8000 -it ctfd/ctfd


