variable "source_dir" {
  description = "The directory containing the Lambda function source code"
}

variable "lambda_filename" {
  description = "The filename of the zip file for the Lambda function"
}

variable "function_name" {
  description = "The name of the Lambda function"
}

variable "role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
}

variable "handler" {
  description = "The handler for the Lambda function"
}

variable "runtime" {
  description = "The runtime for the Lambda function"
  default     = "python3.12"
}

variable "timeout" {
  description = "The timeout for the Lambda function"
  default     = 10
}

variable "subnet_ids" {
  description = "The IDs of the subnets for the Lambda function"
  type        = list(string)
}

variable "security_group_ids" {
  description = "The IDs of the security groups for the Lambda function"
  type        = list(string)
}

variable "table_name" {
  description = "The name of the DynamoDB table"
}

variable "tags" {
  description = "The tags for the Lambda function"
  type        = map(string)
}
