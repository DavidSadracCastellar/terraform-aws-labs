output elb_frontend_name {
    value       = aws_elb.frontend.name
    description = "Capture elb NAME for Frontend"
}

output elb_backend_name {
    value       = aws_elb.backend.name
    description = "Capture elb NAME for backend"
}
