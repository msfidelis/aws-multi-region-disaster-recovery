module "sales_processing_queue_sa_east_1" {
  source = "./modules/sqs-queue"

  providers = {
    aws = aws.primary
  }

  queue_name                    = "sales-processing-queue"
  delay_seconds                 = 0
  max_message_size              = 2048
  message_retention_seconds     = 86400
  receive_wait_time_seconds     = 10
  dlq_redrive_max_receive_count = 4
  visibility_timeout_seconds    = 60

  sns_topic_name = var.sales_sns_topic_name
}

module "sales_processing_queue_us_east_1" {
  source = "./modules/sqs-queue"

  providers = {
    aws = aws.disaster-recovery
  }

  queue_name                    = "sales-processing-queue"
  delay_seconds                 = 0
  max_message_size              = 2048
  message_retention_seconds     = 86400
  receive_wait_time_seconds     = 10
  dlq_redrive_max_receive_count = 4
  visibility_timeout_seconds    = 60

  sns_topic_name = var.sales_sns_topic_name
}

module "sales_sns_sa_east_1" {
  source = "./modules/sns-multiregion-sqs-delivery"

  providers = {
    aws = aws.primary
  }

  name              = "sales-processing-topic"
  sqs_queue         = module.sales_processing_queue_sa_east_1.sqs_queue_arn
  sqs_queue_replica = module.sales_processing_queue_us_east_1.sqs_queue_arn
}

module "sales_sns_us_east_1" {
  source = "./modules/sns-multiregion-sqs-delivery"

  providers = {
    aws = aws.disaster-recovery
  }

  name              = var.sales_sns_topic_name
  sqs_queue         = module.sales_processing_queue_us_east_1.sqs_queue_arn
  sqs_queue_replica = module.sales_processing_queue_sa_east_1.sqs_queue_arn
}