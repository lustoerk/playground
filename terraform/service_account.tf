resource "google_service_account" "ansible_service_account" {
  account_id   = "ansible-sa"
  display_name = "Ansible Service Account"
}

resource "google_project_iam_member" "compute_admin" {
  project = var.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.ansible_service_account.email}"
}

resource "google_service_account_key" "ansible_key" {
  service_account_id = google_service_account.ansible_service_account.id
}

resource "local_file" "sa_key" {
    content  = google_service_account_key.ansible_key.private_key
    filename = "../ansible/sa_key.json"
}
