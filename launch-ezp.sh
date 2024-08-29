#!/bin/bash
#Batch qui lance ezpaarse sur le repertoire logtheses/data/thesesfr/logs/ et ecrit les resultats dans logtheses/data/thesesfr/results/

PATH=/opt/ezpaarse/bin:/opt/ezpaarse/node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
NODE_ENV=production

if [[ $(ps -edf | grep -c "launch-ezp.sh") = 4 ]];then
  cd /home/node
  ezp bulk -r -v logtheses/data/thesesfr/logs/ logtheses/data/thesesfr/results/ \
                  -h ezstats-ezpaarse:59599 \
                  -H "Force-Parser: thesesfr" \
                  -H "filter-platforms: thesesfr" \
                  -H "ezPAARSE-Filter-Redirects: false" \
                  -H "ezPAARSE-Middlewares: thesesfr,thesesfr-personne" \
                  -H "Output-Fields: +nnt, +numSujet, +etabSoutenanceN, +etabSoutenancePpn, +dateSoutenance, +dateInscription, +statut, +accessible, +source, +discipline, +domaine, +langue, +ecoleDoctoraleN, +ecoleDoctoralePpn, +partenaireRechercheN, +partenaireRecherchePpn, +cotutelleN, +cotutellePpn, +auteurN, +auteurPpn, +directeurN, +directeurPpn, +presidentN, +presidentPpn, +rapporteursN, +rapporteursPpn, +membresN, +membresPpn, +personneN, +personnePpn, +organismeN, +organismePpn" \
                  -H "Log-Format-apache: %h %l %u %t \"%r\" %>s %b \"%{Referer}<.*>\" \"%{User-Agent}<.*>\" \"%{Shib-Identity-Provider}<.*>\" \"%{eppn}<.*>\" \"%{primary-affiliation}<.*>\" \"%{supannEtablissement}<.*>\""

  #Donne les droits pour modifier/supprimer les fichiers depuis l'accès Webdav
  chmod -R 777 logtheses/data/thesesfr/results/
else
  dt=$(date '+%d/%m/%Y %H:%M:%S')
  echo "$dt launch-ezp.sh s'execute deja"
fi