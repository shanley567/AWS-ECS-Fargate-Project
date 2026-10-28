#################################################
# CloudWatch Log Group
#
# Stores container logs from ECS tasks.
#################################################

resource "aws_cloudwatch_log_group" "app" {

  name              = "/ecs/devops-ecs-demo"
  retention_in_days = 1

  tags = local.common_tags
}


#################################################
# ECS Cluster
#
# Logical container hosting platform.
#################################################

resource "aws_ecs_cluster" "main" {

  name = "devops-ecs-demo-cluster"

  tags = merge(
    local.common_tags,
    {
      Name = "devops-ecs-demo-cluster"
    }
  )
}


#################################################
# ECS Task Definition
#
# Defines how the container should run.
#################################################

resource "aws_ecs_task_definition" "app" {

  family                   = "devops-ecs-demo"
  requires_compatibilities = ["FARGATE"]

  network_mode = "awsvpc"

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {

      name = "devops-ecs-demo"

      image = "${aws_ecr_repository.app.repository_url}:latest"

      essential = true

      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]

      logConfiguration = {

        logDriver = "awslogs"

        options = {

          awslogs-group         = aws_cloudwatch_log_group.app.name
          awslogs-region        = "eu-north-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])

  tags = local.common_tags
}


#################################################
# ECS Service
#
# Maintains running Fargate tasks.
#################################################

resource "aws_ecs_service" "app" {

  name = "devops-ecs-demo-service"

  cluster = aws_ecs_cluster.main.id

  task_definition = aws_ecs_task_definition.app.arn

  desired_count = 1

  launch_type = "FARGATE"

  #################################################
  # Networking
  #################################################

  network_configuration {

    subnets = [
      aws_subnet.public_a.id,
      aws_subnet.public_b.id
    ]

    security_groups = [
      aws_security_group.ecs_tasks.id
    ]

    assign_public_ip = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "devops-ecs-demo-service"
    }
  )
}
