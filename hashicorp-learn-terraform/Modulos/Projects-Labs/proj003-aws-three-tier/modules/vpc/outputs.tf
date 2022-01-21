output vpc_id {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output subnet_public_one_id {
  value       = aws_subnet.public_one.id
  description = "The ID of Subnet Public one"
}

output subnet_public_two_id {
  value       = aws_subnet.public_two.id
  description = "The ID of Subnet Public two"
}

output subnet_private_one_id {
  value       = aws_subnet.private_one.id
  description = "The ID of Subnet Private one"
}

output subnet_private_two_id{
  value       = aws_subnet.private_two.id
  description = "The ID of Subnet Private two"
}

output sg_public_http_id {
    value       = aws_security_group.public_http_anywhere.id
    description = "The ID of Security Group allow HTTP anywhere Public"
}

output sg_private_http_id {
    value       = aws_security_group.private_http_anywhere.id
    description = "The ID of Security Group allow HTTP anywhere Private"
}

output sg_public_ssh_id {
    value       = aws_security_group.public_ssh_anywhere.id
    description = "The ID of Security Group allow SSH anywhere Public"
}

output sg_private_ssh_id {
    value       = aws_security_group.private_ssh_anywhere.id
    description = "The ID of Security Group allow SSH anywhere Private"
}
