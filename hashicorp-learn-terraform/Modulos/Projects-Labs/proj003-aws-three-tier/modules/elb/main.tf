#####################
# ELB
#####################
resource "aws_elb" "frontend" {
    name    = "${var.project_name}-elb-frontend"
    subnets = var.subnets_public_ids

    security_groups = [
        var.sg_public_http_id
    ]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 2
        target              = "HTTP:80/"
        interval            = 5
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-frontend-elb"
    }
}

resource "aws_elb" "backend" {
    name     = "${var.project_name}-elb-backend"
    subnets  = var.subnets_private_ids
    internal = true

    security_groups = [
        var.sg_private_http_id
    ]

    listener {
        instance_port     = 80
        instance_protocol = "http"
        lb_port           = 80
        lb_protocol       = "http"
    }

    health_check {
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 2
        target              = "HTTP:80/"
        interval            = 5
    }

    tags = {
        Name = "${var.project_name}-${var.environment}-private-elb"
    }
}

