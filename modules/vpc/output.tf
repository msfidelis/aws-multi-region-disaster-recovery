output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [
    aws_subnet.public_subnet_1a.id,
    aws_subnet.public_subnet_1b.id,
    aws_subnet.public_subnet_1c.id,
  ]
}

output "private_subnets" {
  value = [
    aws_subnet.private_subnet_1a.id,
    aws_subnet.private_subnet_1b.id,
    aws_subnet.private_subnet_1c.id,
  ]
}