data "archive_file" "zip_lambda_code" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/${var.lambda_filename}"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "${path.module}/${var.lambda_filename}"
  function_name    = var.function_name
  role             = var.role_arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

  environment {
    variables = {
      TABLE_NAME = var.table_name
    }
  }

  tags = var.tags
}




