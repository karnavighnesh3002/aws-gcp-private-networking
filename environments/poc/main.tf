module "gcp_network" {
  source = "../../modules/gcp-network"

  network_name    = var.gcp_network_name
  subnet_name     = var.gcp_subnet_name
  subnet_cidr     = var.gcp_subnet_cidr
  region          = var.gcp_region
  zone            = var.gcp_zone
  vm_name         = var.gcp_vm_name
  vm_private_ip   = var.gcp_vm_private_ip
  machine_type    = var.gcp_vm_machine_type
  aws_subnet_cidr = var.aws_subnet_cidr
}

module "gcp_vpn_gateway" {
  source = "../../modules/gcp-vpn-gateway"

  region      = var.gcp_region
  network_id  = module.gcp_network.network_id
  ha_vpn_name = "poc-aws-ha-vpn"
  router_name = "poc-cloud-router"
  router_asn  = var.gcp_bgp_asn
}

module "aws_network" {
  source = "../../modules/aws-network"

  vpc_name            = var.aws_vpc_name
  vpc_cidr            = var.aws_vpc_cidr
  subnet_name         = var.aws_subnet_name
  subnet_cidr         = var.aws_subnet_cidr
  availability_zone   = var.aws_availability_zone
  instance_name       = var.aws_instance_name
  instance_private_ip = var.aws_instance_private_ip
  instance_type       = var.aws_instance_type
  key_name            = var.aws_key_name
  gcp_cidr            = var.gcp_subnet_cidr
}

module "aws_tgw" {
  source = "../../modules/aws-tgw"

  tgw_name  = var.aws_tgw_name
  tgw_asn   = var.aws_tgw_asn
  vpc_id    = module.aws_network.vpc_id
  subnet_id = module.aws_network.subnet_id
}

module "aws_vpn" {
  source = "../../modules/aws-vpn"

  tgw_id               = module.aws_tgw.tgw_id
  customer_gateway_asn = var.vpn_customer_gateway_asn
  gcp_ha_vpn_ip_0      = module.gcp_vpn_gateway.ha_vpn_interface0_ip
  gcp_ha_vpn_ip_1      = module.gcp_vpn_gateway.ha_vpn_interface1_ip
  tunnel1_inside_cidr  = var.vpn_tunnel1_inside_cidr
  tunnel2_inside_cidr  = var.vpn_tunnel2_inside_cidr
  tunnel3_inside_cidr  = var.vpn_tunnel3_inside_cidr
  tunnel4_inside_cidr  = var.vpn_tunnel4_inside_cidr
  psk1                 = var.vpn_psk_1
  psk2                 = var.vpn_psk_2
  psk3                 = var.vpn_psk_3
  psk4                 = var.vpn_psk_4
}

module "gcp_vpn" {
  source = "../../modules/gcp-vpn"

  region                = var.gcp_region
  network_id            = module.gcp_network.network_id
  ha_vpn_gateway_id     = module.gcp_vpn_gateway.ha_vpn_gateway_id
  router_name           = module.gcp_vpn_gateway.cloud_router_name
  external_gateway_name = "poc-aws-external-vpn-gateway"

  aws_tunnel1_address = module.aws_vpn.vpn_0_tunnel1_address
  aws_tunnel2_address = module.aws_vpn.vpn_0_tunnel2_address
  aws_tunnel3_address = module.aws_vpn.vpn_1_tunnel1_address
  aws_tunnel4_address = module.aws_vpn.vpn_1_tunnel2_address

  tunnel1_inside_cidr = var.vpn_tunnel1_inside_cidr
  tunnel2_inside_cidr = var.vpn_tunnel2_inside_cidr
  tunnel3_inside_cidr = var.vpn_tunnel3_inside_cidr
  tunnel4_inside_cidr = var.vpn_tunnel4_inside_cidr

  aws_tunnel1_vgw_inside_address = module.aws_vpn.vpn_0_tunnel1_vgw_inside_address
  aws_tunnel2_vgw_inside_address = module.aws_vpn.vpn_0_tunnel2_vgw_inside_address
  aws_tunnel3_vgw_inside_address = module.aws_vpn.vpn_1_tunnel1_vgw_inside_address
  aws_tunnel4_vgw_inside_address = module.aws_vpn.vpn_1_tunnel2_vgw_inside_address
  aws_tgw_asn                    = var.aws_tgw_asn

  psk1 = var.vpn_psk_1
  psk2 = var.vpn_psk_2
  psk3 = var.vpn_psk_3
  psk4 = var.vpn_psk_4
}

resource "aws_route" "to_gcp" {
  route_table_id         = module.aws_network.route_table_id
  destination_cidr_block = var.gcp_subnet_cidr
  transit_gateway_id     = module.aws_tgw.tgw_id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpn_0" {
  transit_gateway_attachment_id  = module.aws_vpn.vpn_0_attachment_id
  transit_gateway_route_table_id = module.aws_tgw.tgw_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_association" "vpn_1" {
  transit_gateway_attachment_id  = module.aws_vpn.vpn_1_attachment_id
  transit_gateway_route_table_id = module.aws_tgw.tgw_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpn_0" {
  transit_gateway_attachment_id  = module.aws_vpn.vpn_0_attachment_id
  transit_gateway_route_table_id = module.aws_tgw.tgw_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "vpn_1" {
  transit_gateway_attachment_id  = module.aws_vpn.vpn_1_attachment_id
  transit_gateway_route_table_id = module.aws_tgw.tgw_route_table_id
}
