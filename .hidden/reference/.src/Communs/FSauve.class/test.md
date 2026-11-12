# FSauve — Tests

> Source : `.src/Communs/FSauve.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Tests **replay** sur MariaDB Docker. Critère : les fichiers produits. Le `.sql` n'est pas comparé
octet à octet (date de dump, version du serveur) : il est **réimporté** dans une base vierge dont
le dump normalisé doit être identique à celui de la base sauvegardée.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| FSAUVE-T01 | replay | Sauvegarde simple | base `Laurux01.sql`, `Compb` décoché, `<rep>` existant | `<rep>/Laurux01.sql` réimportable (dump identique) ; `<rep>/Laurux.conf` = fichier de configuration ; message de succès | `tests/sauvegarde_sql/` | implémenté |
| FSAUVE-T02 | replay | Sauvegarde compressée | `Compb` coché | `.sql` et `.sql.gz` présents ; `gunzip` du `.gz` = `.sql` | `tests/sauvegarde_gz/` | implémenté |
| FSAUVE-T03 | replay | Répertoire inexistant | `Sauves` = chemin absent | aucun message, aucun fichier (A02 figée) | `tests/repertoire_absent/` | implémenté |
| FSAUVE-T04 | replay | Contrôle des processus | > 7 connexions ouvertes ; puis mot de passe faux | `Hbox1` visible ; « Mot de passe invalide ! » selon la locale (MMYSQL-A01) | `tests/processus/` | à faire : Process_List lance gksu (absent) : lg vaut toujours 1 (ni Hbox1 ni « Mot de passe invalide ») |
| FSAUVE-T05 | replay | Mémorisation de la compression | cocher `Compb`, Fermer | `/Compression` = -1 dans `Laurux.conf` ; après sauvegarde réussie sans Fermer, valeur inchangée | `tests/memorisation_compression/` | implémenté (partiel : mémorisation par Quitter vérifiée ; non-mémorisation après sauvegarde réussie non distinguable) |
| FSAUVE-T06 | replay | Échec de `mysqldump` | utilisateur de test sans droit `SELECT` sur une table | message « correctement sauvegardée » malgré un dump incomplet (A01 figée) | `tests/echec_dump/` | à faire : nécessite un utilisateur MariaDB sans droit SELECT (création de compte impossible sans droits d'administration sur la base de test ; Login figé dans Laurux-test.conf) |

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

## Implémentation (phase 2)

- Scénarios `.hidden/Tests/Communs/assets/fsauve_<répertoire>/` (Sauvegarde : `Fmenu#Menu55#Menu57`), jeu
  `fusers_base`. Sauvegarde dans `/tmp` (pas dans `/tmp/laurux-test/`, partagé avec les fichiers d'entrée des
  scénarios FRestore). Les fichiers produits ne sont pas comparés directement : leur réimport par FRestore dans
  le même rejeu (base identique) en tient lieu (T01, T02 ; aller-retour avec modification : FRESTORE-T10).
- `~/.config/gambas3/Laurux.conf` n'existe pas avec `-c` : aucun `Laurux.conf` n'est copié (A03 observée).
- T05 : seule la mémorisation par Quitter est vérifiée (restauration du `.gz` témoin de
  `fsauve_memorisation_compression`) ; la non-mémorisation après sauvegarde réussie n'est pas distinguable.
- `Process_List` lance `gksu` (absent) : `lg` vaut toujours 1 ; T04 inatteignable.
