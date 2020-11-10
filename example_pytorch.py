import wandb
import math
import click
import subprocess

if os.path.exists("/nfs/code/keys.json"):
    with open("/nfs/code/keys.json") as file:
        api_key = json.load(file)["work_account"]
        os.environ["WANDB_API_KEY"] = api_key

@click.command()
@click.argument("train_file")
@click.argument("node_list", nargs=-1)
def main(train_file, node_list):
    project_name = "pytorch-sweeps-demo"

    sweep_config = {
        'method': 'random'
        }

    metric = {
        'name': 'loss',
        'goal': 'minimize'   
        }
    sweep_config['metric'] = metric

    parameters_dict = {
        'optimizer': {
            'values': ['adam', 'sgd']
            },
        'fc_layer_size': {
            'values': [128, 256, 512]
            },
        'dropout': {
            'values': [0.3, 0.4, 0.5]
            },
        }
    sweep_config['parameters'] = parameters_dict

    parameters_dict.update({
        'epochs': {
            'value': 1}
        })

    parameters_dict.update({
        'learning_rate': {
            # a flat distribution between 0 and 0.1
            'distribution': 'uniform',
            'min': 0,
            'max': 0.1
        },
        'batch_size': {
            # integers between 32 and 256
            # with evenly-distributed logarithms 
            'distribution': 'q_log_uniform',
            'q': 1,
            'min': math.log(32),
            'max': math.log(256),
        }
        })

    sweep_config['program'] = train_file
    
    sweep_id = wandb.sweep(sweep_config, project=project_name)

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


if __name__ == "__main__":
    main()