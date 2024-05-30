resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "PrivateSubnet1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "PrivateSubnet2"
  }
}
