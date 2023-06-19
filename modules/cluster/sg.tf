resource "aws_security_group" "main" {
  name        = format("%s-sg", var.cluster_name)

  vpc_id      = var.vpc_id

  ingress {
    from_port   =  lookup(var.listener, "port", "")
    to_port     =  lookup(var.listener, "port", "")
    protocol    = "tcp"
    cidr_blocks = var.ingress_rules
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-sg", var.cluster_name)
  }
}