resource "aws_s3_bucket" "vacunatorio_s3" {
  bucket = var.s3_bucket_name

  tags = {
    Name = "StaticWebsiteBucket"
  }
}

resource "aws_s3_bucket_website_configuration" "website_bucket_config" {
  bucket = aws_s3_bucket.vacunatorio_s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.vacunatorio_s3.bucket
  key    = "index.html"
  source = "modules/frontend/index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "scripts_js" {
  bucket = aws_s3_bucket.vacunatorio_s3.bucket
  key    = "generated_script.js"
  source = "scripts/generated_script.js"
  content_type = "application/javascript"
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.vacunatorio_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = var.cloudfront_iam_arn
        }
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.vacunatorio_s3.arn}/*"
      }
    ]
  })
}