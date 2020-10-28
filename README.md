# wandb_on_slurm
Example of how to use Weights &amp; Biases on Slurm

## Setup a Slurm cluster on AWS
Follow the directions at https://github.com/elyall/aws-plugin-for-slurm/tree/plugin-v2 to setup a burstable slurm cluster.

## Install code and submit job
SSH into the headnode instance. Then run:
```
git clone https://github.com/elyall/wandb_on_slurm.git
cd ~/wandb_on_slurm
bash setup.sh
sbatch wandb_on_slurm.sbatch
```