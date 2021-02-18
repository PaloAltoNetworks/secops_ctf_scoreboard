FROM ubuntu:latest
LABEL AUTHOR="fdiaz@paloaltonetworks.com"
ENV container secops_ctf
ENV DEBIAN_FRONTEND noninteractive
ADD . /tmp/project
WORKDIR /tmp/project
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y dialog apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt install -y wget unzip
RUN DEBIAN_FRONTEND=noninteractive apt install -y python3-setuptools python3-pip
EXPOSE 8000
