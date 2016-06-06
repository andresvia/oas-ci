# oas-ci

## ¿Cómo utilizar esto?

### En un [OAS Workspace](https://github.com/andresvia/oas-workspace)

Simplemente ejecute:

```
sudo ./installer.sh
```

Para ver los últimos logs de los servicios iniciados vuelva a ejecutar:

```
sudo ./installer.sh
```

Las URL's en este caso son:

- Gogs: http://gogs.192.168.12.37.xip.io:3000/
- Drone: http://drone.192.168.12.37.xip.io:8000/

### Sin [OAS Workspace](https://github.com/andresvia/oas-workspace)

Simplemente ejecute:

```
vagrant up
```

Para ver los últimos logs de los servicios iniciados ejecute:

```
vagrant provision
```

Las URL's en este caso son:

- Gogs: http://gogs.192.168.12.212.xip.io:3000/
- Drone: http://drone.192.168.12.212.xip.io:8000/

## ¿Cómo configurar esto?

Espere un momento, el primer inicio puede tomar tiempo, ya que se están descargando todas las imágenes de Internet. Siga mirando los logs.

Esto significa que **ci-swarm-manage** está listo:

```
==> default: Jun 01 15:15:47 192.168.12.XXX.xip.io ci-swarm-manage-start[12108]: time="2016-06-01T19:15:47Z" level=info msg="Registered Engine 192.168.12.XXX.xip.io at 172.17.0.1:2376"
```

Esto significa que **gogs** está listo:

```
==> default: Jun 01 15:17:22 192.168.12.XXX.xip.io gogs-start[12160]: 2016/06/01 19:17:22 [I] Listen: http://0.0.0.0:3000
```

Y esto significa que **drone** está listo

```
==> default: Jun 01 15:16:49 192.168.12.XXX.xip.io drone-start[12135]: [GIN-debug]...
```

Luego visite la URL de Gogs en su navegador. Realice la instalación de Gogs, teniendo en cuenta que el puerto de escucha de SSH es 10022, utilice el FQDN del servidor para configurar todos los parámetros. Según pantallazo.

![pantallazo de instalación de gogs](http://i.imgur.com/EUNC4Bz.png)

Visite luego la URL de Drone, las credenciales a utilizar son las mismas de Gogs, luego conecte cualquier repositorio que haya creado en Gogs para comenzar a hacer integración contínua.

Lea la [documentación de Drone](http://readme.drone.io/).

## Paso a producción

Se necesita un servidor CentOS/7 con salida directa a Internet y con un nombre de DNS que se pueda resolver.

Lea el archivo `installer.sh` para replicar el procedimiento en un servidor real.

Lea la documentación de [oas-ci-server](https://github.com/andresvia/oas-ci-server) para conocer más detalles internos.
