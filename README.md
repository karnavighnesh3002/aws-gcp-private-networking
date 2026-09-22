# AWS-GCP Private Networking

This project models a four-tunnel AWS-to-GCP private network:

- AWS VPC `172.16.0.0/16` with a private EC2 instance in `172.16.1.0/24`
- AWS Transit Gateway with ASN `64512`
- Two AWS VPN connections, with two BGP/IPsec tunnels each
- GCP VPC subnet `172.20.1.0/24` with a private VM
- GCP HA VPN, Cloud Router ASN `65001`, four router interfaces, and four BGP peers

## Important: existing infrastructure

The configuration is capable of creating resources, but the POC was created manually. Do not run `terraform apply` against an existing environment before importing matching resources and reviewing the plan. Resource names and CIDRs alone are not enough: collect the actual AWS and GCP IDs first.

Use read-only inventory commands:

```powershell
aws ec2 describe-vpcs --region us-east-1
aws ec2 describe-subnets --region us-east-1
aws ec2 describe-route-tables --region us-east-1
aws ec2 describe-transit-gateways --region us-east-1
aws ec2 describe-transit-gateway-vpc-attachments --region us-east-1
aws ec2 describe-transit-gateway-route-tables --region us-east-1
aws ec2 describe-vpn-connections --region us-east-1
aws ec2 describe-customer-gateways --region us-east-1
```

```powershell
gcloud compute networks list --project=ccd-poc-project
gcloud compute networks subnets list --regions=us-central1 --project=ccd-poc-project
gcloud compute vpn-gateways list --regions=us-central1 --project=ccd-poc-project
gcloud compute vpn-tunnels list --regions=us-central1 --project=ccd-poc-project
gcloud compute external-vpn-gateways list --project=ccd-poc-project
gcloud compute routers describe poc-cloud-router --region=us-central1 --project=ccd-poc-project
```

The GCP account needs permission to view Compute VPNs and routers. The AWS identity needs permission to describe EC2, Transit Gateway, VPN, and customer gateway resources.

## Authentication

AWS credentials must come from an AWS profile or environment variables. GCP uses Application Default Credentials. Do not put either cloud provider's credentials in Terraform files.

VPN pre-shared keys are sensitive and can be written to Terraform state. Do not commit them, print them, or put them in `terraform.tfvars`. Supply them through a protected secret mechanism, for example:

```powershell
$env:TF_VAR_vpn_psk_1 = "..."
$env:TF_VAR_vpn_psk_2 = "..."
$env:TF_VAR_vpn_psk_3 = "..."
$env:TF_VAR_vpn_psk_4 = "..."
```

## Safe workflow

From `environments/poc`:

```powershell
terraform init
terraform fmt -recursive
terraform validate
terraform plan
```

For an existing deployment, import only after confirming that each resource matches the configuration. The important module addresses are:

```text
module.aws_network.aws_vpc.this
module.aws_network.aws_subnet.private
module.aws_network.aws_route_table.private
module.aws_network.aws_route_table_association.private
module.aws_network.aws_security_group.ec2
module.aws_network.aws_instance.this
module.aws_tgw.aws_ec2_transit_gateway.this
module.aws_tgw.aws_ec2_transit_gateway_route_table.this
module.aws_tgw.aws_ec2_transit_gateway_vpc_attachment.this
module.aws_tgw.aws_ec2_transit_gateway_route_table_association.vpc
module.aws_vpn.aws_customer_gateway.gcp_0
module.aws_vpn.aws_customer_gateway.gcp_1
module.aws_vpn.aws_vpn_connection.vpn_0
module.aws_vpn.aws_vpn_connection.vpn_1
module.gcp_network.google_compute_network.this
module.gcp_network.google_compute_subnetwork.private
module.gcp_network.google_compute_instance.this
module.gcp_network.google_compute_firewall.ssh_from_aws
module.gcp_network.google_compute_firewall.iap_ssh
module.gcp_vpn_gateway.google_compute_ha_vpn_gateway.this
module.gcp_vpn_gateway.google_compute_router.this
module.gcp_vpn.google_compute_external_vpn_gateway.aws
module.gcp_vpn.google_compute_vpn_tunnel.tunnel1
module.gcp_vpn.google_compute_vpn_tunnel.tunnel2
module.gcp_vpn.google_compute_vpn_tunnel.tunnel3
module.gcp_vpn.google_compute_vpn_tunnel.tunnel4
module.gcp_vpn.google_compute_router_interface.interface1
module.gcp_vpn.google_compute_router_interface.interface2
module.gcp_vpn.google_compute_router_interface.interface3
module.gcp_vpn.google_compute_router_interface.interface4
module.gcp_vpn.google_compute_router_peer.peer1
module.gcp_vpn.google_compute_router_peer.peer2
module.gcp_vpn.google_compute_router_peer.peer3
module.gcp_vpn.google_compute_router_peer.peer4
```

Use `terraform import ADDRESS ID` with the provider's documented ID format. Do not guess IDs, and do not import a resource into a different address. After importing, run `terraform plan` and investigate every proposed replacement or deletion. A zero-change plan is the gate before any apply.

The four link-local tunnel CIDRs and tunnel endpoint mapping must match the existing VPN configuration. Do not replace existing values with the example `/30` ranges without checking the AWS tunnel details and GCP BGP status.

## New deployment order

For an empty account, Terraform resolves the dependency graph as:

1. AWS and GCP workload networks
2. GCP HA VPN gateway and Cloud Router
3. AWS Transit Gateway and VPC attachment
4. AWS customer gateways and two dynamic VPN connections
5. GCP external VPN gateway, four tunnels, interfaces, and BGP peers
6. AWS VPC and Transit Gateway routes

This project intentionally does not run `terraform apply` automatically.
