module "vpc_sa_east_1" {
  source = "./modules/vpc"

  providers = {
    aws = aws.primary
  }

  project_name = "primary"
  vpc_cidr     = lookup(var.vpc_cidr, "sa-east-1")

  public_subnet_1a = lookup(var.public_subnet_1a, "sa-east-1")
  public_subnet_1b = lookup(var.public_subnet_1b, "sa-east-1")
  public_subnet_1c = lookup(var.public_subnet_1c, "sa-east-1")

  private_subnet_1a = lookup(var.private_subnet_1a, "sa-east-1")
  private_subnet_1b = lookup(var.private_subnet_1b, "sa-east-1")
  private_subnet_1c = lookup(var.private_subnet_1c, "sa-east-1")
}


module "vpc_us_east_1" {
  source = "./modules/vpc"

  providers = {
    aws = aws.disaster-recovery
  }

  project_name = "disaster-recovery"
  vpc_cidr     = lookup(var.vpc_cidr, "us-east-1")

  public_subnet_1a = lookup(var.public_subnet_1a, "us-east-1")
  public_subnet_1b = lookup(var.public_subnet_1b, "us-east-1")
  public_subnet_1c = lookup(var.public_subnet_1c, "us-east-1")

  private_subnet_1a = lookup(var.private_subnet_1a, "us-east-1")
  private_subnet_1b = lookup(var.private_subnet_1b, "us-east-1")
  private_subnet_1c = lookup(var.private_subnet_1c, "us-east-1")
}
