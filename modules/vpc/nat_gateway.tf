resource "aws_eip" "main" {
  tags = {
    Name = format("%s-%s-eip", var.project_name, data.aws_region.current.name)
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public_subnet_1a.id

  tags = {
    Name = format("%s-%s-nat-gateway", var.project_name, data.aws_region.current.name)
  }
}

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s-private", var.project_name, data.aws_region.current.name)
  }
}

resource "aws_route" "nat_access" {
  route_table_id         = aws_route_table.nat.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main.id
}