output alb_frontend_id {
    value       = aws_lb.frontend.id
    description = "Capture alb ID for Frontend"
}

output alb_backend_id {
    value       = aws_lb.backend.id
    description = "Capture alb ID for backend"
}

output alb_tg_frontend_arn {
    value       = aws_lb_target_group.frontend.arn
    description = "Capture LB Target Group ARN Frontend"
}

output alb_tg_backend_arn {
    value       = aws_lb_target_group.backend.arn
    description = "Capture LB Target Group ARN Backend"
}
