resource "aws_api_gateway_domain_name" "main" {
  regional_certificate_arn = var.acm_arn
  domain_name              = var.api_gateway_domain_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
