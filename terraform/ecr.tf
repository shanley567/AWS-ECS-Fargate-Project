resource "aws_ecr_repository" "app" {

  name = "devops-ecs-demo"
  image_tag_mutability = "IMMUTABLE"
    encryption_configuration {

    encryption_type = "KMS"

    kms_key = aws_kms_key.ecr.arn
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  force_delete = true

  tags = local.common_tags
}