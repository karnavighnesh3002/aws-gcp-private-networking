variable "aws_region" {
  type        = string
  description = "AWS region for the POC"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
}

variable "aws_vpc_name" {
  type = string
}

variable "aws_vpc_cidr" {
  type = string
}

variable "aws_subnet_name" {
  type = string
}

variable "aws_subnet_cidr" {
  type = string
}

variable "aws_availability_zone" {
  type = string
}

variable "aws_instance_name" {
  type = string
}

variable "aws_instance_private_ip" {
  type = string
}

variable "aws_instance_type" {
  type    = string
  default = "t3.micro"
}

variable "aws_key_name" {
  type        = string
  description = "Existing AWS EC2 key pair name"
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_tgw_name" {
  type = string
}

variable "aws_tgw_asn" {
  type = number
}

variable "gcp_network_name" {
  type = string
}

variable "gcp_subnet_name" {
  type = string
}

variable "gcp_subnet_cidr" {
  type = string
}

variable "gcp_vm_name" {
  type = string
}

variable "gcp_vm_private_ip" {
  type = string
}

variable "gcp_vm_machine_type" {
  type    = string
  default = "e2-micro"
}

variable "gcp_bgp_asn" {
  type = number
}

variable "vpn_customer_gateway_asn" {
  type = number
}

variable "vpn_tunnel1_inside_cidr" {
  type = string
}

variable "vpn_tunnel2_inside_cidr" {
  type = string
}

variable "vpn_tunnel3_inside_cidr" {
  type = string
}

variable "vpn_tunnel4_inside_cidr" {
  type = string
}

variable "vpn_psk_1" {
  type      = string
  sensitive = true
}

variable "vpn_psk_2" {
  type      = string
  sensitive = true
}

variable "vpn_psk_3" {
  type      = string
  sensitive = true
}

variable "vpn_psk_4" {
  type      = string
  sensitive = true
}
