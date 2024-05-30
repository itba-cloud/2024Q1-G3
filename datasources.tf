data "aws_vpc" "selected" {
  default = true
}

data "aws_security_group" "default" {
  vpc_id = aws_vpc.main_vpc.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

data "aws_iam_role" "role" {
    name = "LabRole"
}