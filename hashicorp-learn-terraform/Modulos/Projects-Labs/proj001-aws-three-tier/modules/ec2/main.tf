#####################
# EC2
#####################
resource "aws_instance" "bastion" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = var.keypair_name
    subnet_id = var.subnet_public_id

    vpc_security_group_ids = [ 
        var.sg_public_ssh_id,
        var.sg_public_http_id
    ]

    user_data = data.template_file.init.rendered

    tags = {
        Name = "${var.project_name}-${var.environment}-ec2-bastion"
    }
}