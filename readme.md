# CICD Andrés Mínguez

## Inicio de la práctica.

El objetivo de esta práctica es montar un proyecto que nos pudoeramos encontrar en cualquier puesto de trabajo Devops.
En este caso, la empresa ACME quiere empezar a probar la nube, por lo que vamos a crear de manera totalmente automatizada unidades de almacenamiento en la nube (AWS S3)

Los requerimentos que nos ha dado ACME son los siguientes:

Quieren una unidad almacenamiento que se llamará acme-storage, será un bucket S3 de AWS
Quieren que el flujo de despliegue sea "Continuous Delivery" en la rama main, es decir, un administrador validará el comando de puesta en producción de la infraestructura
Sin embargo, en otras ramas distintas de main, el despliegue será "Continuous Deployment" y no habrá aprobación manual, será totalmente automático
Los desarrolladores de ACME han de poder hacer el despliegue también desde sus máquinas
Quieren que las credenciales para desplegar nunca estén guardadas en el código
Además ACME también quiere revisar cada 10 minutos que el contenido que hay en la unidad de almacenamiento no supera los 20MiB. Si esto pasa, se vaciará de manera automatizada
ACME lleva usando Jenkins mucho tiempo pero está actualmente abriéndose a probar nuevas teconologías con menor coste de gestión como Github Actions. Es por esto que también se requiere un pipeline de Github actions para el despliegue de la unidad de almacenamiento, de modo que ACME pueda comparar ambas tecnologías


En este proyecto se encuentran los siguientes entregables:

- Dockerfile: en esta carpeta nos econtramos:
    base.Dockerfile2 y t.Dockerfile, archivos para poder desplegar los agentes para Jenkins

- Github\Workflows, donde encontramos el archivo terraform.yaml, necesario para desplegar en AWS.

- Carpeta Jenkins, en la que encontraremos ficheros como jenkinsfile, necesarios para la creación de la base de datos

- Makefile, Con este makefile conseguimos un despliege de terraform creándose un bucket de almacenamiento en AWS 

- Carpeta de Terraform, en la que encontramos los main y provider, con los que creamos el bucket en  AWS y desplegamos la estructura en Terraform

- Joddsl,  correrá Jenkins para crear el job de despliegue


## MANUAL DE USUARIO


# Terraform:

Para comenzar la práctica, tenemos que tener creado un Bucket S3 en AWS. Para ello se pueden seguir las [instrucciones](https://docs.aws.amazon.com/AmazonS3/latest/userguide/create-bucket-overview.html)  


Para poder continuar con la practica, es necesario tener instalado [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) 



Con el archivo main.tf, creamos el bucket en AWS:
```sh
resource "aws_s3_bucket" "acme-storage-andres" {
  bucket = "acme-storage-andres"
}

resource "aws_s3_bucket_acl" "bucket-acl-andres" {
  bucket = "acme-storage-andres"
  acl    = "private"
}
```
Con el archivo provider.tf, desplegamos la estructura en Terraform:
```sh
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.34.0"
    }
  }
}
provider "aws" {
    region = "eu-west-1"
}
```

# Makefile:

Despliege de terraform creándose un bucket de almacenamiento en AWS. Este apartado tiene su propio readme
```sh
all: init plan apply clean

clean:
	cd .. && cd terraform && rm -fR terraform/ && rm -fR terraform.* && rm -fR .terraform.*

init:
	cd ../terraform && terraform init

plan:
	cd ../terraform && terraform plan

apply:
	cd ../terraform && terraform apply -auto-approve
```

# Jenkins  ![image](https://user-images.githubusercontent.com/86802349/203498956-efd38802-a80b-4f0d-b7c5-8d8cbae74072.png)


Este apartado nos sirve para la creación de la base de datos. Cuenta con su propio readme

# Github/workflows

En este apartado encontraremos el archivo terraform.yaml, un pipeline para implementar AWS S3 en GitHubActions.


Configuramos terraform con "hashicorp/setup-terraform@v2":

    name: Setup Terraform
    uses: hashicorp/setup-terraform@v2

Configuramos AWS Credentials para poder conectarnos:

    name: Setup AWS Credentials
    uses: aws-actions/configure-aws-credentials@v1
      
      with:
        aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
        aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
        aws-region: "eu-west-1"


Ahora paso a paso: 

Iniciamos terraform:

      name: Init
      run: terraform init
      working-directory: ./terraform

Ejecutamos:

      name: Plan
      run: terraform plan
      working-directory: ./terraform

 Aplicammos los cambios necesarios para la configuración, junto a auto-approve, para que no sea necesario confirmar nada

      name: Apply
      run: terraform apply -auto-approve
      working-directory: ./terraform

 Eliminamos todos los archivos que no nos hagan falta

      name: Clean
      run: rm -r .terraform/ && rm .terraform.* && rm terraform.*
      working-directory: ./terraform











  
