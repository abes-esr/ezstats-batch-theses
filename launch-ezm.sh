#!/bin/bash
#Batch qui lance ezmesure sur le repertoire logtheses/data/thesesfr/results/ avec le token EZMesure recu en parametre $1

PATH=/opt/ezpaarse/bin:/opt/ezpaarse/node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
NODE_ENV=production

RESULTS_DIR="/home/node/logtheses/data/thesesfr/results"

if [[ $(ps -edf | grep -c "launch-ezm.sh") = 4 ]];then
  cd /home/node
  ezmesure -t "$1"  indices insert  z-abes-ezpaarse -r $RESULTS_DIR
  chmod -R 777 $RESULTS_DIR
else
  dt=$(date '+%d/%m/%Y %H:%M:%S')
  echo "$dt launch-ezm.sh s'execute deja"
fi