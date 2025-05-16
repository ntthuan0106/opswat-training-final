resource "aws_iam_openid_connect_provider" "eks" {
  url = data.aws_eks_cluster.eks.identity[0].oidc[0].issuer

  client_id_list = ["sts.amazonaws.com"]

  thumbprint_list = [
    data.tls_certificate.oidc.certificates[0].sha1_fingerprint
  ]

  tags = {
    Name = "${var.cluster_name}-eks-oidc"
  }
}


# resource "aws_iam_role" "irsa_example" {
#   name = "${var.cluster_name}-example-irsa-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Federated = "${aws_iam_openid_connect_provider.eks.arn}"
#         },
#         Action = "sts:AssumeRoleWithWebIdentity",
#         Condition = {
#           StringEquals = {
#             "${replace(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://", "")}:sub" = "system:serviceaccount:your-namespace:your-serviceaccount"
#           }
#         }
#       }
#     ]
#   })

#   tags = {
#     Name = "${var.cluster_name}-example-irsa-role"
#   }
# }