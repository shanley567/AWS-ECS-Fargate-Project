#################################################
# ECS Task Execution Role
#
# Allows ECS to:
# - Pull images from ECR
# - Write logs to CloudWatch
#################################################

resource "aws_iam_role" "ecs_task_execution_role" {

  name = "devops-ecs-demo-task-execution-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.common_tags
}


#################################################
# ECS Execution Policy
#
# Grants ECR and CloudWatch permissions.
#################################################

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {

  role = aws_iam_role.ecs_task_execution_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS Task Role
# Grants the ECS task permissions to access AWS services
resource "aws_iam_role_policy" "github_ecs_deploy" {

  name = "GitHubECSDeployPolicy"

  role = aws_iam_role.github_ecs_deploy.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "ecr:GetAuthorizationToken"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart",
          "ecr:BatchGetImage"
        ]

        Resource = aws_ecr_repository.app.arn
      },

      {
        Effect = "Allow"

        Action = [
          "ecs:UpdateService",
          "ecs:DescribeServices"
        ]

        Resource = "*"
      }
    ]
  })
}