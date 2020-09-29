# Run Scoreboard in GKE

- bring up the scoreboard like normal

## get GCP setup in Machine

```bash
sudo snap install google-cloud-sdk --classic
gcloud config set project ctf-sko21
gcloud auth application-default login
gcloud projects list
```

- Now create the docker image and push to GCloud

```bash
docker build -f ./docker/Dockerfile -t secops-ctf-scoreboard:v1 .
docker tag secops-ctf-scoreboard:v1 us.gcr.io/ctf-sko21/secops-ctf-scoreboard:v1
gcloud docker -- push us.gcr.io/ctf-sko21/secops-ctf-scoreboard:v1
```

## Bring up K8s Cluster by hand

- Once the image is uploaded you can create the cluster and bring up the image.

```bash
gcloud config set container/cluster secops-ctf-scoreboard
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a
gcloud container clusters create secops-cluster --zone us-central1-a --num-nodes 1
kubectl create -f gcp/scoreboard-deployment.yaml
kubectl apply -f gcp/scoreboard-deployment.yaml
```

## Bring up K8s Cluster via Terraform

bash```
```
