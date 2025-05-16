resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn
  vpc_config {
    subnet_ids = concat(
      aws_subnet.subnet_pub[*].id,
      )
    endpoint_public_access = true
  }
  version = var.k8s_version
  bootstrap_self_managed_addons = var.self_managed_addons
  tags = {
    Name = var.vpc_eks_name
    env = var.tag_env
  }
}

resource "aws_eks_node_group" "EKS_node_group" {
  cluster_name = aws_eks_cluster.cluster.name
  node_group_name = "${var.node_group_name}"

  subnet_ids = concat(
    aws_subnet.subnet_pub[*].id,
  )
  capacity_type = upper(var.node_group_capatity_type)

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }
  version = aws_eks_cluster.cluster.version
  instance_types = var.eks_instance_types
  node_role_arn  = aws_iam_role.node_group_role.arn
  
  tags = {
    Name = "${var.cluster_name}-node"
    env = var.tag_env
  }
}

resource "aws_eks_addon" "eks_addon" {
  for_each = { for addon in var.eks_addon_list : addon.name => addon }

  cluster_name  = aws_eks_cluster.cluster.name
  addon_name    = each.value.name
  addon_version = each.value.version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}