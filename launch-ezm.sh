#!/bin/bash
PATH=/opt/ezpaarse/bin:/opt/ezpaarse/node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
NODE_ENV=production

RESULTS_DIR="/home/node/logtheses/data/thesesfr/results"

cd /home/node

ezmesure -t "$1"  indices insert  z-abes-ezpaarse -r $RESULTS_DIR