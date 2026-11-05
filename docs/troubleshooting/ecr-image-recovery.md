
# ECR Image Recovery Runbook

## Overview

This document describes the recovery procedure when the ECS service becomes unhealthy because the required container image is missing from Amazon ECR.

This issue can occur when:

- Terraform recreates the ECR repository
- ECR images are manually deleted
- Terraform changes force ECR replacement (for example KMS encryption changes)
- Disaster recovery testing is performed
- A new AWS environment is provisioned

---

# Symptoms

## Application Unavailable

```powershell
curl http://<alb-dns-name>
```

Output:

```text
503 Service Temporarily Unavailable
```

---

## ECS Service Unhealthy

```powershell
aws ecs describe-services `
    --cluster devops-ecs-demo-cluster `
    --services devops-ecs-demo-service `
    --query "services[0].[desiredCount,runningCount,pendingCount]" `
    --output table
```

Example:

```text
Desired    Running    Pending
1          0          1
```

---

# Root Cause Investigation

## Verify ECR Contains Images

```powershell
aws ecr describe-images `
    --repository-name devops-ecs-demo
```

Failure condition:

```json
{
    "imageDetails": []
}
```

This indicates the repository exists but contains no container images.

---

## Check ECS Events

```powershell
aws ecs describe-services `
    --cluster devops-ecs-demo-cluster `
    --services devops-ecs-demo-service
```

Look for:

```text
CannotPullContainerError
```

Example:

```text
CannotPullContainerError:
failed to resolve ref
548722508417.dkr.ecr.eu-north-1.amazonaws.com/devops-ecs-demo:latest
not found
```

This confirms ECS cannot locate the container image.

---

# Recovery Procedure

## Step 1 - Navigate To Application Directory

```powershell
cd ..\app
```

---

## Step 2 - Build Local Docker Image

```powershell
docker build -t devops-ecs-demo .
```

Verify image creation:

```powershell
docker images
```

Expected:

```text
devops-ecs-demo
latest
```

---

## Step 3 - Authenticate Docker To ECR

```powershell
aws ecr get-login-password `
    --region eu-north-1 `
| docker login `
    --username AWS `
    --password-stdin 548722508417.dkr.ecr.eu-north-1.amazonaws.com
```

Expected output:

```text
Login Succeeded
```

---

## Step 4 - Tag Image For ECR

```powershell
docker tag `
    devops-ecs-demo:latest `
    548722508417.dkr.ecr.eu-north-1.amazonaws.com/devops-ecs-demo:latest
```

Verify tagging:

```powershell
docker images
```

Expected:

```text
devops-ecs-demo                                        latest

548722508417.dkr.ecr.eu-north-1.amazonaws.com/devops-ecs-demo
latest
```

---

## Step 5 - Push Image To ECR

```powershell
docker push `
    548722508417.dkr.ecr.eu-north-1.amazonaws.com/devops-ecs-demo:latest
```

Successful output should contain:

```text
latest: digest:
```

---

## Step 6 - Verify Image Exists In ECR

```powershell
aws ecr describe-images `
    --repository-name devops-ecs-demo
```

Expected:

```json
{
  "imageTags": [
    "latest"
  ]
}
```

---

## Step 7 - Force ECS Deployment

```powershell
aws ecs update-service `
    --cluster devops-ecs-demo-cluster `
    --service devops-ecs-demo-service `
    --force-new-deployment
```

This instructs ECS to pull the newly restored image.

---

## Step 8 - Monitor Deployment

```powershell
aws ecs describe-services `
    --cluster devops-ecs-demo-cluster `
    --services devops-ecs-demo-service `
    --query "services[0].[desiredCount,runningCount,pendingCount]" `
    --output table
```

Typical progression:

```text
1  0  1
```

↓

```text
1  2  0
```

↓

```text
1  1  0
```

---

# Explanation

## State 1

```text
Desired = 1
Running = 0
Pending = 1
```

ECS is attempting to start a replacement task.

---

## State 2

```text
Desired = 1
Running = 2
Pending = 0
```

Rolling deployment in progress.

The old task remains available while the replacement task passes health checks.

---

## State 3

```text
Desired = 1
Running = 1
Pending = 0
```

Deployment complete.

The new task is healthy and the old task has been terminated.

---

# Service Validation

Verify the load balancer endpoint:

```powershell
curl http://<alb-dns-name>
```

Expected:

```text
Hello from ECS Fargate
```

or the current application response.

---

# Lessons Learned

## Why This Happened

Terraform replaced the ECR repository because encryption settings changed.

Example:

```hcl
encryption_configuration {
  encryption_type = "KMS"
}
```

AWS does not permit in-place modification of ECR encryption settings.

Terraform therefore performs:

```text
Destroy ECR Repository
↓
Create New ECR Repository
```

All previously stored container images are removed.

---

# Future Improvements

- Use immutable image tags
- Deploy images using Git commit SHA tags
- Implement automated image redeployment after infrastructure rebuilds
- Add CI/CD deployment validation after Terraform changes

---

# Related Commands

## ECS Service Status

```powershell
aws ecs describe-services `
    --cluster devops-ecs-demo-cluster `
    --services devops-ecs-demo-service
```

## Running Tasks

```powershell
aws ecs list-tasks `
    --cluster devops-ecs-demo-cluster
```

## ECR Images

```powershell
aws ecr describe-images `
    --repository-name devops-ecs-demo
```

## Force Deployment

```powershell
aws ecs update-service `
    --cluster devops-ecs-demo-cluster `
    --service devops-ecs-demo-service `
    --force-new-deployment
```
