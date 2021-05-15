# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'open3'
require 'fileutils'

def get_vm_name(id)
  out, err = Open3.capture2e('VBoxManage list vms')
  raise out unless err.exitstatus.zero?

  path = path = File.dirname(__FILE__).split('/').last
  name = out.split(/\n/)
            .select { |x| x.start_with? "\"#{path}_#{id}" }
            .map { |x| x.tr('"', '') }
            .map { |x| x.split(' ')[0].strip }
            .first

  name
end

# Cent OS 8.2
# config used from this
# https://github.com/eoli3n/vagrant-pxe/blob/master/client/Vagrantfile

Vagrant.configure("2") do |config|

  config.vm.define "server" do |server|
    config.vm.box = 'centos/8.2'
    config.vm.box_url = 'https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-Vagrant-8.2.2004-20200611.2.x86_64.vagrant-virtualbox.box'
    config.vm.box_download_checksum = '698b0d9c6c3f31a4fd1c655196a5f7fc224434112753ab6cb3218493a86202de'
    config.vm.box_download_checksum_type = 'sha256'

    server.vm.host_name = 'server5'
    server.vm.network :private_network, ip: "10.0.0.41"

    server.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end

  

    config.vm.define "client" do |client|
      client.vm.box = 'centos/8.2'
      client.vm.host_name = 'client5'
      client.vm.network :private_network, ip: "10.0.0.40"
      client.vm.provider :virtualbox do |vb|
        vb.memory = "1024"
        vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      end
    end
  end
end
