resource "aws_s3_bucket" "main" {
  bucket        = format("%s-%s-%s", var.bucket_name_prefix, data.aws_caller_identity.current.account_id, data.aws_region.current.name)
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}
