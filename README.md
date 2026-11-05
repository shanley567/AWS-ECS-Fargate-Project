# AWS ECS Fargate Project

## Overview

This project demonstrates the design, deployment, operation, and troubleshooting of a containerised Python web application on AWS using modern DevOps practices.

The application is packaged as a Docker image, stored in Amazon Elastic Container Registry (ECR), and deployed to Amazon ECS Fargate behind an Application Load Balancer (ALB). Infrastructure is provisioned and managed using Terraform, while GitHub Actions provides automated validation and security scanning.

The project also includes production-oriented monitoring, scaling, encryption, and operational troubleshooting documentation.

---

## Project Goals

This project demonstrates:

- Infrastructure as Code (Terraform)
- Continuous Integration (GitHub Actions)
- Containerisation (Docker)
- Amazon ECS Fargate
- Amazon ECR
- AWS Networking
- CloudWatch Monitoring
- ECS Auto Scaling
- Security Validation
- Cloud Infrastructure Troubleshooting

---

## Architecture

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
Amazon ECR
            │
            ▼
Amazon ECS Fargate
            │
            ▼
Application Load Balancer
            │
            ▼
End Users

ECS Platform
    │
    ├── CloudWatch Logs
    ├── CloudWatch Dashboard
    ├── Container Insights
    └── Auto Scaling Policies
```

---

## Current AWS Resources

### Compute

- Amazon ECS Cluster
- ECS Fargate Service
- ECS Task Definition
- ECS Task Execution Role

### Container Registry

- Amazon ECR Repository
- ECR Lifecycle Policy
- ECR Image Scanning
- Immutable Image Tags

### Networking

- VPC
- Internet Gateway
- Public Subnet A
- Public Subnet B
- Route Table
- Route Table Associations

### Load Balancing

- Application Load Balancer
- Target Group
- HTTP Listener

### Monitoring

- CloudWatch Log Group
- CloudWatch Dashboard
- ECS Container Insights

### Scaling

- ECS Auto Scaling Target
- Target Tracking Policy

### Security

- Security Groups
- IAM Execution Role
- CloudWatch Log Encryption (KMS)
- Read-Only Root Filesystem
- Checkov Security Scanning

---

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       ├── deploy.yml
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
├── docs/
│   └── troubleshooting/
│       └── ecr-image-recovery.md
│
├── terraform/
│   ├── alb.tf
│   ├── autoscaling.tf
│   ├── dashboard.tf
│   ├── ecr.tf
│   ├── ecr_lifecycle.tf
│   ├── ecs.tf
│   ├── iam.tf
│   ├── kms.tf
│   ├── locals.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── security_groups.tf
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

```powershell
python app.py
```

Navigate to:

```text
http://localhost:5000
```

---

### Run Tests

```powershell
pytest -v
```

---

### Build Docker Image

```powershell
docker build -t devops-ecs-demo .
```

---

### Run Docker Container

```powershell
docker run -p 5000:5000 devops-ecs-demo
```

Navigate to:

```text
http://localhost:5000
```

---

## Infrastructure Deployment

### Initialise Terraform

```powershell
terraform init
```

### Validate Configuration

```powershell
terraform validate
```

### Generate Plan

```powershell
terraform plan
```

### Apply Infrastructure

```powershell
terraform apply
```

### Destroy Infrastructure

```powershell
terraform destroy
```

---

## CI/CD Pipeline

### Terraform Validation Workflow

The infrastructure workflow automatically performs:

- Terraform Format Validation
- Terraform Validation
- TFLint Analysis
- Checkov Security Scanning

### Application Workflow

The application workflow automatically performs:

- Source Checkout
- Docker Build Validation
- Deployment Pipeline Validation

---

## Security Controls

Current controls include:

- Terraform Validation
- TFLint Best-Practice Checks
- Checkov Security Scanning
- ECR Image Scanning
- ECR Immutable Tags
- CloudWatch Log Encryption
- Read-Only Container Filesystem
- ECS Container Insights
- IAM Least-Privilege Execution Role
- Infrastructure Tagging Strategy
- GitHub Actions Validation

---

## Terraform Standards

All resources are tagged using shared Terraform locals.

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

- [x] Flask Application
- [x] Health Endpoint
- [x] Docker Containerisation
- [x] Pytest Unit Testing

### Infrastructure

- [x] AWS VPC
- [x] Public Subnets
- [x] Internet Gateway
- [x] Security Groups
- [x] Application Load Balancer
- [x] Target Group
- [x] ECS Cluster
- [x] ECS Service
- [x] ECS Task Definition
- [x] Amazon ECR
- [x] CloudWatch Logging

### Monitoring

- [x] CloudWatch Dashboard
- [x] ECS Container Insights

### Scaling

- [x] ECS Auto Scaling
- [x] Target Tracking Policy

### Security

- [x] ECR Image Scanning
- [x] ECR Immutable Tags
- [x] CloudWatch Log Encryption
- [x] Read-Only Root Filesystem
- [x] Checkov Integration

### CI/CD

- [x] GitHub Actions
- [x] Terraform Validation
- [x] TFLint Integration
- [x] Checkov Integration
- [x] Docker Build Validation

---

## Current Status

### Infrastructure Verification

✅ ECS Service deployed

✅ ECS Task healthy

✅ ALB healthy

✅ Target Group healthy

✅ CloudWatch Logs enabled

✅ CloudWatch Dashboard enabled

✅ ECS Container Insights enabled

✅ Auto Scaling configured

✅ Application accessible through ALB

---

### Verified Commands

```powershell
aws ecs describe-services
```

Result:

```text
runningCount = 1
```

---

```powershell
aws elbv2 describe-target-health
```

Result:

```text
healthy
```

---

Application response:

```json
{
  "service": "devops-ecs-demo",
  "status": "healthy"
}
```

---

## Key Lessons Learned

This project provided hands-on experience with:

- Terraform resource lifecycle management
- ECS Fargate deployments
- ECR image management
- CloudWatch monitoring
- ECS rolling deployments
- Container security hardening
- CI/CD validation pipelines
- Infrastructure troubleshooting
- Diagnosing ECS task failures
- Recovering from ECR repository replacement
- Analysing Terraform resource replacement impacts

---

## Future Enhancements

- [ ] HTTPS via ACM
- [ ] Route53 DNS Integration
- [ ] ALB Access Logging
- [ ] CloudWatch Alarms
- [ ] GitHub Actions ECS Deployment
- [ ] GitHub OIDC Authentication

---

## Technologies Used

### Cloud

- AWS
- ECS Fargate
- ECR
- CloudWatch
- IAM
- VPC
- Application Load Balancer

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

## Troubleshooting

Operational runbooks:

- [ECR Image Recovery](docs/troubleshooting/ecr-image-recovery.md)

Future runbooks:

- ECS Service Unhealthy
- Terraform State Recoveryures
- ECS Deployment Failures