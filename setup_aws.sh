#!/bin/bash

# update pip
sudo yum update -y
sudo yum install python3-devel -y #necssary for `pip install wandb`
sudo pip3 install --upgrade pip

# create accessible logs directory
sudo mkdir /nfs/logs
sudo chown -R ec2-user:ec2-user /nfs/logs

# create accessible code directory
sudo mkdir /nfs/code
sudo chown -R ec2-user:ec2-user /nfs/code

# make code directory working directory
cd /nfs/code