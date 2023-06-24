module "app_demo_sa_east_1" {
  source = "./modules/service"

  providers = {
    aws = aws.primary
  }

  vpc_id = module.vpc_sa_east_1.vpc_id

  cluster_name = module.cluster_sa_east_1.cluster_name
  route53_zone = module.cluster_sa_east_1.private_zone

  service_name  = "app-demo"
  service_image = "fidelissauro/chip:v2"

  service_port = 8080
  service_hostname = [
    format("app-demo.%s", var.route53_private_zone)
  ]

  service_subnets = module.vpc_sa_east_1.private_subnets

  private_listener = module.cluster_sa_east_1.listener_arn

  service_launch_type = "FARGATE"

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  service_cpu    = 256
  service_memory = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 30
  cpu_to_scale_down       = 20
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1


  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 80
  }
}


module "app_demo_us_east_1" {
  source = "./modules/service"

  providers = {
    aws = aws.disaster-recovery
  }

  vpc_id = module.vpc_us_east_1.vpc_id

  cluster_name = module.cluster_us_east_1.cluster_name
  route53_zone = module.cluster_us_east_1.private_zone

  service_name  = "app-demo"
  service_image = "fidelissauro/chip:v2"

  service_port = 8080
  service_hostname = [
    format("app-demo.%s", var.route53_private_zone)
  ]

  service_subnets  = module.vpc_us_east_1.private_subnets
  private_listener = module.cluster_us_east_1.listener_arn

  service_launch_type = "FARGATE"

  # Auto Scale Limits
  desired_tasks = 2
  min_tasks     = 2
  max_tasks     = 10

  # Tasks CPU / Memory limits
  service_cpu    = 256
  service_memory = 512

  # CPU metrics for Auto Scale
  cpu_to_scale_up         = 30
  cpu_to_scale_down       = 20
  cpu_verification_period = 60
  cpu_evaluation_periods  = 1


  service_healthcheck = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 80
  }
}
