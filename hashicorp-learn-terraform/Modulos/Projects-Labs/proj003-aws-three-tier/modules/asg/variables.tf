variable project_name {
    type        = string
    description = "Name general of the module"
}

variable instance_type {
    type        = string
    description = "Type of instance for the imagen for ec2"
}

variable environment {
    type        = string
    description = "Indentify to be will the environment of the module"
}

variable vpc_id {
    type        = string
    description = "Initialize the ID of vpc"
}

variable subnets_private_ids {
    type        = list(string)
    default     = []
    description = "Initialize the subnet private IDs of the vpc"
}

variable subnets_public_ids {
    type        = list(string)
    default     = []
    description = "Initialice subnet public ID from module VPC"
}

variable sg_private_ssh_id {
    type        = string
    description = "Initialize security group ssh ID"
}

variable sg_private_http_id {
    type        = string
    description = "Initialize security group http ID"
}

variable sg_public_http_id {
    type        = string
    description = "Initialize security group public http ID"
}

variable alb_tg_frontend_arn {
    type        = string
    description = "Initialize  Target Group ARN frontend of module ALB"
}

variable alb_tg_backend_arn {
    type        = string
    description = "Initialize  Target Group ARN backend of module ALB"
}

variable elb_frontend_name {
    type        = string
    description = "Initialize elb NAME frontend from module ELB"
}

variable elb_backend_name {
    type        = string
    description = "Initialize elb NAME backend from module ELB"
}
