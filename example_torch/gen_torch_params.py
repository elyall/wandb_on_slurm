import math
import yaml

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

# parameters_dict.update({
#     'learning_rate': {
#         # a flat distribution between 0 and 0.1
#         'distribution': 'uniform',
#         'min': 0,
#         'max': 0.1
#     },
#     'batch_size': {
#         # integers between 32 and 256
#         # with evenly-distributed logarithms 
#         'distribution': 'q_log_uniform',
#         'q': 1,
#         'min': math.log(32),
#         'max': math.log(256),
#     }
#     })

with open('torch_params.yaml', 'w') as outfile:
    yaml.dump(sweep_config, outfile, default_flow_style=False)