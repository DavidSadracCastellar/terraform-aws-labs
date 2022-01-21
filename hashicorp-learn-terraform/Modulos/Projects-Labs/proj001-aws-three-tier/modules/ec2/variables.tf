variable project_name {
    type        = string
    description = "Name general of the module"
}

variable environment {
    type        = string
    description = "Indentify to be will the environment of the module"
}

variable instance_type {
    type        = string
    default     = "t2.micro"
    description = "Instace type for ec2 bastion"
}

variable keypair_name {
    type        = string
    description = "Key pair name from ASG module"
}

variable subnet_public_id {
    type        = string
    description = "Initialize the subnet public IDs from vpc module"
}

variable sg_public_ssh_id {
    type = string
    description = "Initialize the security group ssh ID public from vpc module"
}

variable sg_public_http_id {
    type = string
    description = "Initialize the security group http ID public from vpc module"
}
