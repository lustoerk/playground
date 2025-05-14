resource "google_compute_instance" "k3s_master" {
  name         = "k3s-master"
  machine_type = var.instance_type
  zone         = var.zone
  tags         = ["k3s-node"]
  allow_stopping_for_update = true
  metadata = {
    # enable-oslogin = "TRUE"
    # ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }
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
    # Attach the vm_sa to the instance
  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"] # Full access for the VM's SA to GCP APIs
  }  

  depends_on = [
    google_compute_project_metadata_item.enable_os_login,
    google_service_account.vm_sa,
  ]
}

resource "google_compute_instance" "k3s_worker" {
  count        = 2
  name         = "k3s-worker-${count.index}"
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

  metadata = {
    // ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }
}
