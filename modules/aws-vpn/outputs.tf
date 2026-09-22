output "customer_gateway_0_id" {
  value = aws_customer_gateway.gcp_0.id
}

output "customer_gateway_1_id" {
  value = aws_customer_gateway.gcp_1.id
}

output "vpn_0_id" {
  value = aws_vpn_connection.vpn_0.id
}

output "vpn_1_id" {
  value = aws_vpn_connection.vpn_1.id
}

output "vpn_0_attachment_id" {
  value = aws_vpn_connection.vpn_0.transit_gateway_attachment_id
}

output "vpn_1_attachment_id" {
  value = aws_vpn_connection.vpn_1.transit_gateway_attachment_id
}

output "vpn_0_tunnel1_address" {
  value = aws_vpn_connection.vpn_0.tunnel1_address
}

output "vpn_0_tunnel2_address" {
  value = aws_vpn_connection.vpn_0.tunnel2_address
}

output "vpn_1_tunnel1_address" {
  value = aws_vpn_connection.vpn_1.tunnel1_address
}

output "vpn_1_tunnel2_address" {
  value = aws_vpn_connection.vpn_1.tunnel2_address
}

output "vpn_0_tunnel1_cgw_inside_address" {
  value = aws_vpn_connection.vpn_0.tunnel1_cgw_inside_address
}

output "vpn_0_tunnel2_cgw_inside_address" {
  value = aws_vpn_connection.vpn_0.tunnel2_cgw_inside_address
}

output "vpn_0_tunnel1_vgw_inside_address" {
  value = aws_vpn_connection.vpn_0.tunnel1_vgw_inside_address
}

output "vpn_0_tunnel2_vgw_inside_address" {
  value = aws_vpn_connection.vpn_0.tunnel2_vgw_inside_address
}

output "vpn_1_tunnel1_cgw_inside_address" {
  value = aws_vpn_connection.vpn_1.tunnel1_cgw_inside_address
}

output "vpn_1_tunnel2_cgw_inside_address" {
  value = aws_vpn_connection.vpn_1.tunnel2_cgw_inside_address
}

output "vpn_1_tunnel1_vgw_inside_address" {
  value = aws_vpn_connection.vpn_1.tunnel1_vgw_inside_address
}

output "vpn_1_tunnel2_vgw_inside_address" {
  value = aws_vpn_connection.vpn_1.tunnel2_vgw_inside_address
}
