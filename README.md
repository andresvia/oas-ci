# oas-ci

Requiere [Vagrant](http://www.vagrantup.com/) reciente. Si esto no es una opción para usted pase directamente a la sección **Paso a producción (o instalación sin hipervisor)**.

## ¿Cómo utilizar esto?

Si se encuentra detrás de un proxy HTTP estos son algunos de los lugares donde hay que configurarlo:

```
sudo vim /etc/environment /etc/sysconfig/docker /etc/drone/dronerc /etc/gogs/gogsrc /etc/registry/registryrc /etc/registry/registryferc
```

De esta manera

```
http_proxy=...
https_proxy=...
HTTP_PROXY=...
HTTPS_PROXY=...
no_proxy=...
NO_PROXY=...
```

Y en estos archivos:

```
sudo vim /etc/profile.d/proxy.sh
```

Además de definir las variables se debe hacer:

```
export http_proxy
export https_proxy
export HTTP_PROXY
export HTTPS_PROXY
export no_proxy
export NO_PROXY
```

Ejemplo: Proxy UD.

```
http_proxy=http://10.20.4.15:3128
https_proxy=http://10.20.4.15:3128
HTTP_PROXY=http://10.20.4.15:3128
HTTPS_PROXY=http://10.20.4.15:3128
no_proxy=localhost,127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.udistrital.edu.co,.udistritaloas.edu.co
NO_PROXY=localhost,127.0.0.1,10.0.0.0/8,172.16.0.0/12,192.168.0.0/16,.udistrital.edu.co,.udistritaloas.edu.co
```

### Sin [OAS Workspace](https://github.com/andresvia/oas-workspace)

Simplemente ejecute el comando apropiado:

Para usar libvirt como proveedor utilice

```
vagrant plugin install vagrant-libvirt
vagrant up --provider libvirt
```

Para usar VirtualBox como proveedor, instale VirtualBox y utilice:

```
vagrant up --provider virtualbox
```

Para ver los últimos logs de los servicios iniciados ejecute:

```
vagrant ssh -c "bash" < scripts/logs
```

Las URL's en este caso son:

- [Gogs](http://192.168.12.212:3000/)
- [Drone](http://192.168.12.212:8000/)
- [Registry](http://192.168.12.212:5000/)
- [Registry Frontend](http://192.168.12.212:8080/)

### En un [OAS Workspace](https://github.com/andresvia/oas-workspace)

Advertencia: oas-workspace aún no ha sido suficientemente probado.

Simplemente ejecute:

```
sudo ./scripts/installer
```

Para ver los últimos logs de los servicios iniciados ejecute:

```
./scripts/logs
```

Las URL's en este caso son:

- [Gogs](http://192.168.12.37:3000/)
- [Drone](http://192.168.12.37:8000/)
- [Registry](http://192.168.12.37:5000/)
- [Registry Frontend](http://192.168.12.37:8080/)

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

Luego visite la URL de Gogs en su navegador. Realice la instalación de Gogs, teniendo en cuenta que el puerto de escucha de SSH es 10022, utilice la dirección del servidor (Dirección IP o FQDN que sea posible de resolver)

![pantallazo de instalación de gogs](http://i.imgur.com/EUNC4Bz.png)

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

## Paso a producción (o instalación sin hipervisor)

El paso a producción o la instalación sin hipervisor no es totalmente automático (pero se acerca bastánte) y requiere algunas habilidades de SysAdmin.

Se necesita un servidor CentOS/7 con salida directa a Internet.

Lea el archivo `scripts/installer` para replicar el procedimiento en servidores reales.

Si es un SysAdmin lea las documentaciones en:

  - [oas-ci-server](https://github.com/andresvia/oas-ci-server)
  - [oas-ci-agent](https://github.com/andresvia/oas-ci-agent)
  - [oas-ci-swarm-ca](https://github.com/andresvia/oas-ci-swarm-ca)

Para conocer más detalles internos.

## ¿Bugs?

Si encuentra un bug, cree un "issue" en este proyecto. La falta o errores de documentación también se considera un bug.
