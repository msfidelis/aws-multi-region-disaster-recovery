// com.amazonaws.us-east-1.dynamodb

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

# resource "aws_vpc_endpoint" "sns" {
#   vpc_id       = aws_vpc.main.id
#   service_name = format("com.amazonaws.%s.sns", data.aws_region.current.name)
# }

# resource "aws_vpc_endpoint" "sqs" {
#   vpc_id       = aws_vpc.main.id
#   service_name = format("com.amazonaws.%s.sqs", data.aws_region.current.name)
# }