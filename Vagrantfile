# -*- mode: ruby -*-
# vi: set ft=ruby :

vbox_memory = ENV["OAS_CI_VBOX_MEMORY"] || 4096
libvirt_memory = ENV["OAS_CI_LIBVIRT_MEMORY"] || 2048
vbox_cpus = ENV["OAS_CI_VBOX_CPUS"] || 2
libvirt_cpus = ENV["OAS_CI_LIBVIRT_CPUS"] || 1

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "ci.192.168.12.212.xip.io"
  config.vm.network "private_network", ip: "192.168.12.212"
  config.vm.provision "shell", path: "scripts/installer"
  config.vm.provider "virtualbox" do |v|
    v.memory = vbox_memory.to_i
    v.cpus = vbox_cpus.to_i
  end
  config.vm.provider "libvirt" do |v|
    v.memory = libvirt_memory.to_i
    v.cpus = libvirt_cpus.to_i
  end
end
