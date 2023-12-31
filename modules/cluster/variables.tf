variable "cluster_name" {}

variable "subnets" {}

variable "vpc_id" {}

variable "route53_private_zone" {}

variable "ingress_rules" {}

variable "listener" {
  default = {
    port            = 80,
    protocol        = "HTTP",
    ssl_policy      = "",
    certificate_arn = ""
  }
}