#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=aws
#SBATCH --time=0:30:0
#SBATCH --output=/nfs/logs/slurm-%j.log
#SBATCH --chdir=/nfs/code/wandb_on_slurm/
date;hostname;id;pwd

echo 'gathering node information'
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # get the node names
nodes_array=( $nodes )
echo "${nodes_array[@]}"

echo 'activating virtual environment'
source wandb-venv/bin/activate

config_yaml='/nfs/code/wandb_on_slurm/examples/examples/keras/keras-cnn-fashion/sweep-bayes-hyperband.yaml'
echo 'template:' $config_yaml

train_file='/nfs/code/wandb_on_slurm/examples/examples/keras/keras-cnn-fashion/train.py'
echo 'train file:' $train_file

echo 'running script'
python example_tf.py $config_yaml $train_file "${nodes_array[@]}"