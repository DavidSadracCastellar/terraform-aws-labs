output "template_rendered" {
    value = data.template_file.init.rendered
}

output keypair_name {
    value       = aws_key_pair.keypair.key_name
    description = "Key pair name"
}

output asg_frontend_id {
    value = aws_autoscaling_group.frontend.id
    description = "Frontend outoscaling group ID"
}

output asg_backend_id {
    value = aws_autoscaling_group.backend.id
    description = "Frontend outoscaling group ID"
}