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
cp ~/wandb_on_slurm/wandb_on_slurm.py /nfs/code/
cp ~/wandb_on_slurm/start-agent.sh /nfs/code/
chmod +x /nfs/code/start-agent.sh
cd /nfs/code

# clone example to run
git clone https://github.com/elyall/examples.git

# create virtual environment with required dependencies
python3 -m venv wandb-venv
source wandb-venv/bin/activate
pip install --upgrade -r examples/examples/keras/keras-cnn-fashion/requirements.txt

# login and copy key to accessible folder
wandb login
python - << EOF
import netrc
nrc = netrc.netrc('/home/ec2-user/.netrc')
key = {'work_account': nrc.authenticators('api.wandb.ai')[2]}
import json
with open('/nfs/code/keys.json', 'w') as fp:
    json.dump(key, fp)
EOF
chmod 600 /nfs/code/keys.json

deactivate
cd ~