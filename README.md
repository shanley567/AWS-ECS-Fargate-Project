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

### Completed

✅ Flask Application

✅ Docker Containerisation

✅ Pytest Testing

✅ GitHub Actions CI Pipeline

✅ Amazon ECR

✅ Amazon ECS Cluster

✅ VPC Networking

✅ CloudWatch Logging

### In Progress

🚧 ECS Task Definition

🚧 ECS Service

🚧 Security Groups

### Planned

📋 Application Load Balancer

📋 ECS Auto Scaling

📋 HTTPS via ACM

📋 Route53 DNS

📋 GitHub OIDC Authentication

📋 Automated Container Deployment

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

Deploy the first running ECS Fargate task using the Docker image stored in Amazon ECR, then expose the application through an Application Load Balancer.
