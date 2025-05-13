terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 0.13"
}

terraform {
    backend "gcs" {
      bucket = "23f48053572b634d-terraform-remote-backend"
    }
  }

provider "google" {
  project     = var.project_id
  region      = var.region
}
