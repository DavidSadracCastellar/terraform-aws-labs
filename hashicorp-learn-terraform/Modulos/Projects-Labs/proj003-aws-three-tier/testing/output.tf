output vpc_id {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output sg_public_http_id {
  value       = module.vpc.sg_public_http_id
  description = "The ID of Security Group public allow HTTP anywhere"
}

output sg_public_ssh_id {
  value       = module.vpc.sg_public_ssh_id
  description = "The ID of Security Group public allow SSH anywhere"
}

output sg_private_http_id {
  value       = module.vpc.sg_private_http_id
  description = "The ID of Security Group private allow HTTP anywhere"
}

output sg_private_ssh_id {
  value       = module.vpc.sg_private_ssh_id
  description = "The ID of Security Group private allow SSH anywhere"
}

output subnet_public_one_id {
  value       = module.vpc.subnet_public_one_id
  description = "The ID of Subnet Public one"
}

output subnet_public_two_id {
  value       = module.vpc.subnet_public_two_id
  description = "The ID of Subnet Public two"
}

output subnet_private_one_ids {
  value       = module.vpc.subnet_private_one_id
  description = "The ID of Subnet Private one"
}

output subnet_private_two_ids {
  value       = module.vpc.subnet_private_one_id
  description = "The ID of Subnet Private two"
}
/*
output ec2_id {
  value       = "module.ec2.ec2_id"
  description = "The ec2 ID captured from module ec2 "
}*/

output alb_frontend_id {
  value       = module.alb.alb_frontend_id
  description = "Id of Application Loan Balance frontend"
}
