#!/bin/bash
yum install nfs-utils -y
systemctl start rpcbind
systemctl enable rpcbind
mkdir /mnt/nfs-share
do echo "10.0.0.41:/var/nfs/ /mnt/nfs-share/ nfs defaults 0 0" >> /etc/fstab; done
do echo "10.0.0.41:/var/upload/ /mnt/nfs-share/upload/ nfs defaults 0 0" >> /etc/fstab; done
