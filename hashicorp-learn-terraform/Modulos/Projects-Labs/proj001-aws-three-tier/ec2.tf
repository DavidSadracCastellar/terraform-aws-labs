resource "aws_key_pair" "keypair" {
    key_name   = "p001-testing-keypair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEArLhLnVhH3sdzmLPLFO7Nhh6c3ySi6ayWihDfWFFz0vJcE+geSE3uj5tNV0yNI7JfiR0wb5MT5+UHLfLxy2fFiIZOymPy3EXZKDtoEk0gdWXEgUgYRwCcr1OsWTMsMWwRCAOA4gOUldPCGCtw79+Cb9hNC1UMTNsaiVIshNLRmkBytpnrU5LmjeQwH5fKPHBC6sszUjCg/33GdOSurpnE3/PGuVZw+gtq9SJWWnRh6HPSahLezk5yBdxXjY22jBnmV75uENZzKEPCWuN3wiF0KCx0ToBQiQMzran3g/vADgHUnFgXrku34WMvLTlFvV2DT5+sD8MMSzGup9QFp4C6Yw== rsa-key-20210102"
}

module ec2 {
    source = "D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj001-aws-three-tier/modules/ec2"
    project_name = "EC2-p001-threetier"
    environment = "testing"
    instance_type = "t2.micro"
    keypair_name = aws_key_pair.keypair.key_name
    subnet_public_id = module.vpc.subnet_public_id
    sg_public_ssh_id = module.vpc.sg_public_ssh_id
    sg_public_http_id = module.vpc.sg_public_http_id
}
