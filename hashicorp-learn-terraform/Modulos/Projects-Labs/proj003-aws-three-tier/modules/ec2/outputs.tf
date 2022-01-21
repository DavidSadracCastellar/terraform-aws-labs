output "template_rendered" {
    value = data.template_file.init.rendered
}

output ec2_id {
    value       = aws_instance.bastion.id
    description = "Instance EC2 ID"
}
