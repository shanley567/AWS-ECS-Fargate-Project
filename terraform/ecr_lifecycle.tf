#################################################
# Remove untagged images from ECR
#
# Removes untagged images after 3 days
# to reduce storage costs
#################################################
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Delete untagged images after 7 days"

        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 3
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}