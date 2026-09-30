variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_profile" {
  type    = string
  default = "default"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "app_name" {
  type    = string
  default = "simon-app"
}

variable "deployment_mode" {
  type    = string
  default = "ecs"
}

variable "vpc_id" {
  type    = string
  default = "vpc-12345678"
}

variable "subnet_ids" {
  type    = list(string)
  default = ["subnet-11111111", "subnet-22222222"]
}

variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "desired_count" {
  type    = number
  default = 2
}
