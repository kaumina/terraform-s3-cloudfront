{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudFrontAccess",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${oa_identity}"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${s3_bucket}/*"
        }
    ]
}