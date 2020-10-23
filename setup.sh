#!/bin/bash

# update pip
sudo yum update -y
sudo yum install python3-devel -y #necssary for `pip install wandb`
sudo pip3 install --upgrade pip

# create accessible logs directory
sudo mkdir /nfs/logs
chown -R ec2-user:ec2-user /nfs/logs

# create accessible code directory
sudo mkdir /nfs/code
sudo chown -R ec2-user:ec2-user /nfs/code
cd /nfs/code

# clone example to run
git clone https://github.com/wandb/examples.git
cp ~/wandb_on_slurm/wandb_on_slurm.py /nfs/code/examples/examples/keras/keras-cnn-fashion/

# create virtual environment with required dependencies
python3 -m venv wandb-venv
source wandb-venv/bin/activate
pip install --upgrade -r examples/examples/keras/keras-cnn-fashion/requirements.txt