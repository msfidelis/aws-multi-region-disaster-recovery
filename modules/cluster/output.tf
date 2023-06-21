output "cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "private_zone" {
  value = aws_route53_zone.main.id
}

output "sg" {
  value = aws_security_group.main.id
}

output "alb_arn" {
  value = aws_lb.main.arn
}

output "nlb_arn" {
  value = aws_lb.vpc_link.arn
}

output "vpc_link" {
  value = aws_api_gateway_vpc_link.main.id
}

output "listener_arn" {
  value = aws_lb_listener.main.arn
}

output "kms_key" {
  value = aws_kms_key.main.arn
}

output "region" {
  value = data.aws_region.current.name
}