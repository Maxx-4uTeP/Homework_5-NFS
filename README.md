 # Домашняя работа 5 (NFS)

Выбирал как правильнее сделать домешку, решил что поднимать ВМ с чистых образов и потом раскатывать на них скриптами необходимую инфру - правильнее с точки зрения автоматизации. Поэтому сделал скриптами.

С помощью vagrant файла поднимается две ВМ: server и client
В корне располагается два скрипта: 
server.sh

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
    systemctl enable firewalld
    systemctl start firewalld
    sudo firewall-cmd --zone=public --add-service=nfs --permanent
    sudo firewall-cmd --zone=public --add-service=nfs3 --permanent
    sudo firewall-cmd --reload
    reboot

client.sh

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

Чтобы "наверняка" в конце каждого скрипта прописан reboot серверу и клиенту.

лог после vagrant up:

        client:
        client: Installed:
        client:   python3-pyyaml-3.12-12.el8.x86_64
        client: Complete!

    D:\YandexDisk\GitHub\Homework_5-NFS>vagrant ssh client

    D:\YandexDisk\GitHub\Homework_5-NFS>vagrant ssh client
    [vagrant@client ~]$ ls /mnt/nfs-share/
    upload
    [vagrant@client ~]$ touch /mnt/nfs-share/test
    touch: cannot touch '/mnt/nfs-share/test': Read-only file system
    [vagrant@client ~]$ touch /mnt/nfs-share/upload/test
    [vagrant@client ~]$ ls -l /mnt/nfs-share/upload/
    total 0
    -rw-rw-r--. 1 vagrant vagrant 0 May 16 08:09 test
    [vagrant@client ~]$