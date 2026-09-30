1. Cuentame un pipeline real que hayas construido de punta a punta
R:
He construido diferentes tipos de pipelines, principalmente orientados a infraestructura como codigo, despliegues de aplicaciones y automatizacion de procesos operativos.
Uno de los mas completos fue un pipeline para desplegar infraestructura con Terraform. El pipeline utilizaba un template reutilizable que contenia la logica comun del proceso, como validaciones, consumo de librerias y ejecucion de las diferentes acciones de Terraform.
El flujo iniciaba con la validacion del codigo y posteriormente ejecutaba procesos como terraform validate, revision de cambios y generacion del terraform plan. Tambien incorporaba validaciones de seguridad y quality gates.
Para ambientes controlados teniamos environments con aprobacion, de manera que un cambio pudiera ser revisado antes de ejecutar el terraform apply sobre ambientes sensibles como produccion.
Tambien incorporamos validaciones de drift, para detectar diferencias entre el estado administrado por Terraform y los recursos que realmente existian en AWS.
Ademas de pipelines de Terraform, he trabajado en pipelines para procesos de exportacion de datos CRUD, pipelines para desplegar aplicaciones y conectarse a clusters de Kubernetes y pipelines que monitorean imagenes en ECR o Docker Hub para posteriormente replicar capas hacia otros repositorios. En estos ultimos utilizabamos matrices para ejecutar procesos en paralelo y reducir los tiempos de ejecucion.
En general, mi enfoque ha sido tratar los pipelines como componentes reutilizables, con controles de seguridad, aprobaciones y automatizacion, y no simplemente como una secuencia de comandos.

2. ¿Que has desplegado en AWS con Terraform?
R:
He trabajado bastante con Terraform para AWS y Azure (medio), tanto consumiendo modulos existentes como creando y refactorizando modulos desde cero.
He trabajado con recursos y arquitecturas relacionadas con EKS, ECS, EC2, Lambda, DynamoDB, API Gateway, IAM, S3, OpenSearch, redes y componentes de networking, alertamiento y observabilidad.
Tambien he trabajado con manifiestos de Kubernetes desde Terraform, integracion con Helm y providers externos, por ejemplo Azure DevOps.
En algunos casos el trabajo no era solamente crear recursos, sino construir modulos reutilizables y refactorizar modulos existentes para hacerlos mas mantenibles y estandarizados.
Tambien he trabajado en correccion de errores sobre modulos existentes y en la implementacion de infraestructura siguiendo patrones reutilizables para diferentes equipos y ambientes.

3. ¿Como integrabas GitHub con AWS?
R:
Principalmente mediante pipelines de GitHub Actions y autenticacion contra AWS utilizando mecanismos federados, evitando depender de access keys estaticas cuando era posible.
El flujo normalmente era que un evento en GitHub, como un push o un pull request, disparaba un workflow. El workflow ejecutaba las validaciones correspondientes y posteriormente asumia un rol de IAM en AWS para ejecutar las operaciones necesarias.
Para Terraform, por ejemplo, GitHub Actions podia ejecutar plan en el pull request y, despues de las aprobaciones correspondientes, ejecutar apply sobre el ambiente autorizado.
La integracion tambien podia involucrar ECR, ECS, EKS, S3 u otros servicios de AWS dependiendo del pipeline.

4. ¿Que controles de seguridad metias en el pipeline?
R:
Dependiendo del proyecto, incorporaba diferentes quality gates y controles de seguridad.
Por ejemplo:
SAST para analizar vulnerabilidades en el codigo.
Trivy para analisis de vulnerabilidades, especialmente en imagenes y componentes.
Checkov para revisar configuraciones de Infrastructure as Code.
tfsec para detectar problemas de seguridad en Terraform.
SonarQube/Sonar para analisis estatico y calidad de codigo.
Validaciones de Terraform.
Revision del terraform plan.
Aprobaciones para ambientes sensibles.
Restricciones de permisos mediante IAM.

5. Diferencia entre integracion continua, entrega continua y despliegue continuo
R:
CI se enfoca en integrar y validar cambios y CD el despliegue de ese codigo esperando aprobacion.

6. ¿Que etapas minimas tendria un pipeline serio para Terraform en GitHub?

1. Checkout
2. Terraform Format / dependencias
3. Init
4. Validate
5. Security
Checkov
tfsec
Trivy
6. Plan
7. Approval
8. Apply
9. Validacion posterior


7. ¿Que mejorarias donde cualquier developer puede hacer merge a main y disparar apply directo a AWS?
R:
Paso 1 — Branch protection
Paso 2 — reviewers
Paso 3 — Bul validations -> Quality gates

8. ¿Que entiendes por payload?

Un payload es la informacion que se envia a la fuente destino.
por ejm, payload para soap, o por ejm payload en github para procesos de repository o branch

9. Si un push a una rama debe disparar un despliegue en AWS, ¿como lo implementarias?
R:
Por ejm con GitHub Actions:

on:
  push:
    branches:
      - main


