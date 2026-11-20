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
    error_message = "Exactly two private subnets are required."
  }
}
variable "key_name" {
  description = "EC2 Key Pair name for SSH"
  type        = string
  default     = "much-to-do-key"
}
variable "allowed_ssh_cidr" {
  description = "Your IP for SSH"
  type        = string
  default     = "0.0.0.0/0"
}
variable "mongodb_username" {
  description = "MongoDB app username"
  type        = string
  default     = "admin"
}
variable "mongodb_password" {
  description = "MongoDB app password"
  type        = string
  sensitive   = true
  default     = "ChangeMe123!"
}
variable "mongodb_database" {
  description = "MongoDB database name"
  type        = string
  default     = "much-to-do"
}
