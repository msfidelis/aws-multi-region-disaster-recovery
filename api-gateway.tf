module "custom_domain_sa_east_1" {
  source = "./modules/api-gateway-custom-domain"

  providers = {
    aws = aws.primary
  }
  acm_arn                 = module.acm_sa_east_1.arn
  api_gateway_domain_name = var.api_gateway_domain
}


module "custom_domain_us_east_1" {
  source = "./modules/api-gateway-custom-domain"

  providers = {
    aws = aws.disaster-recovery
  }
  acm_arn                 = module.acm_us_east_1.arn
  api_gateway_domain_name = var.api_gateway_domain
}


module "api_gateway_app_demo_sa_east_1" {
  source = "./modules/api-gateway-app-demo"

  providers = {
    aws = aws.primary
  }

  gateway_name = "app-demo"
  stage_name   = "prod"
  vpc_link     = module.cluster_sa_east_1.vpc_link
}

module "api_gateway_app_demo_us_east_1" {
  source = "./modules/api-gateway-app-demo"

  providers = {
    aws = aws.disaster-recovery
  }

  gateway_name = "app-demo"
  stage_name   = "prod"
  vpc_link     = module.cluster_us_east_1.vpc_link
}


