######################################
# OpenID Connect (OIDC) allows GitHub Actions 
# to authenticate with AWS and 
# assume this role to deploy the ECS service.
######################################
resource "aws_iam_role" "github_ecs_deploy" {

  name = "GitHubECSDeployRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = "arn:aws:iam::548722508417:oidc-provider/token.actions.githubusercontent.com"
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:shanley567/AWS-ECS-Fargate-Project:*"
          }
        }
      }
    ]
  })
}