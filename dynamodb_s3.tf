resource "aws_dynamodb_table" "vacunas" {
  name           = var.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  hash_key       = "Vacuna_ID"

  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity

  attribute {
    name = "Vacuna_ID"
    type = "S"
  }

  tags = {
    Name        = "VacunasTable"
    Environment = "Dev"
  }
}

