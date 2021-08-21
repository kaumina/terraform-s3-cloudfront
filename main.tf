provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Initialize and call the module S3
module "static-s3" {
  source      = "./s3"
  bucket_name = var.bucket_name
  tags        = var.tags

}

# Initialize and call the module CloudFront
module "cloudfront" {
  source                      = "./cloudfront"
  bucket_arn                  = module.static-s3.bucket_arn
  bucket_name                 = module.static-s3.bucket_name
  bucket_regional_domain_name = module.static-s3.bucket_regional_domain_name
  tags                        = var.tags

}

