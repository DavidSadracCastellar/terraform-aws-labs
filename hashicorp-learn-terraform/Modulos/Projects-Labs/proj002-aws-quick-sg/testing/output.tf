output sg_ssh_id {
  value       = module.sg.sg_ssh_id
  description = "ID of security group ssh"
}

output sg_http_id {
  value       = module.sg.sg_http_id
  description = "ID of security group http"
}
