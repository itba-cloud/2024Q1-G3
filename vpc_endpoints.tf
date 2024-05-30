variable "vpc_endpoints" {
  description = "List of VPC endpoints to create"
  type        = list(string)
  default     = ["dynamodb", "s3"]
}

resource "aws_vpc_endpoint" "gateway_endpoints" {
  count             = length(var.vpc_endpoints)
  vpc_id            = aws_vpc.main_vpc.id
  service_name      = "com.amazonaws.${var.aws_region}.${element(var.vpc_endpoints, count.index)}"
  vpc_endpoint_type = "Gateway"

  route_table_ids = [aws_vpc.main_vpc.main_route_table_id]

  tags = {
    Name = "${element(var.vpc_endpoints, count.index)}Endpoint"
  }
}
