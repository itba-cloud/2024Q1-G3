provider "aws" {
  region = var.aws_region
}

data "aws_security_group" "default" {
  vpc_id = module.vpc.vpc_id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_iam_role" "role" {
    name = "LabRole"
}
