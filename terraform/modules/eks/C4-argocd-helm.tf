resource "helm_release" "argo_cd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace = "argocd"
  create_namespace = true
  set {
    name= "config.secret.argocdServerAdminPassword"
    value = var.ARGO_ADMIN_PASSWORD
  }
  values = [file("${path.module}/values/argocd-values.yml")]
  force_update   = true
  recreate_pods  = true
  reuse_values = true

  depends_on = [
    aws_eks_cluster.cluster,
    aws_eks_node_group.EKS_node_group,
    aws_eks_addon.eks_addon
  ]
}