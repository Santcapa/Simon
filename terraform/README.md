# Estructura Terraform para Simon

Este repositorio usa una estructura modular con:

- `modules/app`: módulo reutilizable para despliegues de aplicación
- `environments/dev`: configuración del ambiente de desarrollo
- `environments/prod`: configuración del ambiente de producción

## Patrones implementados

- Separación por entorno
- Módulo reutilizable para EC2, ECS y EKS
- Validación de variables por ambiente
- Soporte para deployment_mode: `ec2`, `ecs`, `eks`
- Security groups con reglas mínimas y acceso controlado
- Roles IAM con permisos alineados a un modelo Zero Trust

## Flujo recomendado

1. Validar cambios con `terraform fmt`, `terraform validate` y `terraform plan`
2. Ejecutar análisis de seguridad con `tfsec`, `checkov` o `trivy`
3. Revisión de pull request y aprobación manual para prod
4. `terraform apply` por ambiente
5. Verificación posdespliegue y drift detection

## Variables clave

- `deployment_mode`: define si la app va en EC2, ECS o EKS
- `aws_region`: región de despliegue
- `vpc_id`: VPC asociada
- `subnet_ids`: subredes del entorno
- `desired_count`: número de replicas/tasks

## Recomendación de seguridad

- Usar OIDC con GitHub Actions en lugar de access keys
- Mantener el estado remoto en S3 con bloqueo de DynamoDB
- No hardcodear credenciales ni secretos
- Usar IAM mínimo y roles de confianza
