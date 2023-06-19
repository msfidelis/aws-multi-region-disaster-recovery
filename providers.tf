provider "aws" {
  alias  = "primary"
  region = "sa-east-1"
}

provider "aws" {
  alias  = "disaster-recovery"
  region = "us-east-1"
}