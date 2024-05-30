variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "The CIDR block for the first private subnet"
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "The CIDR block for the second private subnet"
  default     = "10.0.2.0/24"
}

variable "availability_zone_1" {
  description = "The availability zone for the first private subnet"
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "The availability zone for the second private subnet"
  default     = "us-east-1b"
}



variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  default     = "Tabla_Vacunas"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  default     = "s3-vacunatorio-terraform"
}

variable "lambda_post_filename" {
  description = "The filename of the zip file for the POST Lambda function"
  default     = "lambda_post.zip"
}

variable "lambda_get_filename" {
  description = "The filename of the zip file for the GET Lambda function"
  default     = "lambda_get.zip"
}

variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda functions"
  default     = "LabRole"
}

variable "read_capacity" {
  description = "Read capacity units for the DynamoDB table"
  default     = 5
}

variable "write_capacity" {
  description = "Write capacity units for the DynamoDB table"
  default     = 5
}

variable "api_name" {
  description = "The name of the API Gateway"
  default     = "VacunasAPI"
}
