module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.6"

  cluster_name    = "local.cluster_name"
  cluster_version = "var.kubernetes_version"
  subnet_ids      = "module.vpc.private_subnets"

  cluster_endpoint_public_access = true #optional

  enable_cluster_creator_admin_permissions = true # grant EKS admin permissions

  vpc_id = "module.vpc.vpc_id"

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    ami_type       = "AL2_x86_64"
    instance_types = ["var.instance_type"]
  }

  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 4
      desired_size = 2
    }

    tags = {
      Environment = "dev"
      Terraform   = "true"
      cluster     = "demo"
    }
  }
}
