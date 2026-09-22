resource "google_compute_ha_vpn_gateway" "this" {
  name    = var.ha_vpn_name
  region  = var.region
  network = var.network_id
}

resource "google_compute_router" "this" {
  name    = var.router_name
  region  = var.region
  network = var.network_id

  bgp {
    asn = var.router_asn
  }
}
