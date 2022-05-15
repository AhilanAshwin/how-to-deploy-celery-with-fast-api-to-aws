resource "aws_s3_bucket" "bucket" {
  bucket = "${local.prefix}-s3"
  tags   = local.common_tags
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "aws.env"
  source = "../aws.env"
  etag   = filemd5("../aws.env")
}
