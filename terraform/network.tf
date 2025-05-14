resource "google_compute_network" "vpc_network" {
  project = var.project_id
  name = "k3s-network"
}

resource "google_compute_subnetwork" "subnetwork" {
  project = var.project_id
  name          = "k3s-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.vpc_network.id
  region        = var.region
}

resource "google_compute_firewall" "ssh-rule" {
  project = var.project_id
  name = "ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  
  target_tags = ["k3s-node"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "k3s-rule" {
  project = var.project_id
  name = "k3s"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports = ["6443"]
  }

  target_tags = ["k3s-node"]
  source_ranges = ["0.0.0.0/0"]
}

