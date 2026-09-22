resource "google_compute_external_vpn_gateway" "aws" {
  name            = var.external_gateway_name
  redundancy_type = "FOUR_IPS_REDUNDANCY"

  interface {
    id         = 0
    ip_address = var.aws_tunnel1_address
  }

  interface {
    id         = 1
    ip_address = var.aws_tunnel2_address
  }

  interface {
    id         = 2
    ip_address = var.aws_tunnel3_address
  }

  interface {
    id         = 3
    ip_address = var.aws_tunnel4_address
  }
}

resource "google_compute_vpn_tunnel" "tunnel1" {
  name                            = "poc-gcp-vpn-tunnel-1"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws.id
  peer_external_gateway_interface = 0
  shared_secret                   = var.psk1
  ike_version                     = 2
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "tunnel2" {
  name                            = "poc-gcp-vpn-tunnel-2"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws.id
  peer_external_gateway_interface = 1
  shared_secret                   = var.psk2
  ike_version                     = 2
  vpn_gateway_interface           = 1
}

resource "google_compute_vpn_tunnel" "tunnel3" {
  name                            = "poc-gcp-vpn-tunnel-3"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws.id
  peer_external_gateway_interface = 2
  shared_secret                   = var.psk3
  ike_version                     = 2
  vpn_gateway_interface           = 0
}

resource "google_compute_vpn_tunnel" "tunnel4" {
  name                            = "poc-gcp-vpn-tunnel-4"
  region                          = var.region
  vpn_gateway                     = var.ha_vpn_gateway_id
  peer_external_gateway           = google_compute_external_vpn_gateway.aws.id
  peer_external_gateway_interface = 3
  shared_secret                   = var.psk4
  ike_version                     = 2
  vpn_gateway_interface           = 1
}

resource "google_compute_router_interface" "interface1" {
  name       = "poc-bgp-interface-1"
  router     = var.router_name
  region     = var.region
  ip_range   = var.tunnel1_inside_cidr
  vpn_tunnel = google_compute_vpn_tunnel.tunnel1.name
}

resource "google_compute_router_interface" "interface2" {
  name       = "poc-bgp-interface-2"
  router     = var.router_name
  region     = var.region
  ip_range   = var.tunnel2_inside_cidr
  vpn_tunnel = google_compute_vpn_tunnel.tunnel2.name
}

resource "google_compute_router_interface" "interface3" {
  name       = "poc-bgp-interface-3"
  router     = var.router_name
  region     = var.region
  ip_range   = var.tunnel3_inside_cidr
  vpn_tunnel = google_compute_vpn_tunnel.tunnel3.name
}

resource "google_compute_router_interface" "interface4" {
  name       = "poc-bgp-interface-4"
  router     = var.router_name
  region     = var.region
  ip_range   = var.tunnel4_inside_cidr
  vpn_tunnel = google_compute_vpn_tunnel.tunnel4.name
}

resource "google_compute_router_peer" "peer1" {
  name                      = "poc-bgp-peer-1"
  router                    = var.router_name
  region                    = var.region
  interface                 = google_compute_router_interface.interface1.name
  peer_ip_address           = var.aws_tunnel1_vgw_inside_address
  peer_asn                  = var.aws_tgw_asn
  advertised_route_priority = 100
}

resource "google_compute_router_peer" "peer2" {
  name                      = "poc-bgp-peer-2"
  router                    = var.router_name
  region                    = var.region
  interface                 = google_compute_router_interface.interface2.name
  peer_ip_address           = var.aws_tunnel2_vgw_inside_address
  peer_asn                  = var.aws_tgw_asn
  advertised_route_priority = 100
}

resource "google_compute_router_peer" "peer3" {
  name                      = "poc-bgp-peer-3"
  router                    = var.router_name
  region                    = var.region
  interface                 = google_compute_router_interface.interface3.name
  peer_ip_address           = var.aws_tunnel3_vgw_inside_address
  peer_asn                  = var.aws_tgw_asn
  advertised_route_priority = 100
}

resource "google_compute_router_peer" "peer4" {
  name                      = "poc-bgp-peer-4"
  router                    = var.router_name
  region                    = var.region
  interface                 = google_compute_router_interface.interface4.name
  peer_ip_address           = var.aws_tunnel4_vgw_inside_address
  peer_asn                  = var.aws_tgw_asn
  advertised_route_priority = 100
}
