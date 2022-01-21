
module alb {
    source = "D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj003-aws-three-tier/modules/alb"
    project_name = "ALB-p003-threetier"
    vpc_id = module.vpc.vpc_id
    environment = "testing"
    subnets_public_ids = [ module.vpc.subnet_public_one_id, module.vpc.subnet_public_two_id ]
    subnets_private_ids = [ module.vpc.subnet_private_one_id, module.vpc.subnet_private_two_id ]
    sg_private_http_id = module.vpc.sg_private_http_id
    sg_public_http_id = module.vpc.sg_public_http_id
}
