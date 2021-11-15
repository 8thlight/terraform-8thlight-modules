resource "aws_cloudwatch_log_group" "main" {
  name       = var.log_group_name
  kms_key_id = aws_kms_key.main.arn
  tags       = var.tags
}

// Probably worth creating a KMS key module to use here instead
resource "aws_kms_key" "main" {
  description         = "Encryption key for ${var.log_group_name} logs"
  enable_key_rotation = true
  tags                = var.tags
}

resource "aws_kms_alias" "main" {
  name          = "alias/${log_group_name}-logs"
  target_key_id = aws_kms_key.main.key_id
}

resource "aws_iam_policy" "write_logs" {
  name   = "write-${var.log_group_name}-logs"
  policy = data.aws_iam_policy_document.write_logs.json
}

resource "aws_iam_policy_document" "write_logs" {
  statement {
    sid     = "CreateLogStream"
    actions = ["logs:CreateLogStream"]
    resources = [
      "${aws_cloudwatch_log_group.main.arn}:log-stream:*"
    ]
  }

  statement {
    sid     = "WriteLogs"
    actions = ["logs:PutLogEvents"]
    resources = [
      "${aws_cloudwatch_log_group.main.arn}:log-stream:*"
    ]
  }

  statement {
    sid = "UseLogEncryption"
    actions = [
      "kms:GenerateDataKey",
      "kms:Decrypt",
    ]
    resources = [
      aws_kms_key.main.arn,
    ]
  }
}
