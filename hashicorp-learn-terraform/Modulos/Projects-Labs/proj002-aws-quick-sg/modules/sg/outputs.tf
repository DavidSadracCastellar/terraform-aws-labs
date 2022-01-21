output sg_http_id {
  value       = aws_security_group.allow_http_anywhere.id
  description = "The ID of Security Group allow HTTP anywhere"
}

output sg_ssh_id {
  value       = aws_security_group.allow_ssh_anywhere.id
  description = "The ID of Security Group allow SSH anywhere"
}


