module "sales_worker_sa_east_1" {
  source = "./modules/service"

  providers = {
    aws = aws.primary
  }

  vpc_id = module.vpc_sa_east_1.vpc_id

  cluster_name = module.cluster_sa_east_1.cluster_name
  route53_zone = module.cluster_sa_east_1.private_zone

  service_name  = "sales-worker"
  service_image = "fidelissauro/sales-worker:latest"

  service_port = 8090
  service_hostname = [
    format("sales-worker.%s", var.route53_private_zone)
  ]

  service_subnets  = module.vpc_sa_east_1.private_subnets
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
    port                = 8090
  }

  envs = [
    {
      name : "AWS_REGION",
      value : "sa-east-1"
    },
    {
      name : "DYNAMO_SALES_TABLE",
      value : aws_dynamodb_table.sales.name
    },
    {
      name : "DYNAMO_SALES_IDEMPOTENCY_TABLE",
      value : aws_dynamodb_table.idempotency.name
    },
    {
      name : "SNS_SALES_PROCESSING_TOPIC",
      value : module.sales_sns_sa_east_1.arn
    },
    {
      name : "SSM_PARAMETER_STORE_STATE",
      value : module.ssm_parameter_state_sa_east_1.name
    },
    {
      name : "SQS_SALES_QUEUE",
      value : module.sales_processing_queue_sa_east_1.sqs_queue_url
    },
    {
      name : "S3_SALES_BUCKET",
      value : module.bucket_sa_east_1.id
    }
  ]

}


module "sales_worker_us_east_1" {
  source = "./modules/service"

  providers = {
    aws = aws.disaster-recovery
  }

  vpc_id = module.vpc_us_east_1.vpc_id

  cluster_name = module.cluster_us_east_1.cluster_name
  route53_zone = module.cluster_us_east_1.private_zone

  service_name  = "sales-worker"
  service_image = "fidelissauro/sales-worker:latest"

  service_port = 8090
  service_hostname = [
    format("sales-worker.%s", var.route53_private_zone)
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
    port                = 8090
  }


  envs = [
    {
      name : "AWS_REGION",
      value : "us-east-1"
    },
    {
      name : "DYNAMO_SALES_TABLE",
      value : aws_dynamodb_table.sales.name
    },
    {
      name : "DYNAMO_SALES_IDEMPOTENCY_TABLE",
      value : aws_dynamodb_table.idempotency.name
    },
    {
      name : "SNS_SALES_PROCESSING_TOPIC",
      value : module.sales_sns_us_east_1.arn
    },
    {
      name : "SSM_PARAMETER_STORE_STATE",
      value : module.ssm_parameter_state_us_east_1.name
    },
    {
      name : "SQS_SALES_QUEUE",
      value : module.sales_processing_queue_us_east_1.sqs_queue_url
    },
    {
      name : "S3_SALES_BUCKET",
      value : module.bucket_us_east_1.id
    }
  ]
}
