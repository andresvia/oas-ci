# oas-ci

Requiere [Vagrant](http://www.vagrantup.com/) reciente. Si esto no es una opción para usted pase directamente a la sección **Paso a producción (o instalación sin hipervisor)**.

Para pruebas locales debe tener instalado [Git](https://git-scm.com/), [Docker](https://www.docker.com/) y [Drone CLI](http://readme.drone.io/devs/cli/). La instalación de estos no se cubre en este documento.

## ¿Cómo utilizar esto?

Simplemente ejecute el comando apropiado:

Para usar libvirt como proveedor utilice: (**Necesita 2GB de RAM libres y 1 vCPUS**)

```
vagrant plugin install vagrant-libvirt
vagrant up --provider libvirt && vagrant provision && vagrant reload
```

Para usar VirtualBox como proveedor, instale VirtualBox y utilice: (**Necesita 4GB de RAM libres y 2 vCPUS**)

```
vagrant up --provider virtualbox && vagrant provision && vagrant reload
```

Este proceso tarda aproximadamente **3 minutos y 50 segundos**.

Para ver los últimos logs de los servicios iniciados ejecute:

```
vagrant ssh -c "bash" < scripts/logs
```

Las URL's por defecto son:

- [Gogs](http://192.168.12.212:3000/)
- [Drone](http://192.168.12.212:8000/)
- [Registry Frontend](http://192.168.12.212:8080/)

## ¿Cómo configurar esto?

Espere un momento, el primer inicio puede tomar tiempo, ya que se están descargando todas las imágenes de Internet. Siga mirando los logs.

Esto significa que **ci-swarm-manage** está listo:

```
/usr/bin/docker-current start --attach=true ci-swarm-manage
```

Esto significa que **gogs** está listo:

```
/usr/bin/docker-current start --attach=true gogs
```

Esto significa que **drone** está listo

```
/usr/bin/docker-current start --attach=true drone
```

Esto significa que **registry** está listo

```
/usr/bin/docker-current start --attach=true registry
```

Esto significa que **registry-frontend** está listo

```
/usr/bin/docker-current start --attach=true registry-frontend
```

Luego visite la URL de Gogs en su navegador. Realice la instalación de Gogs, teniendo en cuenta que el puerto de escucha de SSH es 10022 y la dirección o nombre del host.

![pantallazo de instalación de gogs](http://i.imgur.com/5d8lsSP.png)

Visite luego la URL de Drone, (las credenciales a utilizar son las mismas de Gogs), luego conecte cualquier repositorio que haya creado en Gogs para comenzar a hacer integración contínua.

Lea la [documentación de Drone](http://readme.drone.io/).

## Solución de problemas

Si el proveedor es VirtualBox se tratarán de ubicar 4GB de RAM para la máquina virtual. Si esto representa un problema para tu setup ejecuta lo siguiente antes del comando `vagrant up`:

```
export OAS_CI_VBOX_MEMORY=XXXX
```

Dónde XXXX es la cantidad de memoria que se ubicará para la máquina virtual (en MBs).

Si el proveedor es libvirt se tratarán de ubicar 2GB de RAM para la máquina virtual. Si esto representa un problema para tu setup ejecuta lo siguiente antes del comando `vagrant up`:

```
export OAS_CI_LIBVIRT_MEMORY=XXXX
```

Dónde XXXX es la cantidad de memoria que se ubicará para la máquina virtual (en MBs).

Si utiliza un proxy web, estas direcciones deben estar en la lista de exlusión:

```
10.0.2.15
172.17.0.1
192.168.12.212
```

Si hay problemas de descarga (por ejemplo por estar destrás de un proxy) asegurar que los archivos necesarios fueron cambiados, es decir que las variables fueron pasadas del OS host al OS guest.

Los archivos cambiados para este propósito son:

```
/etc/environment
/etc/sysconfig/docker
```

Estos archivos son cambiados automáticamente tomando las variables del entorno actual con los siguientes comandos.

```
vagrant provision # para hacer el aprovisionamiento de dichos archivos, por ejemplo al cambiar de un ambiente con proxy a uno sin proxy
vagrant reload    # para asegurar que todos los servicios leen dichos archivos con los nuevos valores
```

## Paso a producción (o instalación sin hipervisor)

El paso a producción o la instalación sin hipervisor no es totalmente automático (pero se acerca bastánte) y requiere algunas habilidades de SysAdmin.

Se han probado los paquetes en un servidor CentOS/7.

Lea el archivo `scripts/installer` para replicar el procedimiento en servidores reales.

Lea las documentaciones en:

  - [oas-ci-server](https://github.com/andresvia/oas-ci-server)
  - [oas-ci-agent](https://github.com/andresvia/oas-ci-agent)
  - [oas-ci-swarm-ca](https://github.com/andresvia/oas-ci-swarm-ca)

Para conocer más detalles internos.

## ¿Bugs?

Si encuentra un bug, cree un "issue" en este proyecto. La falta o errores de documentación también se considera un bug.
