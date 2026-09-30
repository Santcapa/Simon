mock_provider "aws" {
  mock_data "aws_ami" {
    defaults = {
      id = "ami-0123456789abcdef0"
    }
  }
}

run "valid_ecs_config" {
  command = plan

  variables {
    aws_region      = "us-east-1"
    environment     = "dev"
    app_name        = "simon-app"
    deployment_mode = "ecs"
    vpc_id          = "vpc-12345678"
    subnet_ids      = ["subnet-11111111", "subnet-22222222"]
    instance_type   = "t3.micro"
    desired_count   = 2
    container_image = "nginx:latest"
  }

  assert {
    condition     = output.deployment_mode == "ecs"
    error_message = "Debe quedar en ecs."
  }

  assert {
    condition     = output.ecs_cluster_name == "simon-app-dev"
    error_message = "El cluster no tiene el nombre esperado."
  }
}

run "invalid_deployment_mode_fails" {
  command = plan

  variables {
    aws_region      = "us-east-1"
    environment     = "prod"
    app_name        = "simon-app"
    deployment_mode = "lambda"
    vpc_id          = "vpc-12345678"
    subnet_ids      = ["subnet-11111111", "subnet-22222222"]
    instance_type   = "t3.small"
    desired_count   = 2
    container_image = "nginx:latest"
  }

  expect_failures = [var.deployment_mode]
}
