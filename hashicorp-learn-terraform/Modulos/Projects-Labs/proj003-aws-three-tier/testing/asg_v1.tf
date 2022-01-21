module "asg" {
    source = "D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj003-aws-three-tier/modules/asg"
    project_name = "ASG-p003-threetier"
    vpc_id = module.vpc.vpc_id
    environment = "testing"
    subnets_public_ids = [ module.vpc.subnet_public_one_id, module.vpc.subnet_public_two_id ]
    subnets_private_ids = [ module.vpc.subnet_private_one_id, module.vpc.subnet_private_two_id ]
    sg_private_ssh_id = module.vpc.sg_private_ssh_id
    sg_private_http_id = module.vpc.sg_private_http_id
    sg_public_http_id = module.vpc.sg_public_http_id
    elb_frontend_name = ""
    elb_backend_name = ""
    alb_tg_frontend_arn = module.alb.alb_tg_frontend_arn
    alb_tg_backend_arn = module.alb.alb_tg_backend_arn
    instance_type = "t2.micro"

}
