variable "project_name" {
  default = "disaster-recovery"
}

variable "vpc_cidr" {
  type = map(any)
  default = {
    us-east-1 = "10.0.0.0/16"
    sa-east-1 = "172.0.0.0/16"
  }
}

variable "public_subnet_1a" {
  type = map(any)
  default = {
    us-east-1 = "10.0.0.0/20"
    sa-east-1 = "172.0.0.0/20"
  }
}

variable "public_subnet_1b" {
  type = map(any)
  default = {
    us-east-1 = "10.0.16.0/20"
    sa-east-1 = "172.0.16.0/20"
  }
}

variable "public_subnet_1c" {
  type = map(any)
  default = {
    us-east-1 = "10.0.32.0/20"
    sa-east-1 = "172.0.32.0/20"
  }
}

variable "private_subnet_1a" {
  type = map(any)
  default = {
    us-east-1 = "10.0.48.0/20"
    sa-east-1 = "172.0.48.0/20"
  }
}

variable "private_subnet_1b" {
  type = map(any)
  default = {
    us-east-1 = "10.0.64.0/20"
    sa-east-1 = "172.0.64.0/20"
  }
}

variable "private_subnet_1c" {
  type = map(any)
  default = {
    us-east-1 = "10.0.80.0/20"
    sa-east-1 = "172.0.80.0/20"
  }
}

variable "route53_private_zone" {
  type    = string
  default = "mycompany.internal.com"
}

variable "listener" {
  default = {
    port            = 80,
    protocol        = "HTTP",
    ssl_policy      = "",
    certificate_arn = ""
  }
}

variable "route53_hosted_zone" {
  type    = string
  default = "Z102505525LUE9SZ7HWTY"
}

variable "route53_domain" {
  type    = string
  default = "msfidelis.com.br"
}

variable "api_gateway_domain" {
  type    = string
  default = "api.msfidelis.com.br"
}

variable "sales_sns_topic_name" {
  default = "sales-processing-topic"

}

variable "dynamodb_sales" {
  default = {
    name                   = "sales"
    billing_mode           = "PROVISIONED"
    point_in_time_recovery = true

    read_min                 = 10
    read_max                 = 60
    read_autoscale_threshold = 80

    write_min                 = 10
    write_max                 = 80
    write_autoscale_threshold = 90
  }
}

variable "dynamodb_idempotency" {
  default = {
    name                   = "sales"
    billing_mode           = "PROVISIONED"
    point_in_time_recovery = true

    read_min                 = 10
    read_max                 = 60
    read_autoscale_threshold = 80

    write_min                 = 10
    write_max                 = 80
    write_autoscale_threshold = 90
  }
}

variable "state" {
  type = map(any)
  default = {
    "sa-east-1" : "PASSIVE",
    "us-east-1" : "ACTIVE",
  }
}