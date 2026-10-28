#################################################
# Application Load Balancer Security Group
#
# Allows HTTP access from the internet.
#################################################

resource "aws_security_group" "alb" {

  name        = "devops-ecs-demo-alb"
  description = "ALB security group"
  vpc_id      = aws_vpc.main.id

  #################################################
  # Allow HTTP From Internet
  #################################################

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  #################################################
  # Allow Outbound Traffic
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
      Name = "devops-ecs-demo-alb-sg"
    }
  )
}


#################################################
# Application Load Balancer
#
# Public entry point into the application.
#################################################

resource "aws_lb" "app" {

  name = "devops-ecs-demo-alb"

  internal = false

  load_balancer_type = "application"

  security_groups = [
    aws_security_group.alb.id
  ]

  subnets = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "devops-ecs-demo-alb"
    }
  )
}


#################################################
# Target Group
#
# Registers ECS tasks behind the ALB.
#################################################

resource "aws_lb_target_group" "app" {

  name = "devops-ecs-demo-tg"

  port     = 5000
  protocol = "HTTP"

  target_type = "ip"

  vpc_id = aws_vpc.main.id

  #################################################
  # Health Checks
  #
  # Calls:
  # GET /
  #################################################

  health_check {

    path = "/"

    protocol = "HTTP"

    matcher = "200"

    healthy_threshold = 2

    unhealthy_threshold = 2

    timeout = 5

    interval = 30
  }

  tags = local.common_tags
}