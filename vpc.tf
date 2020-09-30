module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc?ref=v2.47.0"

  name = "vpc-eks-${var.env}"

  cidr = var.cidr

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = var.private_subnets_cidr
  public_subnets  = var.public_subnet_cidr

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  public_subnet_tags = {
    "kubernetes.io/cluster/eks-${var.prefix}-${var.env}" = "shared"
    "kubernetes.io/role/elb"                             = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/eks-${var.prefix}-${var.env}" = "shared"
    "kubernetes.io/role/internal-elb"                    = "1"
  }
}