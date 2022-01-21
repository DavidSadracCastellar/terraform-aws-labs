data "aws_ami" "ubuntu" {
  most_recent      = true
  owners           = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "template_file" "init" {
    template = file("D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj003-aws-three-tier/modules/asg/user-data.txt")

    vars = {
        project_name = var.project_name
    }
}