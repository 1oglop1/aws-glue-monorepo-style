resource "aws_s3_bucket" "s3" {
  bucket = var.bucket_name
  force_destroy = true
  lifecycle {
    prevent_destroy = false
  }
  versioning {
    enabled = var.versioning_enabled
  }
  tags = var.tags


  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}