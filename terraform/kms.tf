#################################################
# ECR KMS Key
#
# Encrypts container images stored in ECR.
#################################################

resource "aws_kms_key" "ecr" {

  description             = "KMS key for ECR repository encryption"

  deletion_window_in_days = 7

  tags = {
    Name = "devops-ecs-demo-ecr-kms"
  }
}

#################################################
# CloudWatch Logs KMS Key
#
# Encrypts ECS application logs.
#################################################

resource "aws_kms_key" "logs" {

  description             = "KMS key for CloudWatch logs"

  deletion_window_in_days = 7

  tags = {
    Name = "devops-ecs-demo-logs-kms"
  }
}