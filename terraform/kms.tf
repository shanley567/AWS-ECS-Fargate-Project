data "aws_caller_identity" "current" {}

#################################################
# ECR KMS Key
#
# Encrypts container images stored in ECR.
#################################################

resource "aws_kms_key" "ecr" {

  description = "KMS key for ECR repository encryption"

  deletion_window_in_days = 7

  tags = {
    Name = "devops-ecs-demo-ecr-kms"
  }
}

#################################################
# CloudWatch Logs KMS Key
#
# Encrypts ECS application logs.
#################################################

resource "aws_kms_key" "logs" {

  description = "KMS key for CloudWatch logs"

  deletion_window_in_days = 7

  enable_key_rotation = true

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      {
        Sid    = "EnableRootPermissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },

      {
        Sid    = "AllowCloudWatchLogs"
        Effect = "Allow"

        Principal = {
          Service = "logs.eu-north-1.amazonaws.com"
        }

        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]

        Resource = "*"
      }

    ]
  })

  tags = {
    Name = "devops-ecs-demo-logs-kms"
  }
}