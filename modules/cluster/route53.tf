resource "aws_route53_zone" "main" {
  name = var.route53_private_zone

  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "main" {
  zone_id = aws_route53_zone.main.zone_id
  name    = format("*.%s", var.route53_private_zone)
  type    = "CNAME"
  ttl     = "30"
  records = [
    aws_lb.main.dns_name
  ]
}
