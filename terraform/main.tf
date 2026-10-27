resource "aws_ecr_repository" "app" {

  name = "devops-ecs-demo"

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = local.common_tags
}