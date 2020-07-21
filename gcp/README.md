# Run Scoreboard in GKE

- bring up the scoreboard like normal
- get GCP setup

```
gcloud auth application-default login
gcloud config set project ctf-sko21

gcloud projects list

docker build -f ./docker/Dockerfile -t secops-ctf-scoreboard:v1 .
docker tag secops-ctf-scoreboard:v1 us.gcr.io/ctf-sko21/secops-ctf-scoreboard:v1
gcloud docker -- push us.gcr.io/ctf-sko21/secops-ctf-scoreboard:v1

gcloud config set container/cluster secops-ctf-scoreboard
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a

gcloud container clusters create secops-cluster --zone us-central1-a --num-nodes 1
kubectl create -f gcp/scoreboard-deployment.yaml
kubectl apply -f gcp/scoreboard-deployment.yaml
```
