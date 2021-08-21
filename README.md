# Terraform module to create S3 bucket and CloudFront to host static website
## Background
This module hosts S3 bucket with required permissions to accessible only from CloudFront.
## Steps
create terraform.tfvars and fill values as below. Make sure to update aws access key and secret.
```
bucket_name = "codetest.example.com"
tags = {
  environment = "TST"
  name        = "test-static-site"
}
access_key = "XXXXXX"
secret_key = "XXXXXXXXX"

```
