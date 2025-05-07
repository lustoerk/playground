resource "google_compute_instance" "k3s_master" {
  name         = "k3s-master"
  machine_type = var.instance_type
  zone         = var.zone
  tags         = ["k3s-node"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnetwork.id

    access_config {
      // This configures external IPs for SSH use
    }
  }
}

resource "google_compute_instance" "k3s_worker" {
  count        = 2
  name         = "k3s-worker-${count.index}"
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnetwork.id

    access_config {
      // This configures external IPs for SSH use
    }
  }
}
