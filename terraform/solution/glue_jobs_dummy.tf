###################### Glue Dummy Jobs for complex workflow demonstration ########################################
locals {
  dummy_job_location = "s3://${var.glue_bucket_name}/code/dummy_job/dummy_transition/dummy_transition.py"
}
module "dummy_job" {
  for_each = toset(
  [
      "dummy_job_0",
      "dummy_job_1",
      "dummy_job_2",
      "dummy_job_3",
      "dummy_job_4",
      "dummy_job_5",
    ]
  )
  source          = "../modules/glue-job/python_shell"
  name            = each.value
  script_location = local.dummy_job_location
  role_arn        = module.glue_role.iam_role_arn
  default_arguments = {
    "--job-bookmark-option"      = "job-bookmark-disable"
    "--TempDir"                  = "s3://${var.glue_bucket_name}/glue-temp"
    "--APP_SETTINGS_ENVIRONMENT" = "dev"
    "--LOG_LEVEL"                = "DEBUG"
    "--S3_BUCKET" = var.glue_bucket_name
  }
  tags              = var.tags
}
#
#module "dummy_job_2" {
#  source          = "../modules/glue-job/python_shell"
#  name            = "dummy_job_2"
#  script_location = local.dummy_job_location
#  role_arn        = module.glue_role.iam_role_arn
#  default_arguments = {
#    "--job-bookmark-option"      = "job-bookmark-disable"
#    "--TempDir"                  = "s3://${var.glue_bucket_name}/glue-temp"
#    "--APP_SETTINGS_ENVIRONMENT" = "dev"
#    "--LOG_LEVEL"                = "DEBUG"
#    "--S3_BUCKET" = var.glue_bucket_name
#  }
#  tags              = var.tags
#}
#
#module "dummy_job_3" {
#  source          = "../modules/glue-job/python_shell"
#  name            = "dummy_job_3"
#  script_location = local.dummy_job_location
#  role_arn        = module.glue_role.iam_role_arn
#  default_arguments = {
#    "--job-bookmark-option"      = "job-bookmark-disable"
#    "--TempDir"                  = "s3://${var.glue_bucket_name}/glue-temp"
#    "--APP_SETTINGS_ENVIRONMENT" = "dev"
#    "--LOG_LEVEL"                = "DEBUG"
#    "--S3_BUCKET" = var.glue_bucket_name
#  }
#  tags              = var.tags
#}
#
#module "dummy_job_4" {
#  source          = "../modules/glue-job/python_shell"
#  name            = "dummy_job_4"
#  script_location = local.dummy_job_location
#  role_arn        = module.glue_role.iam_role_arn
#  default_arguments = {
#    "--job-bookmark-option"      = "job-bookmark-disable"
#    "--TempDir"                  = "s3://${var.glue_bucket_name}/glue-temp"
#    "--APP_SETTINGS_ENVIRONMENT" = "dev"
#    "--LOG_LEVEL"                = "DEBUG"
#    "--S3_BUCKET" = var.glue_bucket_name
#  }
#  tags              = var.tags
#}
#
#module "dummy_job_5" {
#  source          = "../modules/glue-job/python_shell"
#  name            = "dummy_job_5"
#  script_location = local.dummy_job_location
#  role_arn        = module.glue_role.iam_role_arn
#  default_arguments = {
#    "--job-bookmark-option"      = "job-bookmark-disable"
#    "--TempDir"                  = "s3://${var.glue_bucket_name}/glue-temp"
#    "--APP_SETTINGS_ENVIRONMENT" = "dev"
#    "--LOG_LEVEL"                = "DEBUG"
#    "--S3_BUCKET" = var.glue_bucket_name
#  }
#  tags              = var.tags
#}
#
#module "dummy_job_6" {
#  source          = "../modules/glue-job/python_shell"
#  name            = "dummy_job_6"
#  script_location = "s3://${var.glue_bucket_name}/code/${module.dummy_job_1.job_name}/dummy_transition/dummy_transition.py"
#  role_arn        = module.glue_role.iam_role_arn
#  default_arguments = {
#    "--job-bookmark-option"      = "job-bookmark-disable"
#    "--TempDir"                  = "s3://${var.glue_bucket_name}/glue-temp"
#    "--APP_SETTINGS_ENVIRONMENT" = "dev"
#    "--LOG_LEVEL"                = "DEBUG"
#    "--S3_BUCKET" = var.glue_bucket_name
#  }
#  tags              = var.tags
#}
