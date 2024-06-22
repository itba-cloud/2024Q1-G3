# variables.tf

variable "api_name" {
  description = "The name of the API Gateway"
}

variable "resource_path" {
  description = "The path part of the API resource"
}

variable "get_lambda_function_name" {
  description = "The name of the GET Lambda function"
}

variable "post_lambda_function_name" {
  description = "The name of the POST Lambda function"
}

variable "get_lambda_invoke_arn" {
  description = "The invoke ARN of the GET Lambda function"
}

variable "post_lambda_invoke_arn" {
  description = "The invoke ARN of the POST Lambda function"
}
