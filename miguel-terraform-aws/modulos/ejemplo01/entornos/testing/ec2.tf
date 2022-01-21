module "ec2" {
  source = "D:/Practices/Terraform/miguel-terraform-aws/modulos_dev/ec2-with-eip"
  sg_name  = "ec2-testing"
  vpc_id = "vpc-b3e006d8"
  project_name = "Modulo-EC2"
  environment = "Testing"
  ami = "ami-0ebc8f6f580a04647"
  instance_type = "t2.micro"
  key_name = "DavidAws"
}
