# General vars
variable "name" {
  description = "Name of the repository."
  type        = string
  default     = "navi-dracs-test"
}
variable "force_delete" {
  description = "If `true`, will delete the repository even if it contains images. Defaults to `false`"
  type        = bool
  default     = false
}
variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository. Must be one of: `MUTABLE` or `IMMUTABLE`."
  type        = string
  default     = "MUTABLE"
  validation {
    condition     = contains(["MUTABLE", "IMMUTABLE"], var.image_tag_mutability)
    error_message = "The image_tag_mutability must be either MUTABLE or IMMUTABLE."
  }
}

# Encryption type
variable "encryption_type" {
  description = "The encryption type to use for the repository. Valid values are `AES256` or `KMS`"
  type        = string
  default     = "KMS"
  validation {
    condition     = contains(["AES256", "KMS"], var.encryption_type)
    error_message = "The encryption_type must be either AES256 or KMS."
  }
}

# KMS key
variable "kms_key" {
  description = "The ARN of the KMS key to use when encryption_type is `KMS`. If not specified when encryption_type is `KMS`, uses a new KMS key. Otherwise, uses the default AWS managed key for ECR."
  type        = string
  default     = ""
}
variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  type        = bool
  default     = true
}

# Timeouts
variable "timeouts_delete" {
  description = "How long to wait for a repository to be deleted."
  type        = string
  default     = null
}

# Tags
variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Name = "navi"
    ENV  = "Dev"
  }
}

# Policy
variable "policy" {
  description = "Manages the ECR repository policy"
  type        = string
  default     = null
}

# Lifecycle policy
variable "lifecycle_policy" {
  description = "Manages the ECR repository lifecycle policy"
  type        = string
  default     = null
}


#KMS
variable "description" {
  description = "The description to give to the key"
  type        = string
  default     = "The description to give to the key"
}
variable "deletion_window" {
  description = "Number of days before a key actually gets deleted once it's been scheduled for deletion. Valid value between 7 and 30 days"
  type        = number
  default     = 7
}
variable "key_spec" {
  default = "SYMMETRIC_DEFAULT"
}
variable "enabled" {
  default = true
}


#ECS
variable "app_name" {
  type        = string
  description = "Application Name"
  default     = "navi-dracs-test"
}
variable "app_environment" {
  type        = string
  description = "Application Environment"
  default     = "dev"
}
variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}
variable "vpc" {
  type        = string
  description = "vpc"
  default     = "vpc-0b223569639ab823e"
}
variable "app_count" {
  type    = number
  default = 1
}
variable "subnets" {
  type        = list(string)
  default     = ["subnet-08cda1e5694272d27", "subnet-093e3079c5e3c5d4e"]
  description = "List of Availability Zones (e.g. `['us-east-1a', 'us-east-1b', 'us-east-1c']`)."
}