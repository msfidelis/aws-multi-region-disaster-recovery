resource "aws_alb" "main" {
  name    = format("%s-ingress", var.cluster_name)
  subnets = var.subnets
  security_groups = [
    aws_security_group.main.id
  ]

  tags = {
    Name        = format("%s-alb", var.cluster_name)
    Environment = var.cluster_name
  }
}

resource "aws_alb_listener" "main" {

  load_balancer_arn = aws_alb.main.arn

  port              = lookup(var.listener, "port", "")
  protocol          = lookup(var.listener, "protocol", "HTTP")
  ssl_policy        = lookup(var.listener, "ssl_policy", "")
  certificate_arn   = lookup(var.listener, "certificate_arn", "")

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = ""
      status_code  = "200"
    }
  }

}