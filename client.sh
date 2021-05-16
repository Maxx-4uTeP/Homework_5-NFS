#!/bin/bash
yum install nfs-utils -y
systemctl start rpcbind
systemctl enable rpcbind
mkdir /mnt/nfs-share
mkdir /mnt/nfs-share/upload
mount -t nfs 10.0.0.41:/var/nfs/ /mnt/nfs-share/
mount -t nfs 10.0.0.41:/var/upload/ /mnt/nfs-share/upload/
echo "10.0.0.41:/var/nfs/ /mnt/nfs-share/ nfs defaults 0 0" >> /etc/fstab
echo "10.0.0.41:/var/upload/ /mnt/nfs-share/upload/ nfs defaults 0 0" >> /etc/fstab
reboot