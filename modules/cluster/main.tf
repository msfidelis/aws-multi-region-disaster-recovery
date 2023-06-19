resource "aws_ecs_cluster" "main" {
  name = var.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

}

resource "aws_cloudwatch_log_group" "main" {
  name = format("%s-logs", var.cluster_name)

  tags = {
    Application = var.cluster_name
  }
}