#!/bin/bash

# esto hace que el script falle inmediatamente ocurra el primer error y no permite usar variables que no han sido declaradas
set -eu

# ubicación de los paquetes
ci_server_pkg="https://github.com/andresvia/oas-ci-server/releases/download/v0.0.5/oas-ci-server-0.0.5_local.1464760661-1.x86_64.rpm"
ci_agent_pkg="https://github.com/andresvia/oas-ci-agent/releases/download/v0.0.5/oas-ci-agent-0.0.5_local.1464759585-1.x86_64.rpm"

# hay muchas políticas de selinux que hay que encontrar primero antes de habilitar el modo "enforcing", se deja como tarea para el administrador de sistemas encontrar todas las reglas de selinux necesarias
setenforce permissive
sed -i.bak 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config

# instalar el paquete oas-ci-server si este no se encuentra ya instalado
if ! rpm -q oas-ci-server
then
  yum install -y "${ci_server_pkg}"
fi

# utilizar el programa swarm-manage-cert-create para crear un certificado para este servidor
/usr/sbin/swarm-manage-cert-create "$(hostname -f)"
cp -vf "/var/lib/docker-swarm-ca/$(hostname -f)"/* /etc/docker/certs.d/

# este mismo host es tanto el servidor de CI como un agente de CI, mas agentes de CI se pueden ir agregando a medida que sean necesarios, también puede considerar instalar el agente en un servidor distínto, un motivo sería asegurar los certificados que se encuentran en el servidor de CI
if ! rpm -q oas-ci-agent
then
  yum install -y "${ci_agent_pkg}"
fi

# habilitar todos los servicios
systemctl status swarm-manage -l
systemctl status gogs -l
systemctl status drone -l
