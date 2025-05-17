output "master_ip" {
  value = google_compute_instance.k3s_master.network_interface[0].access_config[0].nat_ip
}

output "worker_ips" {
  value = google_compute_instance.k3s_worker[*].network_interface[0].access_config[0].nat_ip
}

output "ansible_controller_sa_email" {
  value       = google_service_account.ansible_controller_sa.email
  description = "Email of the Ansible Controller Service Account."
}

output "ansible_controller_sa_key_path" {
  value       = abspath("ansible-controller-sa-key.json")
  description = "Path to the downloaded SA key. Use this for Ansible authentication."
}

output "ansible_controller_sa_key_content_sensitive" {
  value       = base64decode(google_service_account_key.ansible_controller_sa_key.private_key)
  description = "The content of the SA key (sensitive)."
  sensitive   = true
}
