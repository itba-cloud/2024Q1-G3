resource "aws_api_gateway_rest_api" "vacunas_api" {
  name        = var.api_name
  description = "API Gateway for Vacunas service"
  endpoint_configuration {
    types = ["EDGE"]
  }
}

resource "aws_api_gateway_resource" "vacunas" {
  rest_api_id = aws_api_gateway_rest_api.vacunas_api.id
  parent_id   = aws_api_gateway_rest_api.vacunas_api.root_resource_id
  path_part   = "vacunas"
}

resource "aws_api_gateway_method" "get_vacunas" {
  rest_api_id   = aws_api_gateway_rest_api.vacunas_api.id
  resource_id   = aws_api_gateway_resource.vacunas.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "get_vacunas_response" {
  rest_api_id = aws_api_gateway_rest_api.vacunas_api.id
  resource_id = aws_api_gateway_resource.vacunas.id
  http_method = aws_api_gateway_method.get_vacunas.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_method" "post_vacunas" {
  rest_api_id   = aws_api_gateway_rest_api.vacunas_api.id
  resource_id   = aws_api_gateway_resource.vacunas.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "post_vacunas_response" {
  rest_api_id = aws_api_gateway_rest_api.vacunas_api.id
  resource_id = aws_api_gateway_resource.vacunas.id
  http_method = aws_api_gateway_method.post_vacunas.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }
}

resource "aws_api_gateway_integration" "get_vacunas" {
  rest_api_id             = aws_api_gateway_rest_api.vacunas_api.id
  resource_id             = aws_api_gateway_resource.vacunas.id
  http_method             = aws_api_gateway_method.get_vacunas.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.get_lambda.invoke_arn

  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }

  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_integration_response" "get_vacunas_integration_response" {
  depends_on = [aws_api_gateway_integration.get_vacunas]

  rest_api_id = aws_api_gateway_rest_api.vacunas_api.id
  resource_id = aws_api_gateway_resource.vacunas.id
  http_method = aws_api_gateway_method.get_vacunas.http_method
  status_code = "200"

  response_templates = {
    "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "statusCode": 200,
  "body": $inputRoot
}
EOF
  }
}

resource "aws_api_gateway_integration" "post_vacunas" {
  rest_api_id             = aws_api_gateway_rest_api.vacunas_api.id
  resource_id             = aws_api_gateway_resource.vacunas.id
  http_method             = aws_api_gateway_method.post_vacunas.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = aws_lambda_function.post_lambda.invoke_arn

  request_templates = {
    "application/json" = <<EOF
{
  "statusCode": 200
}
EOF
  }

  passthrough_behavior = "WHEN_NO_MATCH"
}

resource "aws_api_gateway_integration_response" "post_vacunas_integration_response" {
  depends_on = [aws_api_gateway_integration.post_vacunas]

  rest_api_id = aws_api_gateway_rest_api.vacunas_api.id
  resource_id = aws_api_gateway_resource.vacunas.id
  http_method = aws_api_gateway_method.post_vacunas.http_method
  status_code = "200"

  response_templates = {
    "application/json" = <<EOF
#set($inputRoot = $input.path('$'))
{
  "statusCode": 200,
  "body": $inputRoot
}
EOF
  }
}

resource "aws_api_gateway_deployment" "vacunas_api_deployment" {
  depends_on = [
    aws_api_gateway_integration.get_vacunas,
    aws_api_gateway_integration.post_vacunas,
    aws_api_gateway_method_response.get_vacunas_response,
    aws_api_gateway_method_response.post_vacunas_response,
    aws_api_gateway_integration_response.get_vacunas_integration_response,
    aws_api_gateway_integration_response.post_vacunas_integration_response
  ]
  rest_api_id = aws_api_gateway_rest_api.vacunas_api.id
  stage_name  = "prod"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.post_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.vacunas_api.execution_arn}/*/*"
}

resource "aws_lambda_permission" "api_gateway_get" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.vacunas_api.execution_arn}/*/*"
}
