variable project_name {
    type        = string
    description = "Name general of the module"
}

variable environment {
    type        = string
    description = "Indentify to be will the environment of the module"
}

variable vpc_id {
    type        = string
    description = "Initialize the ID from module vpc"
}

variable subnets_public_ids {
    type        = list(string)
    default     = []
    description = "Initialize the subnet public IDs from module vpc"
}

variable subnets_private_ids {
    type    = list(string)
    default = []
    description = "Initialize the subnet private IDs from module vpc"
}

variable sg_private_http_id {
    type = string
    description = "Initialize the security group http ID private from module vpc"
}

variable sg_public_http_id {
    type = string
    description = "Initialize the security group http ID public from module vpc"
}