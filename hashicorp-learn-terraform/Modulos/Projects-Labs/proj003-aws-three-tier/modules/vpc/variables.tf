variable project_name {
  type        = string
  default     = ""
  description = "Name general for Module"
}


variable cidr {
  type        = string
  default     = "0.0.0.0/0"
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}

variable instance_tenancy {
  type        = string
  default     = "default"
  description = "A tenancy option for instances launched into the VPC"
}

variable "vpc_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags for the VPC"
}

variable "vpc_subnets_public" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = []
}

variable "vpc_subnets_private" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = []
}

variable azs {
  type        = list(string)
  default     = []
  description = "A list of all zones"
}

variable azs_ids {
  type        = list(string)
  default     = []
  description = "A list of all IDs zones"
}

variable environment {
  type = string
  description = "Indicate to be will the environment of the module"
}

variable public_inbound_acl_rules {
  type        = list(map(string))
  description = "Rule for subnet server to public port 80 inbound"
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 110
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
    {
      rule_number = 120
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable public_outbound_acl_rules {
  type        = list(map(string))
  description = "Rule for subnet public outbound"
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}

variable private_inbound_acl_rules {
  type        = list(map(string))
  description = "Rule for subnet server to private inbound"
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_block  = "10.0.0.0/16"
    },
    {
      rule_number = 110
      rule_action = "allow"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_block  = "10.0.0.0/16"
    },
    {
      rule_number = 120
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = "10.0.0.0/16"
    },
  ]
}

variable private_outbound_acl_rules {
  type        = list(map(string))
  description = "Rule for subnet private outbound"
  default = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    },
  ]
}
