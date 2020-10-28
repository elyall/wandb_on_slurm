#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --partition=aws
#SBATCH --time=0:20:0
#SBATCH --output=/nfs/logs/slurm-%j.log
#SBATCH --chdir=/nfs/code/
date;hostname;id;pwd;ls

echo 'gathering node information'
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # get the node names
nodes_array=( $nodes )
echo "${nodes_array[@]}"

echo 'activating virtual environment'
source wandb-venv/bin/activate

config_yaml='/nfs/code/examples/examples/keras/keras-cnn-fashion/sweep-bayes-hyperband.yaml'
echo 'template:' $config_yaml

echo 'running script'
python wandb_on_slurm.py $config_yaml "${nodes_array[@]}"