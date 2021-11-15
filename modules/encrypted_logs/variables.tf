variable "log_group_name" {
  type        = string
  description = "Name for CloudWatch log group"
}

variable "tags" {
  type        = map(string)
  description = "Tags to add to CloudWatch log group and associated KMS key"
  default     = {}
}
