variable "vpc_id" {}

variable "route53_zone" {}

variable "cluster_name" {}

variable "service_name" {}

variable "service_port" {}

variable "service_hostname" {
  type = list(any)
}

variable "service_subnets" {
  type = list(any)
}

variable "service_image" {}

variable "service_cpu" {}

variable "service_memory" {}

variable "desired_tasks" {}

variable "min_tasks" {}

variable "max_tasks" {}

variable "cpu_to_scale_up" {}

variable "cpu_to_scale_down" {}

variable "cpu_verification_period" {}

variable "cpu_evaluation_periods" {}

variable "service_launch_type" {}

variable "private_listener" {}

variable "service_healthcheck" {
  type = map(any)
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 10
    interval            = 60
    matcher             = "200"
    path                = "/healthcheck"
    port                = 8080
  }
}

variable "platform_version" {
  default = "LATEST"
}

