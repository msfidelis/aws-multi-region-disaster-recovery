
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s-internet-gateway", var.project_name, data.aws_region.current.name)
  }
}

resource "aws_route_table" "igw_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s-internet-gateway", var.project_name, data.aws_region.current.name)
  }
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.igw_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}