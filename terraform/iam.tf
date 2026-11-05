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