10. ¿Que riesgos hay si GitHub Actions usa access keys estaticas?
R:
Pueden filtrarse.
Pueden quedar expuestas en logs por una mala configuracion.
Pueden ser copiadas.
Pueden tener permisos excesivos.
Son credenciales de larga duracion.
Hay que rotarlas.
Si alguien obtiene la key, puede utilizarla fuera de GitHub.

Nota: es mejor OIDC
11. Diferencia entre webhook, runner y workflow
R:
Webhook: Es un mecanismo de notificacion.
Workflow: Es la definicion del proceso que debe ejecutarse.
Runner: Es la maquina donde se ejecuta realmente el workflow.

12. Terraform validate vs plan vs apply
R:
terraform validate: Comprueba si la configuracion es valida.
terraform plan: Compara lo que tienes definido con el estado actual y muestra los cambios propuestos.
terraform apply: Aplica la infra en el target (nube, onpremise....
)
13. ¿Como manejarias state remoto en AWS?
R: Usaria un backend remoto en S3 para AWS o un Vault

14. ¿Como organizarias Terraform para dev, qa y prod?
R:
Una estructura posible:

terraform/
├── modules/
│   ├── eks/
│   ├── vpc/
│   ├── ecs/
│   └── dynamodb/
│
└── environments/
    ├── dev/
    ├── qa/
    └── prod/

otra son workspace

15. ¿Que harias para evitar drift o cambios manuales en AWS?
R:

1. Reducir permisos humanos para modificar infraestructura directamente.
2. Drift detection
3. Remediacion = Si ya paso el drif antes de tener permisos

16. ¿Que mala practica ves en un solo repositorio con variables mezcladas de todos los ambientes y sin aprobacion?

R: El problema es que aumenta el riesgo de modificar el ambiente incorrecto.

17. Diferencia ECS, EKS y EC2. Dame tu punto de vista personal
R: 

Si solamente necesito ejecutar contenedores, primero evaluaria ECS. Si necesito capacidades especificas del ecosistema Kubernetes, multiples workloads complejos o estandarizacion alrededor de Kubernetes, evaluaria EKS. EC2 lo reservaria para casos donde necesito mayor control del sistema operativo o donde la carga no encaja bien con el modelo de contenedores.

18. ¿Cuando escogerias ECS en vez de EKS?
R:
La aplicacion ya esta containerizada.
No necesito Kubernetes.
Quiero reducir overhead operacional.
El equipo no necesita el ecosistema Kubernetes.
La arquitectura es relativamente sencilla.

19. ¿Cuando si justificarias EKS?
R:
multiples microservicios
necesidades avanzadas de scheduling
operadores de Kubernetes
Helm
CRDs
ecosistema Kubernetes
workloads heterogeneos

20. ¿Cuando una carga deberia quedarse en EC2 y no en contenedores?
R:
aplicaciones legacy
software muy acoplado al sistema operativo
necesidades especiales de kernel
aplicaciones stateful dificiles de containerizar
software que requiere instalacion especifica sobre el host
workloads que necesitan control muy especifico de la maquina

21. ¿Que es una Task Definition en ECS?
R: Es basicamente la definicion de como debe ejecutarse un contenedor(imagen, cpu, memoria, port, env...)

22. ¿Que hace un Service en ECS?

R;Mantiene un numero deseado de Tasks ejecutandose.

23. Diferencia entre escalar EC2 y ECS

R: Depende ec2 basicamente es montar mas computo o repontelizar las maquinas, en ecs puede ser fargate que es disponibilizado nuevos services o el computo directamente

24. ¿Que es Target Tracking Scaling?

R:Es una estrategia de autoscaling basada en mantener una metrica alrededor de un objetivo. (CPU target = 60%)

25. En EKS, ¿como escala el cluster?

R: HPA(micros), Karpenter, Cluster Autoscaler (nodos)

Aqui puedes tener mecanismos como:

26. ¿Que metrica usarias para escalar una API?

R:
CPU
Memory
request rate
Latency

27. ¿Que significa DevSecOps? Explicaselo a alguien que no maneja tecnologia

R: incorporar seguridad durante todo el proceso de desarrollo y despliegue, en lugar de revisar la seguridad solamente al final.

28. ¿Que controles de seguridad meterias en Terraform?
1. Checkov
2. tfsec
3. Trivy
4. IAM Least Privilege
No guardar:
passwords
AWS keys
tokens

7. Pull Request approval
Revision antes de infraestructura sensible.

8. Terraform plan
Revision del cambio antes de aplicar.

29. ¿Que es Zero Trust?

R:Zero Trust es un modelo de seguridad basado en no confiar automaticamente en una identidad, dispositivo o red, basicamente es siempre verificar.

30. ¿Como aplicarias Zero Trust en AWS?

R:Roles en lugar de credenciales permanentes, MFA, segmentaciones de redes, esqueleto de red correcto, loggin, integraciones con OIDC en su mayoria, privilegio minimo en permisos

31. ¿Abrir puerto 22 a Internet encaja con Zero Trust?
R: Es mas recomendable SSM


32. Diferencia entre estar autenticado y estar autorizado
R: Se puede ver de la siguiente manera por ejm Autenticacion (Soy Santiago) y Autorizacion es que puede hacer santiago