# -*- mode: ruby -*-
# vi: set ft=ruby :

vbox_memory = ENV["OAS_CI_VBOX_MEMORY"] || 4096
libvirt_memory = ENV["OAS_CI_LIBVIRT_MEMORY"] || 2048
vbox_cpus = ENV["OAS_CI_VBOX_CPUS"] || 2
libvirt_cpus = ENV["OAS_CI_LIBVIRT_CPUS"] || 1

# esta herramienta permite pasar variables de entorno desde el OS host al OS guest
envtool_artifact="https://github.com/andresvia/envtool/releases/download/v0.0.6/envtool"
if not File.exists? 'envtool'
  system "wget", "-Oenvtool", envtool_artifact
end

# aquí se configura como el comando envtool se va a ejecutar
envtool_env="sudo env"
envtool_cmd="/usr/local/sbin/envtool persist --edit /etc/environment --edit /etc/sysconfig/docker"
pass_variables = ["HTTP_PROXY", "http_proxy", "HTTPS_PROXY", "https_proxy", "NO_PROXY", "no_proxy"]
pass_variables.each do |pass_var|
  envtool_env += " '#{pass_var.gsub(/'/, "")}=#{ENV[pass_var].gsub(/'/, "")}'"
  envtool_cmd += " --select '#{pass_var.gsub(/'/, "")}'"
end

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "ci"
  config.vm.provision "file", source: "envtool", destination: "/tmp/envtool"
  config.vm.provision "shell", inline: "mv /tmp/envtool /usr/local/sbin/envtool"
  config.vm.provision "shell", inline: "chmod +x /usr/local/sbin/envtool"
  config.vm.provision "shell", inline: "#{envtool_env} #{envtool_cmd}"
  config.vm.provision "shell", path: "scripts/installer"
  config.vm.network "private_network", ip: "192.168.12.212"
  config.vm.provider "virtualbox" do |v|
    v.memory = vbox_memory.to_i
    v.cpus = vbox_cpus.to_i
  end
  config.vm.provider "libvirt" do |v|
    v.memory = libvirt_memory.to_i
    v.cpus = libvirt_cpus.to_i
  end
end
