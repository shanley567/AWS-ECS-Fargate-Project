#################################################
# ECS Task Security Group
#
# Controls traffic to containers running in ECS.
#################################################

resource "aws_security_group" "ecs_tasks" {

  name        = "devops-ecs-demo-ecs-tasks"
  description = "Security group for ECS tasks"
  vpc_id      = aws_vpc.main.id

  #################################################
  # Inbound Traffic
  #
  # Allow access to the Flask application.
  #################################################

  ingress {

    description = "Allow HTTP traffic to Flask app"

    from_port = 5000
    to_port   = 5000

    protocol = "tcp"

    security_groups = [
      aws_security_group.alb.id
    ]
  }

  #################################################
  # Outbound Traffic
  #
  # Allow ECS tasks to access ECR, CloudWatch,
  # package repositories, DNS, etc.
  #################################################

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = merge(
    local.common_tags,
    {
      Name = "devops-ecs-demo-ecs-sg"
    }
  )
}
