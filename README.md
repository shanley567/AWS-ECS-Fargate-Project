# AWS ECS Fargate Project

## Overview

This project demonstrates how to build, test, containerize, and deploy a Python web application into AWS using modern DevOps practices.

The application is packaged as a Docker container, validated through automated testing, stored in Amazon Elastic Container Registry (ECR), and provisioned using Infrastructure as Code (Terraform).

The end goal is to deploy the application to AWS ECS Fargate behind an Application Load Balancer (ALB) with automated CI validation through GitHub Actions.

---

## Project Goals

This project demonstrates:

- Infrastructure as Code (Terraform)
- Continuous Integration (GitHub Actions)
- Python Application Testing (Pytest)
- Containerisation (Docker)
- Container Registry Management (Amazon ECR)
- AWS Networking Fundamentals
- Amazon ECS Fargate
- CloudWatch Logging
- Security Scanning and Validation

---

## Current Architecture

```text
GitHub
    │
    ▼
GitHub Actions
    │
    ├── Terraform Validation
    ├── TFLint
    ├── Checkov
    ├── Pytest
    └── Docker Build
            │
            ▼
Docker Image
            │
            ▼
Amazon ECR
            │
            ▼
Amazon ECS Cluster
            │
            ▼
CloudWatch Logs
```

---

## Current AWS Resources

### Container Platform

- Amazon ECR Repository
- Amazon ECS Cluster
- ECS Task Execution IAM Role
- CloudWatch Log Group

### Networking

- VPC
- Internet Gateway
- Public Subnet A
- Public Subnet B
- Public Route Table
- Route Table Associations

### Security

- IAM Execution Role
- Image Scanning Enabled in ECR
- Terraform Security Validation via Checkov

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── terraform.yml
│
├── app/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   ├── requirements-dev.txt
│   ├── compose.yaml
│   └── tests/
│
├── terraform/
│   ├── ecr.tf
│   ├── ecs.tf
│   ├── iam.tf
│   ├── locals.tf
│   ├── network.tf
│   ├── security_groups.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── variables.tf
│   └── versions.tf
│
├── README.md
└── notes.md
```

---

## Application

### Endpoint

#### GET /

Response:

```json
{
    "service": "devops-ecs-demo",
    "status": "healthy"
}
```

---

## Local Development

### Run Application

```bash
python app.py
```

Navigate to:

```text
http://localhost:5000
```

---

### Run Unit Tests

```bash
pytest -v
```

---

### Build Docker Image

```bash
docker build -t devops-ecs-demo .
```

---

### Run Docker Container

```bash
docker run -p 5000:5000 devops-ecs-demo
```

Navigate to:

```text
http://localhost:5000
```

---

## Infrastructure Deployment

### Initialise Terraform

```bash
terraform init
```

### Validate Configuration

```bash
terraform validate
```

### Generate Plan

```bash
terraform plan
```

### Apply Infrastructure

```bash
terraform apply
```

### Destroy Infrastructure

```bash
terraform destroy
```

---

## CI/CD Pipeline

### Terraform Infrastructure Validation

The Terraform pipeline automatically performs:

- Terraform Formatting Checks
- Terraform Validation
- TFLint Validation
- Checkov Security Scanning

### Application Validation

The application pipeline automatically performs:

- Python Dependency Installation
- Unit Testing via Pytest
- Docker Image Build Verification

---

## Security Controls

Current security controls include:

- Terraform Formatting Validation
- Terraform Static Analysis
- TFLint Best-Practice Checks
- Checkov Security Scanning
- ECR Image Scanning
- Least-Privilege ECS Execution Role
- Infrastructure Tagging Strategy
- GitHub Actions CI Validation

---

## Terraform Standards

All AWS resources are tagged automatically using shared Terraform locals.

Example:

```hcl
locals {
  common_tags = {
    Project     = "devops-ecs-demo"
    Environment = "lab"
    ManagedBy   = "terraform"
    Repository  = "AWS-ECS-Fargate-Project"
    Owner       = "James"
  }
}
```

---

## Features Completed

### Application

- [X] Flask Application
- [X] Health Endpoint
- [X] Docker Containerisation
- [X] Pytest Unit Testing

### CI/CD

- [X] GitHub Actions
- [X] Terraform Validation
- [X] TFLint Integration
- [X] Checkov Integration
- [X] Docker Build Validation

### AWS

- [X] Amazon ECR
- [X] Amazon ECS Cluster
- [X] CloudWatch Log Group
- [X] IAM Execution Role
- [X] VPC
- [X] Public Subnets
- [X] Internet Gateway
- [X] Route Tables

---

## Current Status

COMPLETED

[✓] GitHub Repository Created

[✓] Flask Application
      - / endpoint
      - returns healthy JSON response

[✓] Pytest Testing
      - endpoint tests
      - response tests

[✓] Docker
      - Dockerfile
      - local build
      - local run

[✓] GitHub Actions
      - Terraform Validation
      - TFLint
      - Checkov
      - Pytest
      - Docker Build

[✓] Amazon ECR
      - Repository created
      - Image pushed successfully

[✓] Networking
      - VPC
      - Internet Gateway
      - Public Subnet A
      - Public Subnet B
      - Route Table
      - Route Associations

[✓] CloudWatch Log Group

[✓] IAM ECS Task Execution Role

[✓] ECS Cluster

[✓] ECS Task Definition

[✓] ECS Service

[✓] ECS Security Group

[✓] ALB Security Group

[✓] Application Load Balancer

[✓] Target Group

[✓] Listener (HTTP:80)

[✓] ECS Service Registered With Target Group

[✓] Running Fargate Task

[✓] Target Health Check Healthy

[✓] Application Accessible Through ALB DNS

VERIFIED COMMANDS

aws ecs describe-services
runningCount = 1

aws elbv2 describe-target-health
State = healthy

ALB URL returns:
{
  "service": "devops-ecs-demo",
  "status": "healthy"
}

```PowerShell
terraform state list
aws_cloudwatch_log_group.app
aws_ecr_repository.app
aws_ecs_cluster.main
aws_ecs_service.app
aws_ecs_task_definition.app
aws_iam_role.ecs_task_execution_role
aws_iam_role_policy_attachment.ecs_task_execution
aws_internet_gateway.main
aws_lb.app
aws_lb_listener.http
aws_lb_target_group.app
aws_route_table.public
aws_route_table_association.public_a
aws_route_table_association.public_b
aws_security_group.alb
aws_security_group.ecs_tasks
aws_subnet.public_a
aws_subnet.public_b
aws_vpc.main

