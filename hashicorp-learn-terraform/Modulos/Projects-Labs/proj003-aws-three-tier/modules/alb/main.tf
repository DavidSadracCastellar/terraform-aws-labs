#####################
# ALB
#####################
resource "aws_lb" "frontend" {
    name               = "${var.project_name}-frontend"
    internal           = false
    load_balancer_type = "application"
    security_groups    = [ var.sg_public_http_id ]
    subnets            = var.subnets_public_ids

    tags = {
        Name = "${var.project_name}-${var.environment}-frontend-alb"
    }
}

resource "aws_lb" "backend" {
    name               = "${var.project_name}-backend"
    internal           = true
    load_balancer_type = "application"
    security_groups    = [ var.sg_private_http_id ]
    subnets            = var.subnets_private_ids

    tags = {
        Name = "${var.project_name}-${var.environment}-backend-alb"
    }
}

######################
# Target Group
######################
resource "aws_lb_target_group" "frontend" {
    name     = "${var.project_name}-front-TG"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

resource "aws_lb_target_group" "backend" {
    name     = "${var.project_name}-back-TG"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

#####################
# Listen LB
#####################
resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.frontend.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.frontend.arn
    }
}

resource "aws_lb_listener" "back_end" {
    load_balancer_arn = aws_lb.backend.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.backend.arn
    }
}