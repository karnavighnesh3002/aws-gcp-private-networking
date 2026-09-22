variable "tgw_id" {
  type = string
}

variable "customer_gateway_asn" {
  type = number
}

variable "gcp_ha_vpn_ip_0" {
  type = string
}

variable "gcp_ha_vpn_ip_1" {
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
