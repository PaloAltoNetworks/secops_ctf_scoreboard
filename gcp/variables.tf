variable "image" {
  description = "Name of the docker image to deploy."
  default     = "gcr.io/project_name/service_name"
}

variable "digest" {
  description = "The docker image digest to deploy."
  default     = "latest"
}

variable "project_name" {
  description = "Google Project ID."
  type        = string
  default = "ctf-sko21"
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone in which to deploy"
  type        = string
  default     = "us-central1-a"
}
