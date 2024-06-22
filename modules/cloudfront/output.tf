output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website_distribution.id
}

output "cloudfront_distribution_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.website_distribution.domain_name
}

output "origin_access_identity_id" {
  description = "The ID of the CloudFront Origin Access Identity"
  value       = aws_cloudfront_origin_access_identity.OAI.id
}

output "origin_access_identity_iam_arn" {
  description = "The IAM ARN of the CloudFront Origin Access Identity"
  value       = aws_cloudfront_origin_access_identity.OAI.iam_arn
}
