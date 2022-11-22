## Makefile

Con un archivo makefile, se define un conjunto de tareas a ejecutar. Con este makefile, conseguimos un despliege de terraform creándose un bucket de almacenamiento en AWS .
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
	


1. Se crea clean para que elimine archivos innecesarios
2. Se inicia Terraform
3. Se crea la ejecución
4. Se aplica


Para instalar make, se pueden seguir las siguientes [instrucciones](https://linuxhint.com/install-make-ubuntu/)


Para que Terraform pueda crear el bucket en AWS, se tienen que configurar las [credenciales en AWS](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html),  para acceder a nuestra cuenta.


# Requisitos previos
Hay que asegurarse de que el sistema esté actualizado y tenga instalados los paquetes:
- gnupg, 
- software-properties-common
- curl.

Hay que asegurarse de tener las credenciales de aws configuradas correctamente en el directorio   "~/.aws/credentials".

Lo primero de todo es tener terraform [instalado](https://nksistemas.com/como-instalar-terraform-en-ubuntu-22-0420-04-18-04/) 

