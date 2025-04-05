
provider "aws" {
  region = "ap-south-1"
}

variable "ecs_cluster_name" {
  default = "clustersssssss-2-1"
}

variable "security_group_ids" {
  type    = list(string)
}

variable "subnet_ids" {
  type    = list(string)
}

variable "vpc_id" {
  type = string
}

# # variable "ecs_cluster_name" {
# #   description = "The name of the ECS cluster"
# #   type        = string

# # }

# # variable "security_group_ids" {
# #   description = "The desired number of tasks to run in the ECS service"
# #   type        = number
# #   default     = 1
# # }

# # variable "vpc_id" {
# #   description = "The ID of the VPC where the ECS cluster will be deployed"
# #   type        = string
# #  # default     = Task.id  # Replace with your VPC ID
# # }

# # variable "subnet_ids" {
# #   description = "The list of subnet IDs where the ECS tasks will run"
# #   type        = list(string)
# #  # default = subnet_ids
# # }

# # variable "ecr_repository_url" {
# #   description = "The URL of the ECR repository where the Docker image is stored"
# #   type        = string
# # }

# # variable "security_group_id" {
# #     description = "The ID of the security group for the ECS tasks"
# #     type        =   string
# #   #  default     =   security_group_id
# #   # Replace with your security group ID
# # }

# # variable "ecs_cluster_name" {
# #   description = "The name of the ECS cluster"
# #   type        = string
# # }
# variable "aws_region" {
#   description = "The AWS region where the resources will be created"
#   type        = string
#   default     = "ap-south-1"  
# }

# variable "ecs_cluster_name" {
#   description = "ECS Cluster Name"
#   type        = string
#   default     = "cluster-1"
# }

# variable "vpc_id" {
#   description = "VPC ID"
#   type        = string
# }

# variable "subnet_ids" {
#   description = "Subnet IDs"
#   type        = list(string)
# }

# variable "security_group_ids" {
#   description = "Security Group IDs"
#   type        = list(string)
# }

# # variable "instance_profile_arn" {
# #   description = "IAM instance profile ARN"
# #   type        = string
# # }

# variable "key_name" {
#   description = "EC2 Key Pair name"
#   type        = string
#   default     = "Jenkin-master"
# }
