resource "aws_ssm_parameter" "main" {
  name  = var.name
  type  = "String"
  value = var.value
}