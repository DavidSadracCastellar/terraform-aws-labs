provider "aws" {
    region = "us-east-2"
}

module "vpc" {
    source = "D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj001-aws-three-tier/modules/vpc"
    project_name = "Modulo-VPC-p001"
    cidr = "10.0.0.0/16"
    vpc_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    azs = ["us-east-2a", "us-east-2b", "us-east-2c"]
    azs_ids = ["use2-az1", "use2-az2", "use2-az3"]
    vpc_tags = {
        Environment = "testing"
    }
}