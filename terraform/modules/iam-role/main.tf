resource "aws_iam_role" "role" {
  name               = var.iam_role_name
  assume_role_policy = var.assume_role_policy
  tags               = var.tags
}
