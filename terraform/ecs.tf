#################################################
# CloudWatch Log Group
#
# Stores container logs from ECS tasks.
#################################################

resource "aws_cloudwatch_log_group" "app" {

  name              = "/ecs/devops-ecs-demo"
  retention_in_days = 2

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