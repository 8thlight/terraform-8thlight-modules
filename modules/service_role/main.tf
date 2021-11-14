resource "aws_iam_role" "main" {
  name               = var.role_name
  description        = var.role_description
  assume_role_policy = data.aws_iam_policy_document.services_can_assume.json
  tags               = var.tags
}

data "aws_iam_policy_document" "services_can_assume" {
  statement {
    sid     = "AssumeRole"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "service"
      identifiers = var.services
    }
  }
}

resource "aws_iam_role_policy_attachment" "main" {
  for_each = merge(
    var.policies,
    zipmap(var.policy_documents, aws_iam_policy.main[*].arn)
  )

  role       = aws_iam_role.main.id
  policy_arn = each.value
}

resource "aws_iam_policy" "main" {
  for_each = var.policy_documents

  name   = each.key
  policy = each.value
  tags   = var.tags
}
