#################################################
# Default variable for AWS region
# 
# Can be overridden by providing a different 
# value when running Terraform commands.
#################################################
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-north-1"
}