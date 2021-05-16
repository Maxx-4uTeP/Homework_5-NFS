#!/bin/bash
yum install nfs-utils -y
systemctl enable rpcbind nfs-server
systemctl start rpcbind nfs-server
mkdir /var/nfs
mkdir /var/nfs/upload
mkdir /var/upload
chmod -R 777 /var/nfs
chmod -R 777 /var/upload
echo "/var/nfs 10.0.0.0/24(ro,root_squash)" >> /etc/exports
echo "/var/upload 10.0.0.0/24(rw,root_squash)" >> /etc/exports
exportfs -r
systemctl start firewalld
sudo firewall-cmd --zone=public --add-service=nfs --permanent
sudo firewall-cmd --zone=public --add-service=nfs3 --permanent
sudo firewall-cmd --reload
reboot