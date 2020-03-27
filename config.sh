  
#!/bin/bash
#
# Author: @theDevilsVoice
# Date: 10/13/2017
#
# Script Name: config.sh
#
# Description: Use this shell script to ensure your system
#              is ready for the class.
#
# Run Information:
#
# Error Log: Any output found in /path/to/logfile
#

#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

#################
# Error Counter #
#################
ERROR_COUNTER=0

###################################
# Check if terraform is installed #
###################################
function check_terraform {
  echo -e "${LPURP}***** Check terraform setup *****${NC}"
  if which terraform ; then
    echo -e "${CYAN}"
    terraform version
    echo -e "${NC}"
  else
    echo -e "${YELLOW}"
    echo "Terraform binary not found"
    echo "Instructions to install terraform: "
    echo "https://www.terraform.io/intro/getting-started/install.html"
    echo -e "${NC}"
    exit 1
  fi
}

#################################
# Confirm digital ocean TF_VARS #
#################################
function check_do_vars {
  echo -e "${LPURP}***** Check TF_VARS for Digital Ocean *****${NC}"
  TF=`cat ~/.bashrc | grep TF_VAR | cut -d'=' -f1`
  if [ -z "$TF" ] ; then
    echo -e "${CYAN}"
    echo "Found properly formatted DigitalOcean credentials"
    echo -e "${NC}"
  else
    echo -e "${YELLOW}"
    echo "Digial Ocean TF_VARS not found in .bashrc!"
    echo "Digital Ocean provisioning won't work right."
    echo ""
    echo "Be sure these are added to the end of .bashrc:"
    echo ""
    echo "export TF_VAR_do_token="
    echo "export TF_VAR_pub_key="
    echo "export TF_VAR_pvt_key="
    echo "export TF_VAR_ssh_fingerprint="
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  fi
}

#########################
# Check for puppet-lint #
#########################
function check_puppet_lint {
  echo -e "${LPURP}***** Check if puppet-lint is installed *****${NC}"
  PL="$(gem list -i '^puppet-lint$')"
  if [ ! "$PL" ] ; then
    echo -e "${YELLOW}"
    echo "Could not find puppet-lint installed on this host"
    echo "Get it from http://puppet-lint.com/"
    echo -e "${NC}"
    # This isn't really a showstopper so not counting as an error
    #ERROR_COUNTER=$((ERROR_COUNTER+1))
  fi
}

#############################
# Confirm AWS configuration #
#############################
function check_aws {
  echo -e "${LPURP}***** Confirm AWS Configuration *****${NC}"
  MY_PATH=`eval echo "~$SUDO_USER"`
  if ! ls $MY_PATH/.aws/credentials ; then
    echo -e "${YELLOW}"
    echo "No ~/.aws/credentials found!"
    echo "Follow the steps at: http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html"
    echo ""
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  else
    echo -e "${LPURP}"
    echo "FOUND: $MY_PATH/.aws/credentials"
    echo -e "${NC}"
  fi
}

####################
# Check for tfvars #
####################
function check_terra_config {
  echo -e "${LPURP}***** Check  for terraform.tfvars file *****${NC}"
  if [ ! -f ${PWD}/aws/terraform.tfvars ] ; then
    echo -e "${YELLOW}"
    echo "${PWD}/aws/terraform.tfvars not found!"
    echo "Amazon AWS won't work right."
    echo "The file should have two lines."
    echo ""
    echo "Example:"
    echo ""
    echo "aws_access_key = \"KLJAHSDFKJASHDLKJASHD\""
    echo "aws_secret_key = \"ljasdfjlkjasdflkjasdflkajd98345\""
    echo -e "${NC}"
    ERROR_COUNTER=$((ERROR_COUNTER+1))
  else
    echo -e "${CYAN}"
    echo "Found tfvars file in ${PWD}/terraform/aws/terraform.tfvars"
    echo -e "${NC}"
  fi
}

