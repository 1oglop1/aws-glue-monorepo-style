variable "script_location" {
  type        = string
  description = "Specifies the S3 path to a script that executes a job."
}

variable "python_version" {
  type        = string
  description = "The Python version being used to execute a Python shell job. Allowed values are 2 or 3."
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

}

variable "job_command" {
  type        = string
  description = "The name of the job command."
  default     = "glueetl"
}

variable "glue_version" {
  type        = string
  description = "The Glue version to use."
  default     = "1.0"
}

variable "max_capacity" {
  type        = string
  description = "The maximum number of AWS Glue data processing units (DPUs) that can be allocated when this job runs. Required when pythonshell is set, accept either 0.0625 or 1.0. "
  default     = null
}

variable "number_of_workers" {
  type        = number
  default     = null
}

variable "worker_type" {
  type        = string
  default     = null
}

variable "max_retries" {
  type        = string
  default     = null
}