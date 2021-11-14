# Service Role

This module provisions an IAM role that will be assumed by one or more AWS services.

## Usage

```terraform
module "service_role" {
  role_name = "ecs-task-execution"
  role_description = "ECS Task Execution Role"
  services = ["ecs-tasks.amazonaws.com"]

  policies = {
    pull_ecr_image = aws_iam_policy.pull_ecr_image.arn
  }

  policy_documents = {
    read_s3_bucket = data.aws_iam_policy_document.read_s3_bucket.json
  }

  tags = {
    environment = "staging"
  }
}

resource "aws_ecs_task_definition" "task" {
  family = "my-ecs-task"
  container_definitions = jsonencode([...])
  execution_role_arn = module.service_role.role_arn
}
```
