module "cluster_sa_east_1" {
  source = "./modules/cluster"

  providers = {
    aws = aws.primary
  }

  cluster_name = "my-demo"

  vpc_id               = module.vpc_sa_east_1.vpc_id
  subnets              = module.vpc_sa_east_1.private_subnets
  route53_private_zone = var.route53_private_zone

  ingress_rules = [
    lookup(var.public_subnet_1a, "sa-east-1"),
    lookup(var.public_subnet_1b, "sa-east-1"),
    lookup(var.public_subnet_1c, "sa-east-1"),
    lookup(var.private_subnet_1a, "sa-east-1"),
    lookup(var.private_subnet_1b, "sa-east-1"),
    lookup(var.private_subnet_1c, "sa-east-1"),
  ]
}



module "cluster_us_east_1" {
  source = "./modules/cluster"

  providers = {
    aws = aws.disaster-recovery
  }

  cluster_name = "my-demo"

  vpc_id               = module.vpc_us_east_1.vpc_id
  subnets              = module.vpc_us_east_1.private_subnets
  route53_private_zone = var.route53_private_zone

  ingress_rules = [
    lookup(var.public_subnet_1a, "us-east-1"),
    lookup(var.public_subnet_1b, "us-east-1"),
    lookup(var.public_subnet_1c, "us-east-1"),
    lookup(var.private_subnet_1a, "us-east-1"),
    lookup(var.private_subnet_1b, "us-east-1"),
    lookup(var.private_subnet_1c, "us-east-1"),
  ]
}
