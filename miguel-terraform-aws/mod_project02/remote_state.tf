terraform {
    backend "s3" {
        bucket="vcc-terraform-bucket-20210104"
        key="terraform/project02.tfstate"
        region="us-east-2"
    }
}

data "terraform_remote_state" "project01" {
  backend = "s3"

  config = {
    bucket = "vcc-terraform-bucket-20210104"
    key = "terraform/project01.tfstate"
    region = "us-east-2"
  }
}