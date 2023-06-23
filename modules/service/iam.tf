

# Cluster Execution Role
resource "aws_iam_role" "ecs_execution_role" {
  name               = format("%s-%s-role", var.cluster_name, var.service_name)
  assume_role_policy = file(format("%s/templates/ecs-task-execution-role.json", path.module))
}

# Cluster Execution Policy
resource "aws_iam_role_policy" "ecs_execution_role_policy" {
  name   = format("%s-%s-policy", var.cluster_name, var.service_name)
  policy = file(format("%s/templates/ecs-execution-role-policy.json", path.module))
  role   = aws_iam_role.ecs_execution_role.id
}