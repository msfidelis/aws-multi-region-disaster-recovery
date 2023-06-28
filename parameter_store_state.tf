module "ssm_parameter_state_sa_east_1" {
  source = "./modules/parameter_store"

  providers = {
    aws = aws.primary

  }

  name  = format("/%s/site/state", var.project_name)
  value = lookup(var.state, "sa-east-1")
}

module "ssm_parameter_state_us_east_1" {
  source = "./modules/parameter_store"

  providers = {
    aws = aws.disaster-recovery

  }

  name  = format("/%s/site/state", var.project_name)
  value = lookup(var.state, "us-east-1")
}