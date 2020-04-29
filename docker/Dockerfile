FROM ubuntu:latest
LABEL AUTHOR="fdiaz@paloaltonetworks.com"
ENV container secops_ctf
ENV DEBIAN_FRONTEND noninteractive
ADD . /tmp/project
WORKDIR /tmp/project
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y dialog apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt install -y wget unzip build-essential libssl-dev libffi-dev docker-compose
RUN DEBIAN_FRONTEND=noninteractive apt install -y python3-setuptools python3-pip

RUN make docs

EXPOSE 8000
