module "ec2" {
  source = "github.com/videocursoscloud/terraform-module-ec2-with-eip"
  vpc_id = "vpc-b3e006d8"
  project_name = "Modulo-EC2"
  environment = "Testing"
  ami = "ami-0ebc8f6f580a04647"
  instance_type = "t2.micro"
  key_name = "DavidAws"
}
