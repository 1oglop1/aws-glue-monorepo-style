variable "region" {
  type        = string
  description = "AWS region name"
  default     = "us-east-1"
}
variable "tags" {
  type        = map(string)
  description = "AWS resource tags"
  default     = {}
}

variable "glue_bucket_name" {
  type        = string
  description = "S3 bucket name where glue jobs are stored"
}
