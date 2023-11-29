resource "aws_kms_key" "ecr-key" {
  description              = var.description
  customer_master_key_spec = var.key_spec
  is_enabled               = var.enabled
  enable_key_rotation      = true
  deletion_window_in_days  = var.deletion_window
  tags                     = var.tags
}

resource "aws_kms_alias" "ecr-key" {
  name          = "alias/${var.name}"
  target_key_id = aws_kms_key.ecr-key.key_id
}