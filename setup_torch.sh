#!/bin/bash

# download and install conda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh # install in /nfs/code/miniconda3
rm Miniconda3-latest-Linux-x86_64.sh
conda update -n base -c defaults conda -y # update conda

# create virtual environment and install required dependencies
conda create -n 'torch_example' -y
conda activate torch_example
conda install pytorch torchvision -c pytorch -y
pip install --upgrade wandb
# pip install --upgrade git+git://github.com/wandb/client.git # install latest development version of wandb

# log in to W&B
wandb login