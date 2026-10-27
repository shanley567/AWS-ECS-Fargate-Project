# Containerised App Platform

### Tech Stack:

- Docker
- Containers
- ECS
- Load Balancing
- Container Deployements

### Build:

1. Github
2. Github Actions
3. Docker Image
4. ECR
5. ECS Fargate
6. Load Balancing
7. Python Web App

### This Demonstrates

- Containerisation
  - Dockerfile creation
  - image building
  - image optimisation
- Container Registry
  - ECR
  - Image versioning
  - lifecycle
- Container Orchestration
  - ECS
  - Task definitions
  - services
  - Fargate
- Networking
  - VPC
  - Subnets
  - Route Tables
  - Security Groups
- Availability
  - Application Load balancer
  - Health checks
  - Service Recovery
- IaC
  - Terraform
- CI/CD
  - Github actions
  - Docker Build
  - Quality Gates

### Tagging Stratergy

The following tags should be applied to every resource

```
tags = {
  Project     = "devops-ecs-demo"
  Environment = "lab"
  ManagedBy   = "terraform"
}
```

### Project Structure

```
AWS-ECS-Fargate-Project/

├── .github/
│   └── workflows/
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── terraform/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── docs/
│   └── architecture.drawio
│
└── README.md
```

### Project Delivery Phases

1. Application
   1. Build a small flask api app
2. Docker
   1. Build docker file and run locally
3. Terraform Networking
   1. Build the VPC
   2. Build 2 subnets in VPC
4. ECR
   1. Create repo
   2. Manually push first image
5. ECS Cluster
   1. Use fargate instead of EC2 instances
6. Task definition
   1. Deploy container
7. App Load balancing
   1. Create ALB with health checks
8. ECS Service
9. CI Pipeline
   1. Create usual workflow pipeline
10. Container testing
11. Cloud Watch
12. Autoscaling
