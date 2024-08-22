#!/bin/bash

RESULTS_DIR="/home/node/logtheses/data/thesesfr/results"

cd /home/node

ezmesure -t "$EZMESURE_TOKEN"  indices insert  z-abes-ezpaarse -r $RESULTS_DIR