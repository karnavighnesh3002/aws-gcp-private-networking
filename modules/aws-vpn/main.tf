resource "aws_customer_gateway" "gcp_0" {
  bgp_asn    = var.customer_gateway_asn
  ip_address = var.gcp_ha_vpn_ip_0
  type       = "ipsec.1"

  tags = {
    Name = "poc-gcp-customer-gateway-0"
  }
}

resource "aws_customer_gateway" "gcp_1" {
  bgp_asn    = var.customer_gateway_asn
  ip_address = var.gcp_ha_vpn_ip_1
  type       = "ipsec.1"

  tags = {
    Name = "poc-gcp-customer-gateway-1"
  }
}

resource "aws_vpn_connection" "vpn_0" {
  customer_gateway_id = aws_customer_gateway.gcp_0.id
  transit_gateway_id  = var.tgw_id

  type               = "ipsec.1"
  static_routes_only = false

  tunnel1_inside_cidr   = var.tunnel1_inside_cidr
  tunnel2_inside_cidr   = var.tunnel2_inside_cidr
  tunnel1_preshared_key = var.psk1
  tunnel2_preshared_key = var.psk2

  tags = {
    Name = "poc-aws-gcp-vpn-0"
  }
}

resource "aws_vpn_connection" "vpn_1" {
  customer_gateway_id = aws_customer_gateway.gcp_1.id
  transit_gateway_id  = var.tgw_id

  type               = "ipsec.1"
  static_routes_only = false

  tunnel1_inside_cidr   = var.tunnel3_inside_cidr
  tunnel2_inside_cidr   = var.tunnel4_inside_cidr
  tunnel1_preshared_key = var.psk3
  tunnel2_preshared_key = var.psk4

  tags = {
    Name = "poc-aws-gcp-vpn-1"
  }
}
