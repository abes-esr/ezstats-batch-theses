#!/bin/bash

# URL de ezmesure (à adapter selon votre configuration)
RESULTS_DIR="/home/node/logtheses/data/thesesfr/results"

cd /home/node

ezmesure -t "$EZMESURE_TOKEN"  indices insert  z-abes-ezpaarse -r $RESULTS_DIR