################# Attach AWS Managed Policies ##################

resource "aws_iam_policy_attachment" "AWSGlueServiceRole" {
  name       = "AWSGlueServiceRole"
  roles      = [module.glue_role.iam_role_id]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy_attachment" "AmazonS3FullAccess" {
  name       = "AmazonS3FullAccess"
  roles      = [module.glue_role.iam_role_id]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
