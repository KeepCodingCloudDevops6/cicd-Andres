resource "aws_s3_bucket" "acme-storage-andres" {
  bucket = "acme-storage-andres"
}

resource "aws_s3_bucket_acl" "bucket-acl-andres" {
  bucket = "acme-storage-andres"
  acl    = "private"
}
