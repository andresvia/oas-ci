#!/bin/bash

# esto hace que el script falle inmediatamente ocurra el primer error y no permite usar variables que no han sido declaradas
set -eu

# variables utilizadas
ca_home="/var/lib/docker-ci-swarm-ca"
fqdn="$(hostname -f)"

# ubicación de los paquetes
ci_ca_pkg="https://github.com/andresvia/oas-ci-swarm-ca/releases/download/v0.0.2/oas-ci-swarm-ca-0.0.2_travis.4-1.x86_64.rpm"
ci_server_pkg="https://github.com/andresvia/oas-ci-server/releases/download/v0.0.8/oas-ci-server-0.0.8_travis.23-1.x86_64.rpm"
ci_agent_pkg="https://github.com/andresvia/oas-ci-agent/releases/download/v0.0.10/oas-ci-agent-0.0.9_travis.21-1.x86_64.rpm"

# hay muchas políticas de selinux que hay que encontrar primero antes de habilitar el modo "enforcing", se deja como tarea para el administrador de sistemas encontrar todas las reglas de selinux necesarias
setenforce permissive
sed -i.bak 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

# instalar el paquete de oas-ci-swarm-ca
yum install -y "${ci_ca_pkg}" || true
if ! rpm -q oas-ci-swarm-ca > /dev/null
then
  echo no se pudo instalar el paquete oas-ci-swarm-ca
  exit 1
fi

# utilizar el programa swarm-ci-create-server-cert para crear los certificados de swarm para ester servidor
/usr/sbin/swarm-ci-create-server-cert swarm "$(hostname -f)"
mkdir -p /etc/ci-swarm-manage/certs.d/
cp -vf "${ca_home}/swarm/"* /etc/ci-swarm-manage/certs.d/
if ! grep "${fqdn}" /etc/ci-swarm-manage/nodes > /dev/null
then
  echo "${fqdn}:2376" >> /etc/ci-swarm-manage/nodes
fi

# instalar el paquete oas-ci-server
yum install -y "${ci_server_pkg}" || true
if ! rpm -q oas-ci-server > /dev/null
then
  echo no se pudo instalar el paquete oas-ci-server
  exit 1
fi

# utilizar el programa swarm-ci-create-server-cert para crear los certificados de docker para ester servidor
/usr/sbin/swarm-ci-create-server-cert server "$(hostname -f)"
mkdir -p /etc/docker/certs.d/
cp -vf "${ca_home}/${fqdn}/"* /etc/docker/certs.d/

# instalar el paquete oas-ci-agent
yum install -y "${ci_agent_pkg}" || true
if ! rpm -q oas-ci-agent > /dev/null
then
  echo no se pudo instalar el paquete oas-ci-agent
  exit 1
fi

# habilitar e iniciar todos los servicios
servicios=(docker ci-swarm-manage gogs drone)
for servicio in ${servicios[@]}
do
  systemctl enable $servicio
  systemctl start $servicio
  systemctl status $servicio -l
done
