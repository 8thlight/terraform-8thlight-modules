# Encrypted Logs

This module provisions a CloudWatch log group encrypted with KMS.

## Usage

```terraform
module "encrypted_logs" {
  source = "modules/encrypted_logs" // update when we've figured out how/if we will publish

  log_group_name = "encrypted-logs"
  tags = {
    environment = "staging"
  }
}

resource "aws_sfn_state_machine" "step_function" {
  name = "my-step-function"
  role_arn = aws_iam_role.step_function.arn

  logging_configuration {
    logging_destination = "${module.encrypted_logs.log_group_arn}:*"
    include_execution_data = true
    level = "ALL"
  }
}

resource "aws_iam_role_policy_attachment" "step_function" {
  role = aws_iam_role.step_function.id
  policy_arn = module.encrypted_logs.write_logs_policy_arn
}
```
