resource "aws_kms_key" "main" {
  description             = var.cluster_name
}