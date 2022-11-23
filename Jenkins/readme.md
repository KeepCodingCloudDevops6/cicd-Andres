## Configuracion de jenkins

Una vez tenemos la instancia de AWS creada:

1. Se crean los script de provisioning. 

2. Se ejecuta el primer script, se genera una clave de acceso, que tendremos que pegar en nuestro github, en el apartado de ssh key.

3. Reiniciamos la máquina y ejecutamos el segundo script.
Una vez ejecutado, en la consola nos mostrará la clave de jenkins que nos ha generado.

4. En nuestra instancia de AWS, tendremos que coger la Public IPv4 address, para que en el navegador, se nos abra Jenkins, el cual nos pedirá la clave generada en el script anterior.

5. Instalar los siguientes plug in:
```sh
Docker, Docker plugin, Docker Pipeline, AnsiColor, Git, GitHub Plugin, Build Timeout, Job DSL, SSH Agent Plugin, Pipeline, Timestamper, Folders
```    

6. Configurar la contraseña que Jenkins va a utilizar para conectar con los agents.

7. Creamos un pipeline con variables de entorno en las que metemos las credenciales de AWS. Esto lo hacemos para que Jenkins concecte con nuestro AWS y poder desplegar los recursos.
