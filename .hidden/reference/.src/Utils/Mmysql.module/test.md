# Mmysql — Tests

> Source : `.src/Utils/Mmysql.module` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| MMYSQL-T01 | gbtest | `Process_List` mot de passe valide | MariaDB Docker, `gksu` remplacé par un script factice dans le `PATH` qui exécute la commande | entier > 0 (valeur de référence) | `tests/processlist_ok/` | à faire |
| MMYSQL-T02 | gbtest | `Process_List` mot de passe invalide | idem, mauvais mot de passe, `LANG=C` puis `LANG=fr_FR.UTF-8` | valeurs figées (anomalie A01 : > 0 en anglais) | `tests/processlist_ko/` | à faire |
| MMYSQL-T03 | gbtest | `Init` | `kdesu`/`gksu`/`sudo` factices qui journalisent leurs arguments, `KDE_FULL_SESSION` présent/absent | commandes journalisées identiques | `tests/init_cmd/` | à faire |

## Détail des tests

- Les outils d'élévation sont remplacés par des scripts factices placés en tête du `PATH` : ils
  journalisent la ligne de commande reçue (et l'exécutent pour `mysqladmin`). Les commandes
  attendues sont capturées dans le clone **Laurux non modifié**.
- `~/tmp` est créé dans un `HOME` de test isolé.
- Non testable : le redémarrage réel du service MySQL.
