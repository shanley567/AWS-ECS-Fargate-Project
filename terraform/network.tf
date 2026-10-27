# Created vpc resource for the devops-ecs-demo project
resource "aws_vpc" "main" {

  cidr_block = "10.0.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    local.common_tags,
    {
      Name = "devops-ecs-demo-vpc"
    }
  )
}

# Created internet gateway resource for the devops-ecs-demo project
resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "devops-ecs-demo-igw"
    }
  )
}