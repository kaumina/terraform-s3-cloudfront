# create new Origin Access Identity
resource "aws_cloudfront_origin_access_identity" "oa_identity" {
  comment = "Amazon CloudFront origin access identity"
}

# create template file to grab s3 bucket policy
data "template_file" "policy" {
  template = "${file("${path.module}/policy.json.tpl")}"

  vars = {
    s3_bucket = var.bucket_name
    oa_identity = aws_cloudfront_origin_access_identity.oa_identity.iam_arn
  }
}

# create s3 bucket policy
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = var.bucket_name
  policy = "${data.template_file.policy.rendered}"
}

######## Create CloudFront Disctribution #############

# get the bucket_regional_domain_name from S3 bucket module
locals {
  s3_origin_id = var.bucket_regional_domain_name
}

# create CF distribution
resource "aws_cloudfront_distribution" "cf_distribution" {

  # define S3 origin  
  origin {
    domain_name = local.s3_origin_id
    origin_id   = local.s3_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oa_identity.cloudfront_access_identity_path
    }
  } 
  default_root_object = "index.html"
  #aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "https-only"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }





  enabled             = true
  price_class = "PriceClass_100"
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
    viewer_certificate {
    cloudfront_default_certificate = true
    
  }
  
  tags = var.tags
}