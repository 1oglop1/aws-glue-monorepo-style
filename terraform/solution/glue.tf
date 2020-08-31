###################### Glue IAM ########################################

module "glue_role" {
  source             = "../modules/iam-role"
  iam_role_name      = "glue-role"
  assume_role_policy = data.aws_iam_policy_document.glue-assume-role-policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "glue-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

###################### Glue Workflow ########################################

module "glue" {
  source          = "../modules/glue"
  workflow_name   = "etl-workflow"
  security_name   = "glueSecurityConfig"
  raw_db_name     = "rawzonedb"
  refined_db_name = "refinedzonedb"
}

###################### Glue Triggers ########################################

resource "aws_cloudformation_stack" "glue" {
  name          = "etl-triggers"
  template_body = <<STACK
{
  "Resources" : {
    "StartRawToRefinedTrigger": {
        "Type" : "AWS::Glue::Trigger",
        "Properties" : {
            "Actions" : [ {"JobName" : "${module.ds1_raw_to_refined_job.glue_job_name}"}],
            "Description" : "Start raw to refined jobs",
            "Name" : "start-raw-to-refined",
            "Type" : "ON_DEMAND",
            "StartOnCreation" : "false",
            "WorkflowName" : "etl-workflow",
            "Tags" : {"terraform" : "true"}
        }
    },
    "StartRefinedToCuratedTrigger": {
        "Type" : "AWS::Glue::Trigger",
        "Properties" : {
            "Actions" : [ {"JobName" : "${module.ds1_refined_to_curated_job.glue_job_name}"}],
            "Description" : "Start refined to curated jobs",
            "Name" : "start-refined-to-curated",
            "Type" : "CONDITIONAL",
            "StartOnCreation" : "true",
            "Predicate": {
              "Conditions": [
                {
                  "LogicalOperator": "EQUALS",
                  "JobName": "${module.ds1_raw_to_refined_job.glue_job_name}",
                  "State": "SUCCEEDED"
                }
              ],
              "Logical": "AND"
            },
            "WorkflowName" : "etl-workflow",
            "Tags" : {"terraform" : "true"}
        }
    }
  }
}
STACK
}

###################### Glue Jobs ########################################

module "ds1_raw_to_refined_job" {
  source            = "../modules/glue-job"
  name              = "ds1-raw-to-refined"
  glue_version      = "1.0"
  script_location   = "s3://your-awsglue-bucket/code/ds1/raw_to_refined/raw_to_refined.py"
  role_arn          = module.glue_role.iam_role_arn
  python_version    = "3"
  default_arguments = {
    "--extra-py-files"           = <<EOF
                                s3://your-awsglue-bucket/code/ds1/raw_to_refined/dependencies/config.py,
                                s3://your-awsglue-bucket/code/ds1/raw_to_refined/dependencies/glue_shared-0.0.1-py3-none-any.whl,
                                s3://your-awsglue-bucket/code/ds1/raw_to_refined/dependencies/s3fs-0.4.2-py3-none-any.whl,
                                s3://your-awsglue-bucket/code/ds1/raw_to_refined/dependencies/pandas-1.0.3-cp36-cp36m-manylinux1_x86_64.whl,
                                s3://your-awsglue-bucket/code/ds1/raw_to_refined/dependencies/pyarrow-0.16.0-cp36-cp36m-manylinux2014_x86_64.whl
                            EOF
    "--job-bookmark-option"      = "job-bookmark-disable"
    "--APP_SETTINGS_ENVIRONMENT" = "dev"
    "--LOG_LEVEL"                = "DEBUG"
  }
  job_command       = "pythonshell"
  max_capacity      = "0.0625"
  tags              = var.tags
}

module "ds1_refined_to_curated_job" {
  source            = "../modules/glue-job"
  name              = "ds1-refined-to-curated"
  glue_version      = "2.0"
  script_location   = "s3://your-awsglue-bucket/code/ds1/refined_to_curated/refined_to_curated.py"
  role_arn          = module.glue_role.iam_role_arn
  python_version    = "3"
  default_arguments = {
    "--extra-py-files"           = "s3://your-awsglue-bucket/code/ds1/refined_to_curated/dependencies/refined_to_curated.zip"
    "--job-bookmark-option"      = "job-bookmark-disable"
    "--APP_SETTINGS_ENVIRONMENT" = "dev"
    "--LOG_LEVEL"                = "DEBUG"
    "--TempDir"                  = "s3://your-awsglue-bucket/glue-temp"
    "--job-language"             = "python"
  }
  job_command       = "glueetl"
  number_of_workers = "2"
  worker_type       = "Standard"
  tags              = var.tags
}
