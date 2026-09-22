variable "region" {
  type = string
}

variable "network_id" {
  type = string
}

variable "ha_vpn_gateway_id" {
  type = string
}

variable "router_name" {
  type = string
}

variable "external_gateway_name" {
  type = string
}

variable "aws_tunnel1_address" {
  type = string
}

variable "aws_tunnel2_address" {
  type = string
}

variable "aws_tunnel3_address" {
  type = string
}

variable "aws_tunnel4_address" {
  type = string
}

variable "tunnel1_inside_cidr" {
  type = string
}

variable "tunnel2_inside_cidr" {
  type = string
}

variable "tunnel3_inside_cidr" {
  type = string
}

variable "tunnel4_inside_cidr" {
  type = string
}

variable "aws_tunnel1_vgw_inside_address" {
  type = string
}

variable "aws_tunnel2_vgw_inside_address" {
  type = string
}

variable "aws_tunnel3_vgw_inside_address" {
  type = string
}

variable "aws_tunnel4_vgw_inside_address" {
  type = string
}

variable "aws_tgw_asn" {
  type = number
}

variable "psk1" {
  type      = string
  sensitive = true
}

variable "psk2" {
  type      = string
  sensitive = true
}

variable "psk3" {
  type      = string
  sensitive = true
}

variable "psk4" {
  type      = string
  sensitive = true
}
