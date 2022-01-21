provider "aws" {
    region = "us-east-2"
}

module sg {
    source = "D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj002-aws-quick-sg/modules/sg"
    project_name = "SG-Quick-P001"
    environment = "testing"
}