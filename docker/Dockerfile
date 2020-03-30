FROM ubuntu:latest
ADD . /app
WORKDIR /app
# you can comment this out to speed up the Docker build
#RUN bash /app/playbooks/roles/python/templates/setup_python.sh
RUN bash /app/playbooks/roles/python/templates/setup_python3.sh
EXPOSE 8080
