resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MainVPC"
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    ignore_changes = [tags]
  }
}
