resource "aws_vpc" "main" {
  cidr_block            = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = format("%s-%s", var.project_name, data.aws_region.current.name)
  }
}