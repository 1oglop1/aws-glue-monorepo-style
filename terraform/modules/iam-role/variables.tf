########################################################
##               Module variables
########################################################

variable "iam_role_name" {
  type        = string
  description = "The name of the role. If omitted, Terraform will assign a random, unique name."
}

variable "assume_role_policy" {
  type        = string
  description = "The policy that grants an entity permission to assume the role."
}

variable "tags" {
  type        = map(any)
  description = "Key-value mapping of tags for the IAM role"
}
