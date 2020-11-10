#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=aws
#SBATCH --time=0:30:0
#SBATCH --output=/nfs/logs/slurm-%j.log
#SBATCH --chdir=/nfs/code/wandb_on_slurm/
date;hostname;id;pwd

echo 'activating virtual environment'
source wandb-venv/bin/activate
which python

config_yaml='/nfs/code/wandb_on_slurm/examples/examples/keras/keras-cnn-fashion/sweep-bayes-hyperband.yaml'
echo 'template:' $config_yaml

train_file='/nfs/code/wandb_on_slurm/examples/examples/keras/keras-cnn-fashion/train.py'
echo 'train_file:' $train_file

project_name='wandb_slurm_tf'
echo 'project_name:' $project_name

echo 'running script'
python wandb_on_slurm.py $config_yaml $train_file $project_name