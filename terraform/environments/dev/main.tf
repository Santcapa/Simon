module "app" {
  source = "../../modules/app"

  aws_region      = var.aws_region
  environment     = var.environment
  app_name        = var.app_name
  deployment_mode = var.deployment_mode
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  instance_type   = var.instance_type
  desired_count   = var.desired_count
}
