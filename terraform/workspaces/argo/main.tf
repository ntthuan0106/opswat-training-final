module "eks" {
  source = "../../modules/eks"
  vpc_eks_name = "thuan-vpc-eks"
  cluster_name = "thuan-cluster"
  ami_id_name = "ami-0a31a5394d06e67d9"
  k8s_version = "1.32"
  node_group_name = "thuan-node-gr"

  desired_size = 2
  min_size = 0
  max_size = 10
  
  eks_addon_list = [
    { name = "vpc-cni", version = "v1.19.3-eksbuild.1" },
    { name = "coredns", version = "v1.11.4-eksbuild.2" },
    { name = "kube-proxy", version = "v1.32.0-eksbuild.2"  },
    { name = "metrics-server", version = "v0.7.2-eksbuild.2" },
    { name = "amazon-cloudwatch-observability", version = "v4.0.0-eksbuild.1"},
  ]
  AWS_ACCESS_KEY_ID = var.AWS_ACCESS_KEY_ID
  AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  
  DOCKER_EMAIL = var.DOCKER_EMAIL
  DOCKER_USERNAME = var.DOCKER_USERNAME
  DOCKER_PASSWORD = var.DOCKER_PASSWORD
  tag_env = "Deployment"
}