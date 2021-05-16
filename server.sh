#!/bin/bash
yum install nfs-utils
systemctl enable rpcbind nfs-server
systemctl start rpcbind nfs-server
mkdir /var/nfs
mkdir /var/upload
chmod -R 777 /var/nfs
chmod -R 777 /var/upload
do echo "/var/nfs 10.0.0.0/24(ro,root_squash)" >> /etc/exports; done
do echo "/var/upload 10.0.0.0/24(rw,root_squash)" >> /etc/exports; done
exportfs -r
systemctl start firewalld
sudo firewall-cmd --zone=public --add-service=nfs --permanent
sudo firewall-cmd --zone=public --add-service=nfs3 --permanent
sudo firewall-cmd --reload

