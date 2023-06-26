resource "aws_ecs_task_definition" "main" {
  family = format("%s-%s", var.cluster_name, var.service_name)

  container_definitions = templatefile(
    format("%s/templates/task-definition.json", path.module),
    {
      image               = var.service_image
      container_name      = var.service_name
      container_port      = var.service_port
      log_group           = aws_cloudwatch_log_group.main.name
      log_prefix          = var.service_name
      desired_task_cpu    = var.service_cpu
      desired_task_memory = var.service_memory
      region              = data.aws_region.current.name
      envs                = jsonencode(var.envs)
    }
  )
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.service_cpu
  memory                   = var.service_memory

  execution_role_arn = aws_iam_role.ecs_execution_role.arn
  task_role_arn      = aws_iam_role.ecs_execution_role.arn
}
