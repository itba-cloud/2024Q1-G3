resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    ignore_changes = [tags]
  }
}

data "aws_route_tables" "default" {
  vpc_id = aws_vpc.main_vpc.id
  filter {
    name = "association.main"
    values = ["true"]
  }
}
