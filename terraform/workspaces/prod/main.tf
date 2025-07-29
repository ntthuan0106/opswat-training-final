module "postgresql" {
    source = "../../modules/postgres"
    vpc_name = "postgres-vpc"

    db_name = "postgrestest"
    identifier = "postgres-thuan"
    DB_USERNAME = var.DB_USERNAME
    DB_PASSWORD = var.DB_PASSWORD

    kms_key_alias = "thuan"
    secret_name = "postgres-secret"
    parameter_group_name = "ps"

    publicly_accessible = true
    env = "prod"
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.11"

  cluster_name                   = "${local.name}"
  cluster_version                = "1.33"
  cluster_endpoint_public_access = true

  # Give the Terraform identity admin access to the cluster
  # which will allow resources to be deployed into the cluster
  enable_cluster_creator_admin_permissions = true

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni    = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    initial = {
      instance_types = ["t3.medium"]

      min_size      = 0
      max_size      = 2
      desired_size  = 2
      iam_role_name = "eksctl-thuan-istio-nodegroup-role"

    }
  }

  #  EKS K8s API cluster needs to be able to talk with the EKS worker nodes with port 15017/TCP and 15012/TCP which is used by Istio
  #  Istio in order to create sidecar needs to be able to communicate with webhook and for that network passage to EKS is needed.
  node_security_group_additional_rules = {
    ingress_15017 = {
      description                   = "Cluster API - Istio Webhook namespace.sidecar-injector.istio.io"
      protocol                      = "TCP"
      from_port                     = 15017
      to_port                       = 15017
      type                          = "ingress"
      source_cluster_security_group = true
    }
    ingress_15012 = {
      description                   = "Cluster API to nodes ports/protocols"
      protocol                      = "TCP"
      from_port                     = 15012
      to_port                       = 15012
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }
  create_iam_role = false

  create_kms_key = false
  cluster_encryption_config = {}
  attach_cluster_encryption_policy = false

  create_cloudwatch_log_group = false
}