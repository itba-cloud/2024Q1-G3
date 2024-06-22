module "dynamodb_table" {
  source   = "terraform-aws-modules/dynamodb-table/aws"

  name     = "Tabla_Vacunas"
  hash_key = "Vacuna_ID"

  attributes = [
    {
      name = "Vacuna_ID"
      type = "S"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "Dev"
  }
}  