terraform output
alb_dns_name = "devops-ecs-demo-alb-1435200169.eu-north-1.elb.amazonaws.com"
ecr_repository_url = "548722508417.dkr.ecr.eu-north-1.amazonaws.com/devops-ecs-demo"
ecs_cluster_name = "devops-ecs-demo-cluster"
ecs_execution_role_arn = "arn:aws:iam::548722508417:role/devops-ecs-demo-task-execution-role"
ecs_service_name = "devops-ecs-demo-service"
public_subnet_a = "subnet-0949243a7e808960d"
public_subnet_b = "subnet-05241d52592db88b0"
task_definition_arn = "arn:aws:ecs:eu-north-1:548722508417:task-definition/devops-ecs-demo:1"
vpc_id = "vpc-0a92eaee848c1e55d"
```

NEXT PHASE

Phase 14 - Production Features

[ ] CloudWatch Dashboard
[ ] CloudWatch Alarms
[ ] ECS Auto Scaling
[ ] Target Tracking Policies
[ ] HTTPS via ACM
[ ] Route53 DNS
[ ] GitHub Actions ECS Deployment
[ ] OIDC Authenticatio

---

## Technologies Used

### Cloud

- AWS
- Amazon ECS
- Amazon ECR
- CloudWatch
- IAM
- VPC

### Infrastructure as Code

- Terraform

### Development

- Python
- Flask
- Pytest

### Containers

- Docker

### CI/CD

- GitHub Actions

### Security & Quality

- TFLint
- Checkov

---

## Learning Outcomes

This project demonstrates practical experience with:

- Infrastructure as Code
- CI/CD Pipeline Design
- Containerisation
- AWS Networking
- Cloud Security Validation
- Automated Testing
- ECS Architecture
- Cloud-Native Application Deployment

---

## Next Milestone

Expose the application through an Application Load Balancer.
