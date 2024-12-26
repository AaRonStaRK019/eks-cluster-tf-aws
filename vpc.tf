provider "aws" {
  region = var.aws_region
}

data "aws_availability_zones" "available" {}

locals {
    cluster_name = "stark-eks-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 5
  special = false
  upper = false
}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

#   enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
