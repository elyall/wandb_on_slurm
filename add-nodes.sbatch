#!/bin/bash
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --partition=aws
#SBATCH --time=0:30:0
#SBATCH --array=0-3
#SBATCH --output=/nfs/logs/slurm-%A_%a.log
#SBATCH --chdir=/nfs/code/wandb_on_slurm/
date;hostname;id;pwd

sweep_id=[SWEEP_ID_HERE]
echo 'project_name:' $project_name

echo 'job array task:' $SLURM_ARRAY_TASK_ID

echo 'activating virtual environment'
source wandb-venv/bin/activate
which python

wandb agent $sweep_id