# FSauve — Tests

> Source : `.src/Communs/FSauve.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests **replay** sur MariaDB Docker. Critère : les fichiers produits. Le `.sql` n'est pas comparé
octet à octet (date de dump, version du serveur) : il est **réimporté** dans une base vierge dont
le dump normalisé doit être identique à celui de la base sauvegardée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSAUVE-T01 | replay | Sauvegarde simple | base `Laurux01.sql`, `Compb` décoché, `<rep>` existant | `<rep>/Laurux01.sql` réimportable (dump identique) ; `<rep>/Laurux.conf` = fichier de configuration ; message de succès | `tests/sauvegarde_sql/` | à faire |
| FSAUVE-T02 | replay | Sauvegarde compressée | `Compb` coché | `.sql` et `.sql.gz` présents ; `gunzip` du `.gz` = `.sql` | `tests/sauvegarde_gz/` | à faire |
| FSAUVE-T03 | replay | Répertoire inexistant | `Sauves` = chemin absent | aucun message, aucun fichier (A02 figée) | `tests/repertoire_absent/` | à faire |
| FSAUVE-T04 | replay | Contrôle des processus | > 7 connexions ouvertes ; puis mot de passe faux | `Hbox1` visible ; « Mot de passe invalide ! » selon la locale (MMYSQL-A01) | `tests/processus/` | à faire |
| FSAUVE-T05 | replay | Mémorisation de la compression | cocher `Compb`, Fermer | `/Compression` = -1 dans `Laurux.conf` ; après sauvegarde réussie sans Fermer, valeur inchangée | `tests/memorisation_compression/` | à faire |
| FSAUVE-T06 | replay | Échec de `mysqldump` | utilisateur de test sans droit `SELECT` sur une table | message « correctement sauvegardée » malgré un dump incomplet (A01 figée) | `tests/echec_dump/` | à faire |

## Détail des tests

- **Génération des valeurs attendues** : capture dans le clone **Laurux non modifié** (`-c` vers
  un `Laurux.conf` de test, `/Rep_Sauv` vers un répertoire du test), rejeu sur les deux clones,
  puis réimport des `.sql` produits dans une base vierge et comparaison des dumps normalisés.
- **Données** : `Laurux01.sql`.
- **Prérequis Docker** : `mysqldump` et `mysqladmin` sur l'hôte ; `Host = 127.0.0.1` et port
  **3306** (les commandes ne passent pas `-P`) ; `gksu` absent sur la plupart des systèmes :
  `Process_List` renvoie alors un nombre de lignes non nul (message d'erreur du shell), à figer.
- **Fichier de configuration** : FSauve copie `~/.config/gambas3/Laurux.conf` et non le fichier
  `-c` (A03) : le runner doit isoler `HOME` pour ne pas copier la configuration réelle.
- **Non testable automatiquement** : `Button5_Click` (redémarrage MySQL par `sudo`), éditeur, sons.
