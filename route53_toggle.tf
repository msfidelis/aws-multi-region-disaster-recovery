resource "aws_route53_record" "primary" {

  provider = aws.primary

  zone_id = var.route53_hosted_zone
  name    = var.api_gateway_domain
  type    = "A"
  #   ttl     = 10

  weighted_routing_policy {
    weight = lookup(var.site_routing, "sa-east-1")
  }

  set_identifier = "primary"

  alias {
    evaluate_target_health = true
    name                   = module.custom_domain_sa_east_1.regional_domain_name
    zone_id                = module.custom_domain_sa_east_1.regional_zone_id
  }
}


resource "aws_route53_record" "dr" {

  provider = aws.disaster-recovery

  zone_id = var.route53_hosted_zone
  name    = var.api_gateway_domain
  type    = "A"

  weighted_routing_policy {
    weight = lookup(var.site_routing, "us-east-1")
  }

  set_identifier = "disaster-recovery"

  alias {
    evaluate_target_health = true
    name                   = module.custom_domain_us_east_1.regional_domain_name
    zone_id                = module.custom_domain_us_east_1.regional_zone_id
  }
}
