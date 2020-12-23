###################### Glue IAM ########################################

module "glue_role" {
  source             = "../modules/iam-role"
  iam_role_name      = "glue-role"
  assume_role_policy = data.aws_iam_policy_document.glue_assume_role_policy.json
  tags               = var.tags
}

data "aws_iam_policy_document" "glue_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

################# Attach AWS Managed Policies ##################

resource "aws_iam_policy_attachment" "glue_service_role" {
  name       = "AWSGlueServiceRole"
  roles      = [module.glue_role.iam_role_id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy_attachment" "s3_full_access" {
  name       = "AmazonS3FullAccess"
  roles      = [module.glue_role.iam_role_id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_policy_attachment" "cloudwatch_logs_role" {
  name       = "CloudWatchLogsFullAccess"
  roles      = [module.glue_role.iam_role_id]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
