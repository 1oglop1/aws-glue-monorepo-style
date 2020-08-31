##################### S3 Buckets #######################
module "s3_bucket_all" {
  source             = "../modules/s3-bucket"
  bucket_name        = "your-awsglue-bucket"
  versioning_enabled = false
  tags               = var.tags

}


resource "aws_s3_bucket_object" "ds1_raw_folder" {
  key                    = "/ds1/raw/"
  bucket                 = module.s3_bucket_all.id
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "ds1_refined_folder" {
  key                    = "/ds1/refined/yes"
  bucket                 = module.s3_bucket_all.id
  server_side_encryption = "AES256"
}

resource "aws_s3_bucket_object" "code_folder" {
  key                    = "/code/"
  bucket                 = module.s3_bucket_all.id
  server_side_encryption = "AES256"
}
