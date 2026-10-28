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


