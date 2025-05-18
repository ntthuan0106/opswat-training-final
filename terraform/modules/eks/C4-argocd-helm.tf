resource "kubernetes_secret" "aws_argocd_secrets" {
  metadata {
    name = "aws-argocd-secret"
    namespace = "argocd"
  }

  data = {
    AWS_ACCESS_KEY_ID = var.AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY = var.AWS_SECRET_ACCESS_KEY
  }

  type = "Opaque"
  depends_on = [ 
    aws_eks_cluster.cluster,
  ]
}

resource "helm_release" "argo_cd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"

  namespace = "argocd"
  values = [file("${path.module}/values/argocd-values.yml")]
  force_update   = true
  recreate_pods  = true
  reuse_values = true

  depends_on = [
    aws_eks_cluster.cluster,
    aws_eks_node_group.EKS_node_group,
    aws_iam_role.argocd_kms_role,
    aws_iam_openid_connect_provider.eks,
  ]
}