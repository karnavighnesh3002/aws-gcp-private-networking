output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "subnet_id" {
  value = aws_subnet.private.id
}

output "subnet_cidr" {
  value = aws_subnet.private.cidr_block
}

output "route_table_id" {
  value = aws_route_table.private.id
}

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_private_ip" {
  value = aws_instance.this.private_ip
}
