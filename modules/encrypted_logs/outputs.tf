output "write_logs_policy_arn" {
  value = aws_iam_policy.write_logs.arn
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.main.arn
}
