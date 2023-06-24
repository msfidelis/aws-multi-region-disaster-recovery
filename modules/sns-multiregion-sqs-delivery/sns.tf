resource "aws_sns_topic" "main" {
  name                        = format("%s", var.name)
#   fifo_topic                  = true
#   content_based_deduplication = true
}

resource "aws_sns_topic_subscription" "primary" {
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.main.arn
  endpoint             = var.sqs_queue
}

resource "aws_sns_topic_subscription" "replica" {
  protocol             = "sqs"
  raw_message_delivery = true
  topic_arn            = aws_sns_topic.main.arn
  endpoint             = var.sqs_queue_replica
}