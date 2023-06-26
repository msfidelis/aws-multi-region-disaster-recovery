output "name" {
  value = var.name
}

output "arn" {
  value = aws_ssm_parameter.main.arn
}