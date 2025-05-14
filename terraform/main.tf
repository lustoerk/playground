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

resource "local_file" "sa_key_file" {
  content  = base64decode(google_service_account_key.ansible_controller_sa_key.private_key)
  filename = "../ansible/ansible-controller-sa-key.json"
}

resource "random_id" "suffix" {
  byte_length = 4
}

# 3. Enable OS Login at the project level
resource "google_compute_project_metadata_item" "enable_os_login" {
  project = var.project_id
  key     = "enable-oslogin"
  value   = "TRUE"
}

# (Optional) Grant your personal user OS Login rights for direct SSH
resource "google_project_iam_member" "user_os_admin_login" {
  count   = var.admin_user_email != "" ? 1 : 0
  project = var.project_id
  role    = "roles/compute.osAdminLogin"
  member  = "user:${var.admin_user_email}"
}