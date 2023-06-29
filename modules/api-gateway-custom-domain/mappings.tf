resource "aws_api_gateway_base_path_mapping" "main" {

  count       = length(var.base_path_mappings)
  api_id      = lookup(var.base_path_mappings[count.index], "api_id")
  stage_name  = lookup(var.base_path_mappings[count.index], "stage")
  domain_name = aws_api_gateway_domain_name.main.domain_name
}
