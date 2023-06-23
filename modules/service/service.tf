resource "aws_ecs_service" "service" {
  name    = var.service_name
  cluster = var.cluster_name

  task_definition = aws_ecs_task_definition.main.arn


  desired_count                      = var.desired_tasks
  launch_type                        = var.service_launch_type
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  network_configuration {
    security_groups = [
      aws_security_group.main.id
    ]
    subnets          = var.service_subnets
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.main.arn
    container_name   = var.service_name
    container_port   = var.service_port
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition
    ]
  }

  platform_version = var.platform_version

  depends_on = [
    aws_lb_listener_rule.main
  ]
}