variable "script_location" {
  type        = string
  description = "Specifies the S3 path to a script that executes a job."
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

variable "number_of_workers" {
  type        = number
  description = "Number of Glue (G.#X) workers"
  default     = null
}

variable "worker_type" {
  description = "Worker type"
  type        = string
  default     = "G.1X"
  validation {
    condition     = contains(["G.1X", "G.2X"], var.worker_type)
    error_message = "Worker type can be one of  'G.1X', 'G.2X'."
  }
}

variable "max_retries" {
  description = "Number of retries"
  type        = string
  default     = null
}
