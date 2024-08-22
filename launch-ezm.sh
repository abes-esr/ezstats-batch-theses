#!/bin/bash

source /home/node/.env

# URL de ezmesure (à adapter selon votre configuration)
RESULTS_DIR="/home/node/logtheses/data/thesesfr/results"

cd /home/node

ezmesure -t "$EZMESURE_TOKEN"  indices insert z-abes-ezpaarse $RESULTS_DIR/*.csv