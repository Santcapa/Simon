mock_provider "aws" {
  mock_data "aws_ami" {
    defaults = {
      id = "ami-0123456789abcdef0"
    }
  }
}

run "ec2_mode_uses_instance_output" {
  command = plan

  variables {
    aws_region      = "us-east-1"
    environment     = "dev"
    app_name        = "simon-app"
    deployment_mode = "ec2"
    vpc_id          = "vpc-12345678"
    subnet_ids      = ["subnet-11111111"]
    instance_type   = "t3.micro"
    desired_count   = 1
    container_image = "nginx:latest"
  }

  assert {
    condition     = output.deployment_mode == "ec2"
    error_message = "Debe quedar en ec2."
  }

  assert {
    condition     = output.security_group_id != ""
    error_message = "Debe crear el security group."
  }
}

run "eks_mode_uses_cluster_output" {
  command = plan

  variables {
    aws_region      = "us-east-1"
    environment     = "dev"
    app_name        = "simon-app"
    deployment_mode = "eks"
    vpc_id          = "vpc-12345678"
    subnet_ids      = ["subnet-11111111", "subnet-22222222"]
    instance_type   = "m5.large"
    desired_count   = 3
    container_image = "nginx:latest"
  }

  assert {
    condition     = output.deployment_mode == "eks"
    error_message = "Debe quedar en eks."
  }

  assert {
    condition     = output.eks_cluster_name == "simon-app-dev"
    error_message = "El cluster no tiene el nombre esperado."
  }
}
