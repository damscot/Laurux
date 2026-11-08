#!/bin/bash
# Point d'entrée de l'étape « app » : démarre MariaDB (point d'entrée officiel hérité de l'étape « db »,
# qui exécute aussi /docker-entrypoint-initdb.d au premier démarrage), ssh, puis la commande en tant que ${USER}.

echo "Démarrage de MariaDB"
docker-entrypoint.sh mariadbd ${LAURUX_SQL_MODE:+--sql-mode="${LAURUX_SQL_MODE}"} &
for i in $(seq 1 60); do
  mariadb-admin --silent ping >/dev/null 2>&1 && break
  sleep 1
done

echo "Démarrage de ssh"
service ssh start

echo "Remappage de l'utilisateur"
source /user-mapping.sh

echo "Mot de passe de l'utilisateur"
echo -e "${USER}\n${USER}" | passwd ${USER}

echo "Exécution de : $@"
exec su - "${USER}" -c "$@"
