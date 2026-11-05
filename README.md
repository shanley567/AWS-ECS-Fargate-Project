# AWS ECS Fargate Project

## Overview

This project demonstrates the design, deployment, operation, monitoring, and troubleshooting of a containerised Python web application on AWS using modern DevOps and Site Reliability Engineering (SRE) practices.

The application is packaged as a Docker image, stored in Amazon Elastic Container Registry (ECR), and deployed to Amazon ECS Fargate behind an Application Load Balancer (ALB). Infrastructure is fully provisioned using Terraform and validated through GitHub Actions.

The project was created to validate the end-to-end process of deploying containerised workloads to ECS Fargate and operating them using production-style monitoring, scaling, security controls, and troubleshooting procedures.

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
- Operational Troubleshooting
- Site Reliability Engineering Principles

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
    ├── Docker Build Validation
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

Monitoring
    │
    ├── CloudWatch Logs
    ├── CloudWatch Dashboard
    ├── ECS Container Insights
    └── Auto Scaling Metrics
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
- ECS Service Metrics
- Application Load Balancer Metrics
- Auto Scaling Metrics

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

## Monitoring & Observability

A service-centric SRE dashboard has been implemented using Amazon CloudWatch.

The dashboard focuses on availability, performance, traffic, scaling, and service health.

### Dashboard Metrics

#### Service Health

- Running Tasks
- Pending Tasks
- Healthy Target Count
- Desired vs Running Tasks

#### Performance

- CPU Utilisation
- Memory Utilisation
- Target Response Time

#### Traffic

- Request Count

#### Reliability

- HTTP 4XX Errors
- HTTP 5XX Errors

### Operational Benefits

The dashboard is designed to answer:

1. Is the service healthy?
2. Is the service available?
3. Is the application receiving traffic?
4. Is ECS maintaining desired capacity?
5. Are users seeing errors?
6. Is application performance degrading?

This enables rapid diagnosis of issues such as:

- Failed deployments
- Missing ECR images
- Container startup failures
- Unhealthy ECS tasks
- Auto Scaling issues
- Load Balancer target failures

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

Response

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

Automatically performs:

- Terraform Format Validation
- Terraform Validation
- TFLint Analysis
- Checkov Security Scanning

### Application Workflow

Automatically performs:

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
- Read-Only Root Filesystem
- ECS Container Insights
- IAM Least-Privilege Execution Role
- Infrastructure Tagging Strategy
- GitHub Actions Validation

---

## Terraform Standards

All infrastructure resources inherit a common tagging strategy:

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
- [x] Route Tables
- [x] Security Groups
- [x] Application Load Balancer
- [x] Target Group
- [x] ECS Cluster
- [x] ECS Service
- [x] ECS Task Definition
- [x] Amazon ECR

### Monitoring & Observability

- [x] CloudWatch Dashboard
- [x] CloudWatch Logs
- [x] ECS Container Insights
- [x] ECS Service Metrics
- [x] ALB Metrics
- [x] Auto Scaling Metrics

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

✅ ECS Service healthy

✅ ECS Task healthy

✅ Application Load Balancer healthy

✅ Target Group healthy

✅ CloudWatch Monitoring enabled

✅ Container Insights enabled

✅ Auto Scaling configured

✅ Application accessible through ALB

---

## Key Lessons Learned

This project provided practical experience with:

- Terraform resource lifecycle management
- AWS networking
- ECS Fargate deployments
- ECR image management
- CloudWatch monitoring
- SRE dashboard design
- ECS rolling deployments
- Auto Scaling
- Container security hardening
- CI/CD validation pipelines
- Diagnosing ECS task failures
- Recovering from ECR repository replacement
- Understanding Terraform resource replacement impacts

---

## Future Enhancements

- [ ] HTTPS via ACM
- [ ] Route53 DNS Integration
- [ ] ALB Access Logging
- [ ] CloudWatch Alarms
- [ ] Secrets Manager Integration
- [ ] GitHub Actions ECS Deployment
- [ ] GitHub OIDC Authentication
- [ ] Blue/Green ECS Deployments

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

- docs/troubleshooting/ecr-image-recovery.md

Planned runbooks:

- ECS Service Unhealthy
- Terraform State Recovery
- GitHub Actions Failures
- ECS Deployment Failures