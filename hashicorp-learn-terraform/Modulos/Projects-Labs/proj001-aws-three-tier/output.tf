output vpc_id {
    value       = module.vpc.vpc_id
    description = "The ID of the VPC"
}

output subnet_public_id {
    value       = module.vpc.subnet_public_id
    description = "The ID of Subnet Public"
}

output subnet_private_id {
    value       = module.vpc.subnet_private_id
    description = "The ID of Subnet Private"
}

output subnet_protected_id {
    value       = module.vpc.subnet_protected_id
    description = "The ID of Subnet Protected"
}

output sg_public_http_id {
    value       = module.vpc.sg_public_http_id
    description = "The ID of Security Group allow HTTP anywhere"
}

output sg_public_ssh_id {
    value       = module.vpc.sg_public_ssh_id
    description = "The ID of Security Group allow SSH anywhere"
}
