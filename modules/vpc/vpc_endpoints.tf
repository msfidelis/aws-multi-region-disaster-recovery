
resource "aws_security_group" "endpoints" {
  name        = format("%s-endpoints", var.project_name)
  description = format("%s-endpoints", var.project_name)

  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id       = aws_vpc.main.id
  service_name = format("com.amazonaws.%s.dynamodb", data.aws_region.current.name)
}

resource "aws_vpc_endpoint_route_table_association" "dynamodb" {
  route_table_id  = aws_route_table.igw_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.dynamodb.id
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = format("com.amazonaws.%s.s3", data.aws_region.current.name)
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  route_table_id  = aws_route_table.igw_route_table.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}


# resource "aws_vpc_endpoint" "ecr_api" {
#   vpc_id       = aws_vpc.main.id
#   service_name = format("com.amazonaws.%s.ecr.api", data.aws_region.current.name)
# }

# resource "aws_vpc_endpoint" "ecr_dkr" {
#   vpc_id       = aws_vpc.main.id
#   service_name = format("com.amazonaws.%s.ecr.dkr", data.aws_region.current.name)
# }


resource "aws_vpc_endpoint" "sqs" {
  vpc_id              = aws_vpc.main.id
  service_name        = format("com.amazonaws.%s.sqs", data.aws_region.current.name)
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"

  security_group_ids = [
    aws_security_group.endpoints.id,
  ]

  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1b.id,
    aws_subnet.private_subnet_1c.id,
  ]

}

# resource "aws_vpc_endpoint_subnet_association" "sqs_1a" {
#   subnet_id  = aws_subnet.private_subnet_1a.id
#   vpc_endpoint_id = aws_vpc_endpoint.sqs.id
# }

# resource "aws_vpc_endpoint_subnet_association" "sqs_1b" {
#   subnet_id  = aws_subnet.private_subnet_1b.id
#   vpc_endpoint_id = aws_vpc_endpoint.sqs.id
# }

# resource "aws_vpc_endpoint_subnet_association" "sqs_1c" {
#   subnet_id  = aws_subnet.private_subnet_1c.id
#   vpc_endpoint_id = aws_vpc_endpoint.sqs.id
# }

resource "aws_vpc_endpoint" "sns" {
  vpc_id              = aws_vpc.main.id
  service_name        = format("com.amazonaws.%s.sns", data.aws_region.current.name)
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"

  security_group_ids = [
    aws_security_group.endpoints.id,
  ]

  subnet_ids = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1b.id,
    aws_subnet.private_subnet_1c.id,
  ]

}