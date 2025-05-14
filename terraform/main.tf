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

  metadata = {
    // ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }
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

resource "null_resource" "update_hosts" {
  // This triggers the 'create' provisioner when infrastructure is changed.
  provisioner "local-exec" {
    command = "../update_hosts.sh"  // Adjust path as necessary
  }

  // This causes the provisioner to run on 'apply', based on changes to these outputs
  triggers = {
    master_ips  = jsonencode(google_compute_instance.k3s_master.network_interface[0].access_config[0].nat_ip)
    worker_ips  = jsonencode(google_compute_instance.k3s_worker[*].network_interface[0].access_config[0].nat_ip)
  }
}

