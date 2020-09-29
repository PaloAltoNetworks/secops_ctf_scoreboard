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

variable "network_01_name" {
  description = "The name of the first VPC network being created"
  type        = string
  default     = "secops-ctf-scoreboard"
}

/**
 *  Copyright 2020 Palo Alto Networks.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
