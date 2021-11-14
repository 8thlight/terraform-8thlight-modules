variable "role_name" {
  type        = string
  description = "Name for IAM role"
}

variable "role_description" {
  type        = string
  description = "Description for IAM role"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to IAM role and any IAM policies created"
  default     = {}
}

variable "services" {
  type        = list(string)
  description = "AWS services that can assume IAM role"
}

variable "policies" {
  type        = map(string)
  description = "IAM policies with an identifier as key and the policy ARN as value"
  default     = {}
}

variable "policy_documents" {
  type        = map(string)
  description = "IAM policy documents with an identifier as key and the policy document JSON as value"
  default     = {}
}
