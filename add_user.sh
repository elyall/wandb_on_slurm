#!/bin/bash

groupname="slurmusers"
username="wandb-user"

sudo groupadd $groupname

sudo adduser $username
sudo usermod -aG $groupname $username
sudo mkdir -p /nfs/home/$username
sudo chown -R $username:$username /nfs/home/$username
sudo chmod -R 750 /nfs/home/$username
sudo usermod -d /nfs/home/$username $username

#local machine
#ssh-keygen -m PEM -t rsa -b 2048 -C "slurm-key" -f ./slurm-key #on local machine
#chmod 600 slurm-key

sudo passwd $username #set password
su $username
mkdir ~/.ssh
chmod 700 .ssh
nano ~/.ssh/authorized_keys # paste public key from ssh-keygen step
chmod 600 ~/.ssh/authorized_keys