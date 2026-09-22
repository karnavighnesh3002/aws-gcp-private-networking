output "ha_vpn_gateway_id" {
  value = google_compute_ha_vpn_gateway.this.id
}

output "ha_vpn_gateway_self_link" {
  value = google_compute_ha_vpn_gateway.this.self_link
}

output "ha_vpn_interface0_ip" {
  value = google_compute_ha_vpn_gateway.this.vpn_interfaces[0].ip_address
}

output "ha_vpn_interface1_ip" {
  value = google_compute_ha_vpn_gateway.this.vpn_interfaces[1].ip_address
}

output "cloud_router_id" {
  value = google_compute_router.this.id
}

output "cloud_router_name" {
  value = google_compute_router.this.name
}
