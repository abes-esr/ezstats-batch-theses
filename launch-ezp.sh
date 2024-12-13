#!/bin/bash
#Batch qui lance ezpaarse sur le repertoire logtheses/data/thesesfr/logs/ et ecrit les resultats dans logtheses/data/thesesfr/results/
#Doc EZPaarse NodeJS : https://github.com/ezpaarse-project/node-ezpaarse

PATH=/opt/ezpaarse/bin:/opt/ezpaarse/node_modules/.bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/sbin:$PATH
NODE_ENV=production

dt=$(date '+%d/%m/%Y %H:%M:%S')

if [[ $(ps -edf | grep -c "launch-ezp.sh") = 4 ]];then
  echo "$dt Envoi des données dans EZPaarse"
  cd /home/node

  # En cas de rechargement des logs complet : passer les headers thesesfr-base-wait-time et thesesfr-throttle à 10 pour passer d'un traitement de log de 3h, à 20 minutes
  # Attention a surveiller theses.fr dans ce cas : plantages constates en 2024

  # Les valeurs par défaut de thesesfr-base-wait-time : 1000 et thesesfr-throttle : 100

  ezp bulk -r -v logtheses/data/thesesfr/logs/ logtheses/data/thesesfr/results/ \
                  -h ezstats-ezpaarse:59599 \
                  -H "Force-Parser: thesesfr" \
                  -H "filter-platforms: thesesfr" \
                  -H "ezPAARSE-Filter-Redirects: false" \
                  -H "ezPAARSE-Middlewares: thesesfr,thesesfr-personne,thesesfr-organisme,idp-metadata" \
                  -H "thesesfr-base-wait-time: 1000" \
                  -H "thesesfr-throttle: 100" \
                  -H "Output-Fields: +nnt, +numSujet, +etabSoutenanceN, +etabSoutenancePpn, +codeCourt, +dateSoutenance, +anneeSoutenance, +dateInscription, +anneeInscription, +statut, +discipline, +ecoleDoctoraleN, +ecoleDoctoralePpn, +partenaireRechercheN, +partenaireRecherchePpn, +auteurN, +auteurPpn, +directeurN, +directeurPpn, +presidentN, +presidentPpn, +rapporteursN, +rapporteursPpn, +membresN, +membresPpn, +personneN, +personnePpn, +organismeN, +organismePpn, +platform_name, +publication_title, +libelle_idp" \
                  -H "Log-Format-apache: %h %l %{login}<.*> %t \"%r\" %>s %b \"%{Referer}<.*>\" \"%{User-Agent}<.*>\" \"%{Shib-Identity-Provider}<.*>\" \"%{eppn}<.*>\" \"%{primary-affiliation}<.*>\" \"%{supannEtablissement}<.*>\""

  # Liste complète des colonnes définies lors du projet EZStats (2024) : les données de certaines colonnes ne sont pour l'instant pas renvoyées par l'API Theses.fr. Ces colonnes ne sont donc pas utilisées (ex : doiThese, etc.)
  # -H "Output-Fields: +nnt, +numSujet, +doiThese, +etabSoutenanceN, +etabSoutenancePpn, +codeCourt, +dateSoutenance, +anneeSoutenance, +dateInscription, +anneeInscription, +statut, +accessible, +source, +discipline, +domaine, +langue, +ecoleDoctoraleN, +ecoleDoctoralePpn, +partenaireRechercheN, +partenaireRecherchePpn, +cotutelleN, +cotutellePpn, +auteurN, +auteurPpn, +directeurN, +directeurPpn, +presidentN, +presidentPpn, +rapporteursN, +rapporteursPpn, +membresN, +membresPpn, +personneN, +personnePpn, +organismeN, +organismePpn, +platform_name, +publication_title, +libelle_idp" \

  #Donne les droits pour modifier/supprimer les fichiers depuis l'accès Webdav
  chmod -R 777 logtheses/data/thesesfr/results/
else
  echo "$dt launch-ezp.sh s'execute deja"
fi