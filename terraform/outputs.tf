output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}


output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_a" {
  value = aws_subnet.public_a.id
}

output "public_subnet_b" {
  value = aws_subnet.public_b.id
}


#################################################
# ECS Cluster Name
#################################################

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

#################################################
# ECS Task Execution Role ARN
#################################################

output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}