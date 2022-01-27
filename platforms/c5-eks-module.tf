module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.2.3"

  cluster_name = "${local.name}-${var.cluster_name}"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnets

  cluster_ip_family         = var.cluster_ip_family
  cluster_service_ipv4_cidr = var.cluster_service_ipv4_cidr
  cluster_version           = var.cluster_version

  iam_role_name        = "${local.name}-iam"
  iam_role_description = "IAM created by using EKS terraform module"

  eks_managed_node_groups = {
    # Replace with loop later; Adding more node group is easy then
    green = {
      min_size     = var.eks_managed_node_groups["green"].min_size
      max_size     = var.eks_managed_node_groups["green"].max_size
      desired_size = var.eks_managed_node_groups["green"].desired_size

      instance_types = var.eks_managed_node_groups["green"].instance_types
      capacity_type  = var.eks_managed_node_groups["green"].capacity_type
      labels         = var.eks_managed_node_groups["green"].labels

      update_config = {
        max_unavailable_percentage = var.eks_managed_node_groups["green"].update_config_max_ava
      }

      tags = local.common_tags
    }
  }

  # Extend node-to-node security group rules
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
}
