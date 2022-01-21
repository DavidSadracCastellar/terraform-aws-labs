data "template_file" "init" {
    template = file("D:/Practices/Terraform/hashicorp-learn-terraform/Modulos/Projects-Labs/proj003-aws-three-tier/modules/asg/user-data.txt")

    vars = {
        project_name = var.project_name
    }
}