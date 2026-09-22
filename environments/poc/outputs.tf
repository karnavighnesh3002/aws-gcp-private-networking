output "aws_vpc_id" {
  value = module.aws_network.vpc_id
}

output "aws_subnet_id" {
  value = module.aws_network.subnet_id
}

output "aws_ec2_private_ip" {
  value = module.aws_network.instance_private_ip
}

output "gcp_network_id" {
  value = module.gcp_network.network_id
}

output "gcp_subnet_id" {
  value = module.gcp_network.subnet_id
}

output "gcp_vm_private_ip" {
  value = module.gcp_network.vm_private_ip
}

output "aws_tgw_id" {
  value = module.aws_tgw.tgw_id
}

output "aws_vpn_0_id" {
  value = module.aws_vpn.vpn_0_id
}

output "aws_vpn_1_id" {
  value = module.aws_vpn.vpn_1_id
}

output "gcp_ha_vpn_gateway_id" {
  value = module.gcp_vpn_gateway.ha_vpn_gateway_id
}

output "gcp_cloud_router_id" {
  value = module.gcp_vpn_gateway.cloud_router_id
}
