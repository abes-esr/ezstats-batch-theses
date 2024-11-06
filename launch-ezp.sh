#!/bin/bash
#Batch qui lance ezpaarse sur le repertoire logtheses/data/thesesfr/logs/ et ecrit les resultats dans logtheses/data/thesesfr/results/
#Doc EZPaarse NodeJS : https://github.com/ezpaarse-project/node-ezpaarse

PATH=/opt/ezpaarse/bin:/opt/ezpaarse/node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
NODE_ENV=production

dt=$(date '+%d/%m/%Y %H:%M:%S')

if [[ $(ps -edf | grep -c "launch-ezp.sh") = 4 ]];then
  echo "$dt Envoi des données dans EZPaarse"
  cd /home/node

  # Ajouter ces headers en cas de rechargement des logs complet
  #                  -H "thesesfr-base-wait-time: 10" \
  #                  -H "thesesfr-throttle: 10" \

  ezp bulk -r -v logtheses/data/thesesfr/logs/ logtheses/data/thesesfr/results/ \
                  -h ezstats-ezpaarse:59599 \
                  -H "Force-Parser: thesesfr" \
                  -H "filter-platforms: thesesfr" \
                  -H "ezPAARSE-Filter-Redirects: false" \
                  -H "ezPAARSE-Middlewares: thesesfr,thesesfr-personne,thesesfr-organisme" \
                  -H "Output-Fields: +nnt, +numSujet, +etabSoutenanceN, +etabSoutenancePpn, +codeCourt, +dateSoutenance, +anneeSoutenance, +dateInscription, +anneeInscription, +statut, +discipline, +ecoleDoctoraleN, +ecoleDoctoralePpn, +partenaireRechercheN, +partenaireRecherchePpn, +auteurN, +auteurPpn, +directeurN, +directeurPpn, +presidentN, +presidentPpn, +rapporteursN, +rapporteursPpn, +membresN, +membresPpn, +personneN, +personnePpn, +organismeN, +organismePpn, +idp_etab_nom, +idp_etab_ppn, +idp_etab_code_court, +platform_name" \
                  -H "Log-Format-apache: %h %l %u %t \"%r\" %>s %b \"%{Referer}<.*>\" \"%{User-Agent}<.*>\" \"%{Shib-Identity-Provider}<.*>\" \"%{eppn}<.*>\" \"%{primary-affiliation}<.*>\" \"%{supannEtablissement}<.*>\""

  #Donne les droits pour modifier/supprimer les fichiers depuis l'accès Webdav
  chmod -R 777 logtheses/data/thesesfr/results/
else
  echo "$dt launch-ezp.sh s'execute deja"
fi