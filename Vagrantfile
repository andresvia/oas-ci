# -*- mode: ruby -*-
# vi: set ft=ruby :

user = ENV["USER"]

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "#{user}.192.168.12.212.xip.io"
  config.vm.network "private_network", ip: "192.168.12.212"
  config.vm.provision "shell", path: "installer.sh"
end
