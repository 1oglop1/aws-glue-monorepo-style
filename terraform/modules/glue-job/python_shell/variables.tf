variable "script_location" {
  type        = string
  description = "Specifies the S3 path to a script that executes a job."
}

variable "python_version" {
  type        = string
  description = "The Python version being used to execute a Python shell job. Allowed values are 2 or 3."
  default     = "3"
  validation {
    condition     = contains(["2", "3"], var.python_version)
    error_message = "Python version can be only  '2' or '3'."
  }
}

variable "connections" {
  type        = list(string)
  description = "The list of connections used for this job."
  default     = []
}

variable "default_arguments" {
  type        = map(string)
  description = "The map of default arguments for this job. You can specify arguments here that your own job-execution script consumes, as well as arguments that AWS Glue itself consumes. For information about how to specify and consume your own Job arguments, see the Calling AWS Glue APIs in Python topic in the developer guide. For information about the key-value pairs that AWS Glue consumes to set up your job, see the Special Parameters Used by AWS Glue topic in the developer guide."
  default     = {}
}

variable "description" {
  type        = string
  description = "Description of the job."
  default     = ""
}

variable "max_concurrent_runs" {
  type        = string
  description = "The maximum number of concurrent runs allowed for a job. The default is 1."
  default     = "1"
}

variable "name" {
  type        = string
  description = "Name of the job"
}

variable "role_arn" {
  type        = string
  description = "The ARN of the IAM role associated with this job."

}

variable "tags" {
  type        = map(string)
  description = "AWS resource tags"
  default     = {}
}

variable "max_capacity" {
  type        = string
  description = "The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs. Required when pythonshell is set, accept either 0.0625 or 1.0. "
  default     = "0.0625"
  validation {
    condition     = contains(["0.0625", "1.0"], var.max_capacity)
    error_message = "Max capacity for python job must be a string: '0.625' or '1.0'."
  }
}

variable "max_retries" {
  description = "Number of retries"
  type        = string
  default     = null
}
