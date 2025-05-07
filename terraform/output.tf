output "master_ip" {
  value = google_compute_instance.k3s_master.network_interface[0].access_config[0].nat_ip
}

output "worker_ips" {
  value = google_compute_instance.k3s_worker[*].network_interface[0].access_config[0].nat_ip
}
