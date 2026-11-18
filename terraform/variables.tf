variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Two public subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Exactly two public subnets are required."
  }
}

variable "private_subnet_cidrs" {
  description = "Two private subnets, one per AZ"
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
  validation {
    condition     = length(var.private_subnet_cidrs) == 2
    error_message = "Exactly two private subnets are reqiured."
  }
}