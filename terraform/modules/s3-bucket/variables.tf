########################################################
##               Module variables
########################################################

variable "bucket_name" {
  type        = string
  description = "The name of the bucket"
}

variable "tags" {
  type        = map
  description = "Tags associated with the bucket"
}

variable "versioning_enabled" {
  type        = string
  description = "Enable versioning"
}
