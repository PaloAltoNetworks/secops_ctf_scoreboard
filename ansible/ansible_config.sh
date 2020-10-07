#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

function ansible_setup {
    apt update
    apt install -y software-properties-common
    apt-add-repository --yes --update ppa:ansible/ansible
    apt install -y ansible
    rm /etc/apt/sources.list.d/ansible-ubuntu-ansible-focal.list
}

function gopher_setup {
    apt install -y python2.7
    wget http://lug.mtu.edu/ubuntu/pool/universe/s/simpletal/python-simpletal_4.1-9_all.deb
    dpkg -i python-simpletal_4.1-9_all.deb
    wget http://lug.mtu.edu/ubuntu/pool/universe/p/pygopherd/pygopherd_2.0.18.5_all.deb
    dpkg -i ./pygopherd_2.0.18.5_all.deb
    rm python-simpletal_4.1-9_all.deb pygopherd_2.0.18.5_all.deb
}

ansible_setup
gopher_setup
ansible-playbook --connection=local /home/ubuntu/secops_ctf/ansible/webserver.yml