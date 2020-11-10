#!/bin/bash

# login and copy key to accessible folder
wandb login
python - << EOF
import netrc
nrc = netrc.netrc('/home/ec2-user/.netrc')
key = {'work_account': nrc.authenticators('api.wandb.ai')[2]}
import json
with open('/nfs/code/keys.json', 'w') as fp:
    json.dump(key, fp)
EOF
chmod 600 /nfs/code/keys.json