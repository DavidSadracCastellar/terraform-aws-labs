/*
module elb {
    source = "D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj003-aws-three-tier/modules/elb"
    project_name = "elb-p003-threetier"
    environment = "testing"
    azs = ["us-east-2a", "us-east-2b", "us-east-2c"]
    subnets_public_ids = [ module.vpc.subnet_public_one_id, module.vpc.subnet_public_two_id ]
    subnets_private_ids = [ module.vpc.subnet_private_one_id, module.vpc.subnet_private_two_id ]
    sg_private_http_id = module.vpc.sg_private_http_id
    sg_public_http_id = module.vpc.sg_public_http_id
}
*/