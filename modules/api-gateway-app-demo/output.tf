output "id" {
  value = aws_api_gateway_rest_api.main.id
}

output "stage" {
  value = aws_api_gateway_stage.main.stage_name
}