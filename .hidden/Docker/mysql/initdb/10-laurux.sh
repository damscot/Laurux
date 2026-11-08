#!/bin/bash
# Initialisation commune de la base Laurux (exécutée une seule fois, au premier démarrage du conteneur,
# par le point d'entrée de l'image officielle mariadb : /docker-entrypoint-initdb.d).
#   - crée l'utilisateur applicatif ${LAURUX_USER} (mot de passe ${LAURUX_PASSWORD}) avec tous les droits :
#     Laurux crée et supprime lui-même ses bases (Laurux01, Laurux02…) ;
# Le sql_mode est fixé par l'option --sql-mode du serveur (docker-compose.test.yml, entrypoint de l'étape app).
set -euo pipefail

LAURUX_USER="${LAURUX_USER:-laurux}"
LAURUX_PASSWORD="${LAURUX_PASSWORD:-laurux}"

mariadb -uroot -p"${MARIADB_ROOT_PASSWORD}" <<SQL
CREATE USER IF NOT EXISTS '${LAURUX_USER}'@'%' IDENTIFIED BY '${LAURUX_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${LAURUX_USER}'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
SQL

