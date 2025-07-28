data "aws_iam_policy_document" "kms_key_policy" {
  statement {
    sid    = "EnableRootAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["${var.identifier_user}"]
    }

    actions = [
      "kms:*"
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowAWSSMK8sUserAccess"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        "${var.identifier_user}"
      ]
    }

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]

    resources = ["*"]
  }
}
resource "random_string" "random" {
  length  = 8
  special = false
}

resource "aws_kms_key" "kms_key" {
  description = "Postgres RDS key"
}
resource "aws_kms_key_policy" "secrets_kms_policy" {
  key_id = aws_kms_key.kms_key.id
  policy = data.aws_iam_policy_document.kms_key_policy.json
}
