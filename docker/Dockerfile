FROM ubuntu:latest
ADD . /tmp/project
WORKDIR /tmp/project
#RUN bash /tmp/project/playbooks/roles/python/templates/setup_python3.sh
RUN apt update && apt install -y python3-pip wget unzip

RUN cd /tmp/project; \
if [ ! -f /tmp/project/packer ]; then \
wget https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip; \
unzip /tmp/project/packer_1.5.5_linux_amd64.zip; fi
EXPOSE 8080