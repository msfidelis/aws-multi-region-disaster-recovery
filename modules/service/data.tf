data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_ecs_cluster" "main" {
  cluster_name = var.cluster_name
}