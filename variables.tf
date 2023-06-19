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

variable "listener" {
  default = {
    port            = 80,
    protocol        = "HTTP",
    ssl_policy      = "",
    certificate_arn = ""
  }
}