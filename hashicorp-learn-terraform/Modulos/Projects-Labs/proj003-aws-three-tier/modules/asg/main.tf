#####################
# Keypair
#####################
resource "aws_key_pair" "keypair" {
    key_name   = "${var.project_name}-keypair"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEArLhLnVhH3sdzmLPLFO7Nhh6c3ySi6ayWihDfWFFz0vJcE+geSE3uj5tNV0yNI7JfiR0wb5MT5+UHLfLxy2fFiIZOymPy3EXZKDtoEk0gdWXEgUgYRwCcr1OsWTMsMWwRCAOA4gOUldPCGCtw79+Cb9hNC1UMTNsaiVIshNLRmkBytpnrU5LmjeQwH5fKPHBC6sszUjCg/33GdOSurpnE3/PGuVZw+gtq9SJWWnRh6HPSahLezk5yBdxXjY22jBnmV75uENZzKEPCWuN3wiF0KCx0ToBQiQMzran3g/vADgHUnFgXrku34WMvLTlFvV2DT5+sD8MMSzGup9QFp4C6Yw== rsa-key-20210102"
}

##############################
# Launch Configuration
##############################
resource "aws_launch_configuration" "frontend" {
    name_prefix   = "${var.project_name}-lc-frontend-"
    image_id      = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.keypair.key_name
    security_groups = [
        var.sg_private_ssh_id,
        var.sg_private_http_id
    ]

    user_data = data.template_file.init.rendered

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_launch_configuration" "backend" {
    name_prefix   = "${var.project_name}-lc-backend-"
    image_id      = data.aws_ami.ubuntu.id
    instance_type = var.instance_type
    key_name = aws_key_pair.keypair.key_name
    security_groups = [
        var.sg_private_ssh_id,
        var.sg_private_http_id
    ]

    user_data = data.template_file.init.rendered

    lifecycle {
        create_before_destroy = true
    }
}

#############################
# Auto Scaling Group
#############################
resource "aws_autoscaling_group" "frontend" {
    name                      = "${var.project_name}-frontend"
    max_size                  = 3
    min_size                  = 0
    desired_capacity          = 2

    health_check_type = "EC2"
    health_check_grace_period = 150

    
    target_group_arns = [
        var.alb_tg_frontend_arn
    ]
    
    /*
    load_balancers = [
        var.elb_frontend_name
    ]
    */
    launch_configuration      = aws_launch_configuration.frontend.name
    vpc_zone_identifier       = var.subnets_private_ids

    tag {
        key                 = "Name"
        value               = "${var.project_name}-${var.environment}-frontend-asg"
        propagate_at_launch = true
    }

}

resource "aws_autoscaling_group" "backend" {
    name                      = "${var.project_name}-backend"
    max_size                  = 3
    min_size                  = 0
    desired_capacity          = 0

    health_check_type = "EC2"
    health_check_grace_period = 150

    
    target_group_arns = [
        var.alb_tg_backend_arn
    ]
    
    /*
    load_balancers = [
        var.elb_backend_name
    ]
    */
    launch_configuration      = aws_launch_configuration.backend.name
    vpc_zone_identifier       = var.subnets_private_ids

    tag {
        key                 = "Name"
        value               = "${var.project_name}-${var.environment}-backend-asg"
        propagate_at_launch = true
    }

}

resource "aws_autoscaling_policy" "frontend" {
    name                   = "${var.project_name}-frontend-policy-asg"
    adjustment_type        = "PercentChangeInCapacity"
    autoscaling_group_name = aws_autoscaling_group.frontend.name

    policy_type = "TargetTrackingScaling"
    estimated_instance_warmup = 15

    target_tracking_configuration {
        predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        }

        target_value = 40.0
    }

}

resource "aws_autoscaling_policy" "backend" {
    name                   = "${var.project_name}-backend-policy-asg"
    adjustment_type        = "PercentChangeInCapacity"
    autoscaling_group_name = aws_autoscaling_group.backend.name

    policy_type = "TargetTrackingScaling"
    estimated_instance_warmup = 15

    target_tracking_configuration {
        predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
        }

        target_value = 40.0
    }

}