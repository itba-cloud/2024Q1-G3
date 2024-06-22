# Cloud computing

# Descripción #

Este proyecto implementa una arquitectura en AWS utilizando Terraform. La arquitectura incluye los siguientes componentes:

- Una VPC con 2 subnets privadas
- VPC Endpoints
- Un bucket S3
- CloudFront
- API Gateway
- DynamoDB
- 2 funciones Lambda: GET y POST

# Prerrequisitos #

- Tener instalado el CLI de AWS y configurado con las credenciales de la cuenta de AWS correspondiente en el archivo ~/.aws/credentials.
- Tener instalado Terraform.

#  Arquitectura #

La arquitectura se compone de los siguientes recursos:

- VPC y Subnets (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)

Una VPC con 2 subnets privadas para alojar los recursos de manera segura.

- VPC Endpoints (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)

VPC Endpoints para facilitar la conectividad con servicios de AWS sin salir de la red privada. Se utiliza el meta argumento count para escalar fácilmente la cantidad de VPC Endpoints. Actualmente hay 2 configurados, pero este enfoque permite agregar más endpoints en el futuro sin esfuerzo adicional.

- Bucket S3 (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

Un bucket S3 para el almacenamiento del Frontend (index.html) y el JavaScript (generated_script.js)

- CloudFront (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)
Una distribución de CloudFront para la entrega de contenido con baja latencia.

- API Gateway (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/api_gateway_rest_api)

Un API Gateway que se utiliza junto con depends_on para asegurarse de que todos los recursos necesarios estén creados antes de implementar el API Gateway.

- DynamoDB (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table)

Una tabla DynamoDB para almacenamiento de Vacuna_ID, name y Fecha.

- Funciones Lambda (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function)

Dos funciones Lambda, una para operaciones GET y otra para operaciones POST.

# Meta Argumentos Utilizados #

   - count

Utilizado para crear múltiples VPC Endpoints de manera rápida y escalable. Este enfoque permite agregar más endpoints en el futuro sin modificar significativamente el código.

   - lifecycle

Utilizado para prevenir la eliminación accidental de la VPC mediante la configuración del atributo prevent_destroy.

   - depends_on

Utilizado en el API Gateway para asegurarse de que todos los recursos dependientes estén creados antes de implementar el API Gateway.

# Funciones Utilizadas #

   - ![Funcion format()](./main.tf)

Crea una cadena formateada, en este caso, añade la ruta /vacunas al URL base de la API Gateway, module.api_gateway.api_url.

   - ![Funcion element()](./vpc_endpoint.tf)

Selecciona un elemento de la lista var.vpc_endpoints basado en el índice actual de count.index, permitiendo configurar cada instancia con un valor específico de la lista.

   - ![Funcion length()](./vpc_endpoint.tf)

Devuelve la cantidad de elementos en la lista var.vpc_endpoints, usada para definir cuántas instancias del recurso aws_vpc_endpoint se crearán.

   - ![Funcion templatefile()](./main.tf)

Utilizado para procesar archivos de plantilla en el archivo output.tf. Esta función permite insertar variables y generar contenido dinámico a partir de archivos de plantilla, facilitando la gestión de configuraciones complejas.


# MODULOS UTILIZADOS #

El trabajo se moduló de la siguiente manera:

![Modulo externo](./.terraform/modules/)

- El módulo de DynamoDB de Terraform AWS Modules permite crear y gestionar tablas DynamoDB con opciones de configuración avanzadas, incluyendo atributos, claves, índices globales y locales, así como capacidades de lectura y escritura. Este módulo también facilita la configuración de políticas de replicación y permite la integración con otras herramientas y servicios de AWS para optimizar el rendimiento y la seguridad de las tablas DynamoDB.

Link a la página oficial del módulo: ![Terraform Registry](https://registry.terraform.io/modules/terraform-aws-modules/dynamodb-table/aws/latest).

![Modulos custom-made](./modules/)

   ![Modulo API-Gateway](./modules/api_gateway/)

   - Configura un API Gateway que expone endpoints HTTP y los integra con funciones Lambda para procesar solicitudes GET y POST.

   ![Modulo Cloudfront](./modules/cloudfront/)

   - Configura una distribución de CloudFront para servir contenido estático desde un bucket S3 con acceso restringido y optimización de caché.

   ![Modulo Lambda](./modules/lambda/)

   - Despliega funciones Lambda empaquetadas en un archivo zip, configuradas con roles y runtime, además de redes y variables de entorno.

   ![Modulo Simple Storage Service](./modules/s3/)

   - Crea un bucket S3 configurado para hosting de un sitio web estático, con políticas de acceso y objetos iniciales.

   ![Modulo Subnets](./modules/subnets/)

   - Crea subredes privadas en distintas zonas de disponibilidad dentro de una VPC.

   ![Modulo VPC](./modules/vpc/)

   - Configura una VPC con un bloque CIDR especificado, incluye etiquetas, y gestiona la tabla de rutas predeterminada.




