# EKS Cluster name
variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
  default     = "kube"
}

# EKS cluster IP family
variable "cluster_ip_family" {
  type        = string
  description = "Description: The IP family used to assign Kubernetes pod and service addresses. Valid values are `ipv4` (default) and `ipv6`. You can only specify an IP family when you create a cluster, changing this value will force a new cluster to be created"
  default     = "ipv4"
}

# EKS Cluster service's CIDR
variable "cluster_service_ipv4_cidr" {
  type        = string
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  default     = "172.20.0.0/16"
}

# EKS Cluster version
variable "cluster_version" {
  type        = string
  description = "Kubernetes `<major>.<minor>` version to use for the EKS cluster"
  default     = "1.21"
}

variable "eks_managed_node_groups" {
  type = map(object({
    min_size              = number
    max_size              = number
    desired_size          = number
    instance_types        = list(string)
    capacity_type         = string
    labels                = map(string)
    update_config_max_ava = number
  }))
  description = "Managed node group information"
  default = {
    "green" = {
      min_size       = 1
      max_size       = 10
      desired_size   = 3
      instance_types = ["t3.medium"]
      capacity_type  = "SPOT"
      labels = {
        Environment = "test"
        GithubRepo  = "terraform-aws-eks"
        GithubOrg   = "terraform-aws-modules"
      }
      update_config_max_ava = 50
    }
  }
}
