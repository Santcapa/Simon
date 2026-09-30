variable "aws_region" {
  description = "AWS region where the workload will be deployed."
  type        = string
}

variable "environment" {
  description = "Target environment name."
  type        = string
}

variable "app_name" {
  description = "Application name used to name resources."
  type        = string
}

variable "deployment_mode" {
  description = "Deployment type: ec2, ecs or eks."
  type        = string

  validation {
    condition     = contains(["ec2", "ecs", "eks"], var.deployment_mode)
    error_message = "deployment_mode must be one of: ec2, ecs, eks."
  }
}

variable "vpc_id" {
  description = "VPC identifier where the workload will be created."
  type        = string
}

variable "subnet_ids" {
  description = "Subnet ids to attach the workload to."
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 or EKS node instance type."
  type        = string
  default     = "t3.micro"
}

variable "desired_count" {
  description = "Desired number of instances/tasks."
  type        = number
  default     = 1
}

variable "container_image" {
  description = "Container image used by ECS and as a default app image."
  type        = string
  default     = "public.ecr.aws/docker/library/nginx:latest"
}
