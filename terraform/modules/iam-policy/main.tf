resource "aws_iam_policy" "policy" {
  name   = var.iam_role_policy_name
  policy = var.iam_role_policy
}

resource "aws_iam_policy_attachment" "attach_policy" {
  name       = var.attachment_name
  roles      = var.roles
  policy_arn = aws_iam_policy.policy.arn
}
