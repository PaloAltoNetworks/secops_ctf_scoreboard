provider "google" {
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

provider "google-beta" {
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

module "firewall" {
  source                = "./modules/firewall"
  project_id            = var.project_name
  gcp_region_1          = var.region
  network_01_name       = var.network_01_name
}

resource "google_cloud_run_service" "service" {
  name     = var.name
  location = "dev"
  provider = google-beta

  metadata {
    namespace = var.name
  }

  template {
    spec {
      containers {
        image = "${var.image}@${var.digest}"
        resources {
          limits = {
            cpu    = "1000m"
            memory = "1024Mi"
          }
        }
      }
    }
  }
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
