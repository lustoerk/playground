# 1. Service Account for Ansible Controller
resource "google_service_account" "ansible_controller_sa" {
  project      = var.project_id
  account_id   = "ansible-controller-${random_id.suffix.hex}"
  display_name = "Ansible Controller SA"
  description  = "Service Account for Ansible to manage GCP resources and use OS Login"
}

# Key for the Ansible Controller SA (to be used on your workstation)
resource "google_service_account_key" "ansible_controller_sa_key" {
  service_account_id = google_service_account.ansible_controller_sa.name
}

# Permissions for Ansible Controller SA:
# - List compute instances (for dynamic inventory)
resource "google_project_iam_member" "ansible_sa_compute_viewer" {
  project = var.project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.ansible_controller_sa.email}"
}

# - OS Admin Login (to SSH with sudo via OS Login as this SA)
resource "google_project_iam_member" "ansible_sa_os_admin_login" {
  project = var.project_id
  role    = "roles/compute.osAdminLogin" # or roles/compute.osLogin for no sudo
  member  = "serviceAccount:${google_service_account.ansible_controller_sa.email}"
}

# - (Optional) Allow this SA to impersonate other SAs (like the vm_sa)
#   Useful if Ansible playbooks need to make GCP API calls as the target VM's SA
resource "google_project_iam_member" "ansible_sa_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator" # Needed for impersonation
  member  = "serviceAccount:${google_service_account.ansible_controller_sa.email}"
}
resource "google_project_iam_member" "ansible_sa_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser" # Needed for impersonation
  member  = "serviceAccount:${google_service_account.ansible_controller_sa.email}"
}


# 2. Service Account for VMs (optional, but good practice)
resource "google_service_account" "vm_sa" {
  project      = var.project_id
  account_id   = "vm-app-default-${random_id.suffix.hex}"
  display_name = "VM Application Default SA"
  description  = "Service Account for GCE instances to run applications"
}

# Grant vm_sa minimal permissions it might need (example: logging, monitoring)
resource "google_project_iam_member" "vm_sa_logging" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_project_iam_member" "vm_sa_monitoring" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}