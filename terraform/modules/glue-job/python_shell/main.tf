resource "aws_glue_job" "job" {
  name        = var.name
  connections = var.connections

  max_capacity = var.max_capacity

  max_retries = var.max_retries

  glue_version = "1.0"

  command {
    name            = "pythonshell"
    script_location = var.script_location
    python_version  = var.python_version
  }

  default_arguments = var.default_arguments
  description       = var.description
  execution_property {
    max_concurrent_runs = var.max_concurrent_runs
  }

  role_arn = var.role_arn
  tags     = var.tags
}
