#!/usr/local/bin/dumb-init /bin/bash

consul-template -consul localhost:8500 -once -template="/etc/consul-templates/etherpad/settings.json.ctmpl:/opt/etherpad/settings.json"

cd /opt/etherpad/
./bin/run.sh --root
