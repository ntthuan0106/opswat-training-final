data "aws_eks_cluster" "eks" {
  name = aws_eks_cluster.cluster.name
  depends_on = [ aws_eks_cluster.cluster ]
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.cluster.name
  depends_on = [ aws_eks_cluster.cluster ]
}
# OIDC
data "tls_certificate" "oidc" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer
  depends_on = [ aws_eks_cluster.cluster ]
}

# ArgoCD-kms
data "aws_iam_policy_document" "argocd_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${replace(data.aws_eks_cluster.eks.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:argocd:argocd-repo-server"]
    }
  }
}

