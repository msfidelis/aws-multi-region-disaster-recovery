module "acm_sa_east_1" {

  source = "./modules/acm"

  providers = {
    aws = aws.primary
  }

  domain_name     = format("*.%s", var.route53_domain)
  route53_zone_id = var.route53_hosted_zone

}


module "acm_us_east_1" {

  source = "./modules/acm"

  providers = {
    aws = aws.disaster-recovery
  }

  domain_name     = format("*.%s", var.route53_domain)
  route53_zone_id = var.route53_hosted_zone

}
