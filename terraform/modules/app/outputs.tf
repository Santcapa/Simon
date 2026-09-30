output "application_name" {
  description = "Name of the application stack."
  value       = local.name
}

output "deployment_mode" {
  description = "Selected deployment model."
  value       = var.deployment_mode
}

output "security_group_id" {
  description = "Security group created for the app."
  value       = aws_security_group.main.id
}

output "ec2_instance_id" {
  description = "EC2 instance ID when deployment_mode is ec2."
  value       = try(aws_instance.app[0].id, null)
}

output "ecs_cluster_name" {
  description = "ECS cluster name when deployment_mode is ecs."
  value       = try(aws_ecs_cluster.app[0].name, null)
}

output "eks_cluster_name" {
  description = "EKS cluster name when deployment_mode is eks."
  value       = try(aws_eks_cluster.app[0].name, null)
}
