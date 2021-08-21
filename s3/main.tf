# create S3 bucket with static web enabled

resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name
  acl    = "private"
  versioning {
    enabled = false
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  tags = var.tags
  
}
