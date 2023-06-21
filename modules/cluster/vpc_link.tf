resource "aws_lb" "vpc_link" {
  name               = format("%s-vpc-link", var.cluster_name)
  subnets            = var.subnets
  load_balancer_type = "network"
  internal           = true

  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true

  depends_on = [
    aws_lb.main,
    aws_lb_listener.main
  ]
}

resource "aws_lb_target_group" "vpc_link" {
  name        = format("%s-vpc-link", var.cluster_name)
  target_type = "alb"

  port     = lookup(var.listener, "port", "")
  protocol = "TCP"
  vpc_id   = var.vpc_id

  depends_on = [
    aws_lb.main,
    aws_lb_listener.main
  ]
}

resource "aws_lb_listener" "vpc_link_listener" {

  load_balancer_arn = aws_lb.vpc_link.arn

  port     = lookup(var.listener, "port", "")
  protocol = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vpc_link.arn
  }

  depends_on = [
    aws_lb.main,
    aws_lb_listener.main
  ]

}

resource "aws_lb_target_group_attachment" "vpc_link" {
  target_group_arn = aws_lb_target_group.vpc_link.arn
  target_id        = aws_lb.main.id
  port             = lookup(var.listener, "port", "")
}

resource "aws_api_gateway_vpc_link" "main" {
  name        = var.cluster_name
  description = var.cluster_name
  target_arns = [aws_lb.vpc_link.arn]
}
