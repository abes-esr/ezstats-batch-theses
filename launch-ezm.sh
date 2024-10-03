#!/bin/bash
#Batch qui lance ezmesure sur le repertoire logtheses/data/thesesfr/results/ sur l'url $1, avec le token EZMesure $2 et l'index $3
#Doc EZMesure NodeJS : https://github.com/ezpaarse-project/node-ezmesure

PATH=/opt/ezpaarse/bin:/opt/ezpaarse/node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
NODE_ENV=production

RESULTS_DIR="/home/node/logtheses/data/thesesfr/results"
dt=$(date '+%d/%m/%Y %H:%M:%S')

if [[ $(ps -edf | grep -c "launch-ezm.sh") = 4 ]];then
  echo "$dt Envoi des données dans EZMesure sur l'url : $1 , index : $3"
  cd /home/node
  ezmesure -u $1 -t "$2" indices insert $3 -r $RESULTS_DIR

  #Donne les droits pour modifier/supprimer les fichiers depuis l'accès Webdav
  chmod -R 777 $RESULTS_DIR
else
  echo "$dt launch-ezm.sh s'execute deja"
fi