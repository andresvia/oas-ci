# oas-ci

## ¿Cómo utilizar esto?

Simplemente ejecute:

```
vagrant up
```

Para ver los últimos logs de los servicios iniciados ejecute:

```
vagrant provision
```

Espere un momento, el primer inicio puede tomar tiempo, ya que se están descargando todas las imágenes de Internet. Siga mirando los logs.

Esto significa que **swarm-manager** está listo:

```
==> default: Jun 01 15:15:47 oasdrone.192.168.12.212.xip.io swarm-manage-start[12108]: time="2016-06-01T19:15:47Z" level=info msg="Registered Engine oasdrone.192.168.12.212.xip.io at 172.17.0.1:2376"
```

Esto significa que **gogs** está listo:

```
==> default: Jun 01 15:17:22 oasdrone.192.168.12.212.xip.io gogs-start[12160]: 2016/06/01 19:17:22 [I] Listen: http://0.0.0.0:3000
```

Y esto significa que **drone** está listo

```
==> default: Jun 01 15:16:49 oasdrone.192.168.12.212.xip.io drone-start[12135]: [GIN-debug]...
```

Luego visite la URL: http://oasdrone.192.168.12.212.xip.io:3000/ en su navegador. Realice la instalación de Gogs, teniendo en cuenta que el puerto de escucha de SSH es 10022, utilice el FQDN del servidor para configurar todos los parámetros. Según pantallazo.

![pantallazo de instalación de gogs](http://i.imgur.com/EUNC4Bz.png)

Visite luego la URL: http://oasdrone.192.168.12.212.xip.io:8000/ las credenciales a utilizar son las mismas de Gogs, luego conecte cualquier repositorio que haya creado en Gogs para comenzar a hacer integración contínua.

Lea la [documentación de Drone](http://readme.drone.io/).

## Paso a producción

Se necesita un servidor CentOS/7 con salida directa a Internet y con un nombre de DNS que se pueda resolver.

Lea el archivo `installer.sh` para replicar el procedimiento en un servidor real.

Lea la documentación de [oas-ci-server](https://github.com/andresvia/oas-ci-server) para conocer más detalles internos.
