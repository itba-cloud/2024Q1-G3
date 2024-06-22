
output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "default_route_table_id" {
  value = data.aws_route_tables.default.ids[0]
}