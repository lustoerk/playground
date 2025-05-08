# resource "google_dns_managed_zone" "k3s_dns_zone" {
#   name     = "k3s-zone"
#   dns_name = "${var.domain}."
# }

# resource "google_dns_record_set" "k3s_master" {
#   name         = "master.${var.domain}."
#   type         = "A"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.k3s_dns_zone.name

#   rrdatas = [google_compute_instance.k3s_master.network_interface[0].access_config[0].nat_ip]
# }

# resource "google_dns_record_set" "k3s_worker1" {
#   name         = "worker1.${var.domain}."
#   type         = "A"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.k3s_dns_zone.name

#   rrdatas = [google_compute_instance.k3s_worker[0].network_interface[0].access_config[0].nat_ip]
# }

# resource "google_dns_record_set" "k3s_worker2" {
#   name         = "worker2.${var.domain}."
#   type         = "A"
#   ttl          = 300
#   managed_zone = google_dns_managed_zone.k3s_dns_zone.name

#   rrdatas = [google_compute_instance.k3s_worker[1].network_interface[0].access_config[0].nat_ip]
# }
