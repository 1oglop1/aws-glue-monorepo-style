########################################################
##               Module variables
########################################################

variable "workflow_name" {
  type        = string
  description = "The name you assign to this workflow."
}


variable "security_name" {
  type        = string
  description = "Name of the security configuration."
}


variable "raw_db_name" {
  type        = string
  description = "Name of the Raw database"
}

variable "refined_db_name" {
  type        = string
  description = "Name of the Refined database."
}
