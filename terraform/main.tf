resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.instance_type
  # tags         = var.tags
  zone         = var.zone
  allow_stopping_for_update = true

  labels = {
    environment = "dev"
    #role = "mongodb"
  }

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = var.network

    access_config {
      // Ephemeral public IP
      # nat_ip = "${google_compute_address.static.address}"
    }
  }

  # service_account {
  #   email = "${var.service_account}"
  #   scopes = ["cloud-platform"]
  # }

  # metadata_startup_script  = "${file("./start.sh")}"
}

output "IP" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}