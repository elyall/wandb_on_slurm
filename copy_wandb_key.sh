#!/bin/bash

# copy key to accessible folder
python - << EOF
import netrc
import json
nrc = netrc.netrc()
key = {'work_account': nrc.authenticators('api.wandb.ai')[2]} # allow for multiple keys
with open('keys.json', 'w') as fp:
    json.dump(key, fp)
EOF
chmod 600 keys.json