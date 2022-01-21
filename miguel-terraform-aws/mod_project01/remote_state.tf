terraform {
    backend "s3" {
        bucket="vcc-terraform-bucket-20210104"
        key="terraform/project01.tfstate"
        region="us-east-2"
    }
}