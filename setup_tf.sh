#!/bin/bash

# download example
git clone https://github.com/elyall/examples.git

# create virtual environment and install required dependencies
python3 -m venv wandb-venv
source wandb-venv/bin/activate
pip install --upgrade -r examples/examples/keras/keras-cnn-fashion/requirements.txt
# pip install --upgrade git+git://github.com/wandb/client.git #install latest development version

# log in to W&B
wandb login