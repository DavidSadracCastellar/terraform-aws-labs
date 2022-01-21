module "ec2" {
  source = "D:/Practices/Terraform/miguel-terraform-aws/modulos_dev/ec2-with-eip"
  sg_name  = "ec2-produccion"
  vpc_id = "vpc-b3e006d8"
  project_name = "Modulo-EC2"
  environment = "Production"
  ami = "ami-0dd9f0e7df0f0a138"
  instance_type = "t2.micro"
  key_name = "DavidAws"
}
