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