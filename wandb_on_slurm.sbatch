#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=2
#SBATCH --partition=aws
#SBATCH --time=0:20:0
#SBATCH -e /data/logs/slurm-%j.err
#SBATCH -o /data/logs/slurm-%j.out

echo 'starting wandb_on_slurm'

echo 'installing dependencies'
cd /data/
python3 -m venv wandb-venv
source wandb-venv/bin/activate
pip3 install --no-index --upgrade pip3
pip3 install --no-index --upgrade -r requirements.txt

echo 'downloading example'
git clone https://github.com/wandb/examples.git
cd examples/examples/keras/keras-cnn-fashion/
config_file=sweep-bayes-hyperband.yaml
echo 'using template:' $config_file

echo 'gathering node information'
nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST) # Getting the node names
nodes_array=( $nodes )
echo $nodes_array

echo 'running script'
python wandb_on_slurm.py $config_file $nodes_array