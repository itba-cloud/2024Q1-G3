variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "cloudfront_iam_arn" {
  description = "The IAM ARN for CloudFront access"
  type        = string
}
