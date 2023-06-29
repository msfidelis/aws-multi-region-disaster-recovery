variable "acm_arn" {
  type = string
}

variable "api_gateway_domain_name" {
  type = string
}

variable "base_path_mappings" {
  type = list(map(any))
}