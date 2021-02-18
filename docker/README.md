# Docker

Run `make docker` to get an initial image.

## Work with container

Start and log in to container later.

```bash
docker images
docker ps -a
docker start <container name>
docker exec -it <container name> /bin/bash
```

## Build Container Image

You can create an image for use in k3s/k8s cluster, etc. 

```bash
curl -L https://nixos.org/nix/install | sh
nix-build build_docker_image.nix
docker load < result
```

Cleanup 

```bash
rm result
nix-collect-garbage --delete-older-than 14d
```
