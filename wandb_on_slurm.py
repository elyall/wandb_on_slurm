import wandb
import subprocess
import click
import yaml

wandb.login()
wandb.init(project="wandb_on_slurm")


@click.command()
@click.argument("config_yaml")
@click.argument("node_list")
def run(config_yaml, node_list):

    with open(config_yaml) as file:
        config_dict = yaml.load(file, Loader=yaml.FullLoader)
    config_dict['parameters']['epochs'] = 5
    
    sweep_id = wandb.sweep(config_dict)

    for node in node_list:
        subprocess.run(['srun',
                        '--nodes=1',
                        '--ntasks=1',
                        '-w',
                        node,
                        'wandb',
                        'agent',
                        sweep_id])


if __name__ == '__main__':
    run()