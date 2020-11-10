#!/bin/bash

# copy key to accessible folder
python - << EOF
import netrc
import json
nrc = netrc.netrc('/home/ec2-user/.netrc')
key = {'work_account': nrc.authenticators('api.wandb.ai')[2]}
with open('/nfs/code/keys.json', 'w') as fp:
    json.dump(key, fp)
EOF
chmod 600 /nfs/code/keys.json