import wandb
import subprocess
import click
import yaml
import os
import json

if os.path.exists("/nfs/code/keys.json"):
    with open("/nfs/code/keys.json") as file:
        api_key = json.load(file)["work_account"]
        os.environ["WANDB_API_KEY"] = api_key

@click.command()
@click.argument("config_yaml")
@click.argument("node_list", nargs=-1)
def run(config_yaml, node_list):
    project_name = "wandb_on_slurm"

    wandb.init(project=project_name)
    

    with open(config_yaml) as file:
        config_dict = yaml.load(file, Loader=yaml.FullLoader)
    config_dict['program'] = '/nfs/code/examples/examples/keras/keras-cnn-fashion/train.py'
    config_dict['parameters']['epochs']['value'] = 5

    sweep_id = wandb.sweep(config_dict, project=project_name)
    
    sp = []
    for node in node_list:
        sp.append(subprocess.Popen(['srun',
                        '--nodes=1',
                        '--ntasks=1',
                        '-w',
                        node,
                        'start-agent.sh',
                        sweep_id,
                        project_name]))
    exit_codes = [p.wait() for p in sp] # wait for processes to finish
    return exit_codes 


if __name__ == '__main__':
    run()