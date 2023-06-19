resource "aws_alb" "vpc_link" {
    name                = format("%s-vpc-link", var.cluster_name)
    subnets             = var.subnets
    load_balancer_type  = "network"
    internal            = true

    enable_deletion_protection = true
}

resource "aws_lb_target_group" "vpc_link" {
  name        = format("%s-vpc-link", var.cluster_name)
  target_type = "alb"

  port        = lookup(var.listener, "port", "")
  protocol    = "TCP"
  vpc_id      = var.vpc_id
}

resource "aws_alb_listener" "vpc_link_listener" {

  load_balancer_arn = aws_alb.vpc_link.arn

  port              = lookup(var.listener, "port", "")
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vpc_link.arn
  }

}

resource "aws_lb_target_group_attachment" "vpc_link" {
  target_group_arn = aws_lb_target_group.vpc_link.arn
  target_id        = aws_alb.main.id
  port             = lookup(var.listener, "port", "")
}

resource "aws_api_gateway_vpc_link" "main" {
  name        = var.cluster_name
  description = var.cluster_name
  target_arns = [ aws_alb.vpc_link.arn ]
}