locals {
  cluster_name = "eks-${var.prefix}-${var.env}"
}
module "eks" {
  source = "github.com/terraform-aws-modules/terraform-aws-eks?ref=v12.1.0"

  cluster_name = local.cluster_name
  subnets      = module.vpc.private_subnets
  vpc_id       = module.vpc.vpc_id

  write_kubeconfig = true
  enable_irsa      = true

  kubeconfig_aws_authenticator_command = "aws"

  kubeconfig_aws_authenticator_command_args = [
    "eks",
    "get-token",
    "--cluster-name",
    local.cluster_name
  ]

  kubeconfig_aws_authenticator_additional_args = []

  cluster_version           = "1.17"
  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  worker_groups_launch_template = [
    {
      name                 = "default-${var.aws_region}a"
      instance_type        = "t3.small"
      asg_min_size         = 1
      asg_max_size         = 3
      asg_desired_capacity = 1
      subnets              = [module.vpc.private_subnets[0]]
      autoscaling_enabled  = true
      root_volume_size     = 50
      tags = [
        {
          key                 = "CLUSTER_ID"
          value               = local.cluster_name
          propagate_at_launch = true
        },
        {
          key                 = "k8s.io/cluster-autoscaler/enabled"
          propagate_at_launch = "false"
          value               = "true"
        },
        {
          key                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
          propagate_at_launch = "false"
          value               = "true"
        }
      ]
    },
    {
      name                 = "default-${var.aws_region}b"
      instance_type        = "t3.small"
      asg_min_size         = 1
      asg_max_size         = 3
      asg_desired_capacity = 1
      subnets              = [module.vpc.private_subnets[1]]
      autoscaling_enabled  = true
      root_volume_size     = 50
      tags = [
        {
          key                 = "CLUSTER_ID"
          value               = local.cluster_name
          propagate_at_launch = true
        },
        {
          key                 = "k8s.io/cluster-autoscaler/enabled"
          propagate_at_launch = "false"
          value               = "true"
        },
        {
          key                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
          propagate_at_launch = "false"
          value               = "true"
        }
      ]
    },
    {
      name                 = "default-${var.aws_region}c"
      instance_type        = "t3.small"
      asg_min_size         = 1
      asg_max_size         = 3
      asg_desired_capacity = 1
      subnets              = [module.vpc.private_subnets[2]]
      autoscaling_enabled  = true
      root_volume_size     = 50
      tags = [
        {
          key                 = "CLUSTER_ID"
          value               = local.cluster_name
          propagate_at_launch = true
        },
        {
          key                 = "k8s.io/cluster-autoscaler/enabled"
          propagate_at_launch = "false"
          value               = "true"
        },
        {
          key                 = "k8s.io/cluster-autoscaler/${local.cluster_name}"
          propagate_at_launch = "false"
          value               = "true"
        }
      ]
    },
  ]
}