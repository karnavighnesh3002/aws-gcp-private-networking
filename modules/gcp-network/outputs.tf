output "network_id" {
  value = google_compute_network.this.id
}

output "network_self_link" {
  value = google_compute_network.this.self_link
}

output "subnet_id" {
  value = google_compute_subnetwork.private.id
}

output "subnet_self_link" {
  value = google_compute_subnetwork.private.self_link
}

output "subnet_cidr" {
  value = google_compute_subnetwork.private.ip_cidr_range
}

output "vm_name" {
  value = google_compute_instance.this.name
}

output "vm_private_ip" {
  value = google_compute_instance.this.network_interface[0].network_ip
}
