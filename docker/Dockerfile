FROM ubuntu:latest
ADD . /tmp/project
WORKDIR /tmp/project
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y wget unzip build-essential libssl-dev libffi-dev docker-compose
RUN apt install -y python-dev python-pip

EXPOSE 8000
