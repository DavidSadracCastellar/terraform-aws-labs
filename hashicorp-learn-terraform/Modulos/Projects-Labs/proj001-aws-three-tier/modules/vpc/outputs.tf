output vpc_id {
  value       = aws_vpc.this.id
  description = "The ID of the VPC"
}

output subnet_public_id {
  value       = aws_subnet.public.id
  description = "The ID of Subnet Public"
}

output subnet_private_id {
  value       = aws_subnet.private.id
  description = "The ID of Subnet Private"
}

output subnet_protected_id {
  value       = aws_subnet.protected.id
  description = "The ID of Subnet Protected"
}

output sg_public_http_id {
  value       = aws_security_group.allow_http_anywhere.id
  description = "The ID of Security Group allow HTTP anywhere"
}

output sg_public_ssh_id {
  value       = aws_security_group.allow_ssh_anywhere.id
  description = "The ID of Security Group allow SSH anywhere"
}