#############################
# Do stuff for Debian based #
#############################
function config_deb {
  echo -e "${LPURP}***** Do the Debian Setup *****${NC}"
  grep -Ei 'debian|buntu|mint' /etc/*release
  sudo apt-get install software-properties-common gnupg git \
  python-pip mlocate awscli
  echo -e "${CYAN}"

  PYVER=`python3 -V`
  if [ -z "$PYVER" ] ; then
    echo "$PYVER"
    sudo apt-get -y install python3-pip
  else
    echo "need to install python?"
  fi
  if which aws ; then
    aws --version
  else
    echo "Need to install awscli"
    python3 -m pip install awscli
    #pip install awscli --upgrade --user
  fi
  if which ansible; then
    ansible --version
  else
    echo "Need to install awscli"
    python3 -m pip install awscli
    #pip install awscli --upgrade --user
  fi
  if ! which packer ; then
    wget https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip
    unzip packer_1.5.5_linux_amd64.zip
    mv packer /usr/local/bin
    rm packer_1.5.5_linux_amd64.zip
  else
    echo "Found Packer"
  fi
  echo -e "${NC}"
}

#######################
# Do stuff for RedHat #
#######################
function config_redhat {
  echo -e "${LPURP}***** Do the RedHat setup *****${NC}"
  sudo yum update -y
  sudo yum groupinstall 'Development Tools'
}

########################
# Do stuff for FreeBSD #
########################

########################
# Do stuff for OpenBSD #
########################
function config_obsd {
  echo -e "${LPURP}***** Do the Setup for OpenBSD *****${NC}"
  echo 'export PKG_PATH=ftp://mirror.planetunix.net/pub/OpenBSD/`uname -r`/packages/`machine -a`/' >> ~/.profile
  #pkg_add -Uu
  pkg_add ftp://mirror.planetunix.net/OpenBSD/`uname -r`/packages/`machine -a`/python-2.7.13p0.tgz
  ln -sf /usr/local/bin/python2.7 /usr/local/bin/python
  ln -sf /usr/local/bin/python2.7-2to3 /usr/local/bin/2to3
  ln -sf /usr/local/bin/python2.7-config /usr/local/bin/python-config
  #ln -sf /usr/local/bin/pydoc2.7  /usr/local/bin/pydoc
  pkg_add py-pip py-boto
  pkg_add -i -v bash
  pip install awscli aws-shell terraform
  #/usr/bin/doas -u root pkg_add -v bash
}

######################
# Do Stuff for Apple #
######################
function config_apple {
  echo -e "${LPURP}***** Do the Setup for Mac *****${NC}"
  if which brew ; then
    brew update
    brew upgrade
    if ! which terraform ; then
       echo -e "${CYAN}"
       echo "Install terraform"
       brew install terraform
       echo -e "${NC}"
    else
      echo "Found terraform"
    fi
    if ! which aws ; then
      echo -e "${CYAN}"
      echo "install awscli"
      brew install awscli
      echo -e "${NC}"
    else
      echo "found awscli"
    fi
    if ! packer version ; then
      echo -e "${CYAN}"
      echo "install packer"
      brew install packer
      echo -e "${NC}"
    else
      echo "found packer"
    fi
    if ! which ansible-playbook ; then
      echo -e "${CYAN}"
      echo "install ansible-playbook"
      brew install ansible
      echo -e "${NC}"
    else
      echo "found ansible"
    fi
    # alternative awscli install method, requires brew
    #cd /tmp && curl -o awscli.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
    #unzip /tmp/awscli.zip
    #sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
    echo -e "${LPURP}***** Mac Setup Complete *****${NC}"
  else
    echo -e "${YELLOW}"
    echo "Install brew from here: https://brew.sh/ and run this script again."
    #/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    echo -e "${NC}"
    exit 1
  fi

  return 0
}

function check_if_root {

  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
  else 
    echo "Running as root" 
  fi

  return 0
}

#########################
# Print the ERROR_COUNT #
#########################
function show_summary {
  if [[ "$ERROR_COUNTER" -gt 0 ]] ; then
    echo -e "${LRED}"
    echo "Oh no, $ERROR_COUNTER errors found."
    echo "Please correct the errors and run this script again."
    echo -e "${NC}"
  else
    echo -e "${LGREEN}"
    echo "No errors. All clean and green."
    echo -e "${NC}"
  fi
}

function main {

  if [ "$(uname)" == "Darwin" ]; then
    config_apple
  elif [ "$(uname)" == "OpenBSD" ]; then
    config_obsd
  elif [ "$(grep -Ei 'fedora|redhat' /etc/*release)" ]; then
    check_if_root
    config_redhat
    check_terraform
  elif [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then
    check_if_root
    config_deb
    check_terraform
  else
    echo "Unable to auto-configure this architecture"
    echo "Please make sure you have all the right packages installed"
    #exit 1
  fi
  check_aws
  check_terra_config
  show_summary

}

main
