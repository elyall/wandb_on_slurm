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
conda activate torch_example

train_file='/nfs/code/wandb_on_slurm/pytorch_model.py'
echo 'script:' $train_file

echo 'running script'
python example_pytorch.py $train_file "${nodes_array[@]}"