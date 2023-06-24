output "custom_domain_name_cloudfront" {
  value = aws_api_gateway_domain_name.main.cloudfront_domain_name
}

output "custom_domain_name_domain" {
  value = aws_api_gateway_domain_name.main.domain_name
}

output "regional_domain_name" {
  value = aws_api_gateway_domain_name.main.regional_domain_name
}

output "regional_zone_id" {
  value = aws_api_gateway_domain_name.main.regional_zone_id
}