module "vpc" {
  source  = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
}

output "default_route_table_id" {
  value = module.vpc.default_route_table_id
}


module "subnets" {
  source               = "./modules/subnets"
  vpc_id               = module.vpc.vpc_id
  subnet_1_cidr        = var.subnet_1_cidr
  subnet_2_cidr        = var.subnet_2_cidr
  availability_zone_1  = var.availability_zone_1
  availability_zone_2  = var.availability_zone_2
  subnet_1_name        = var.subnet_1_name
  subnet_2_name        = var.subnet_2_name
}

module "lambda_get" {
  source             = "./modules/lambda"
  source_dir         = "${path.module}/python"
  lambda_filename    = var.lambda_get_filename
  function_name      = "GetVacunaFunction"
  role_arn           = data.aws_iam_role.role.arn
  handler            = "lambda_get.lambda_handler"
  runtime            = "python3.12"
  timeout            = 10
  subnet_ids         = [module.subnets.subnet_1_id, module.subnets.subnet_2_id]
  security_group_ids = [data.aws_security_group.default.id]
  table_name         = var.dynamodb_table_name
  tags               = {
    Name = "GetVacunaFunction"
  }
}

module "lambda_post" {
  source             = "./modules/lambda"
  source_dir         = "${path.module}/python"
  lambda_filename    = var.lambda_post_filename
  function_name      = "PostVacunaFunction"
  role_arn           = data.aws_iam_role.role.arn
  handler            = "lambda_post.lambda_handler"
  runtime            = "python3.12"
  timeout            = 10
  subnet_ids         = [module.subnets.subnet_1_id, module.subnets.subnet_2_id]
  security_group_ids = [data.aws_security_group.default.id]
  table_name         = var.dynamodb_table_name
  tags               = {
    Name = "PostVacunaFunction"
  }
}

module "api_gateway" {
  source                  = "./modules/api_gateway"
  api_name                = "VacunasAPI"
  resource_path           = "vacunas"
  get_lambda_function_name = module.lambda_get.lambda_function_name
  post_lambda_function_name = module.lambda_post.lambda_function_name
  get_lambda_invoke_arn    = module.lambda_get.lambda_invoke_arn
  post_lambda_invoke_arn   = module.lambda_post.lambda_invoke_arn
}

output "invoke_url_with_vacunas" {
  value = format("%s/vacunas", module.api_gateway.api_url)
}

data "local_file" "script_template" {
  filename = "modules/frontend/script_template"
}

resource "local_file" "generated_script" {
  content  = templatefile(data.local_file.script_template.filename, { invoke_url = module.api_gateway.api_url })
  filename = "${path.module}/scripts/generated_script.js"
}

module "vacunatorio_s3" {
  source = "./modules/s3"

  s3_bucket_name     = var.s3_bucket_name
  cloudfront_iam_arn = module.vacunatorio_cloudfront.origin_access_identity_iam_arn
}

module "vacunatorio_cloudfront" {
  source = "./modules/cloudfront"

  s3_bucket_domain_name = module.vacunatorio_s3.s3_bucket_domain_name
  s3_bucket_id          = module.vacunatorio_s3.s3_bucket_id
}
