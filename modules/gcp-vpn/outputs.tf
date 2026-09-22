output "external_gateway_id" {
  value = google_compute_external_vpn_gateway.aws.id
}

output "tunnel1_name" {
  value = google_compute_vpn_tunnel.tunnel1.name
}

output "tunnel2_name" {
  value = google_compute_vpn_tunnel.tunnel2.name
}

output "tunnel3_name" {
  value = google_compute_vpn_tunnel.tunnel3.name
}

output "tunnel4_name" {
  value = google_compute_vpn_tunnel.tunnel4.name
}
