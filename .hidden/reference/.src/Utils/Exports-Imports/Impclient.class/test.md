# Impclient — Tests

> Source : `.src/Utils/Exports-Imports/Impclient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre d'import sans API publique utile : tous les tests sont des **replays** (fichier d'entrée +
diff des tables après import).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPCLIENT-T01 | replay | Import nominal | `clients_ok.csv` : 3 lignes complètes (28 champs) ; base `Laurux01.sql` | diff `Fiches_Cli`, `Fiches_Comptes`, `Mails_Cli`, `Fiches_Parametres.dnc` | `tests/import_nominal/` | implémenté (`assets/impclient_import_nominal/`) ; décalage des colonnes bancaires observé (voir Détail) |
| IMPCLIENT-T02 | replay | Lignes courtes | 1 ligne complète puis 1 ligne de 3 champs | figer la reprise des valeurs de la ligne précédente (anomalie A02) | `tests/lignes_courtes/` | implémenté (`assets/impclient_lignes_courtes/`, A02 figée) |
| IMPCLIENT-T03 | replay | Code déjà existant | `dnc` positionné pour que le code suivant existe déjà | figer : aucune création, `dnc` inchangé (anomalie A01) | `tests/code_existant/` | implémenté (`assets/impclient_code_existant/`, A01 figée : aucune création, `dnc` inchangé) |
| IMPCLIENT-T04 | replay | Bornes de `Compteur` | `dnc` = vide, 411999, 4119999 ; 1 ligne importée | codes `411001`, `4111000`, `41110000` | `tests/compteur_bornes/` | implémenté (`impclient_compteur_bornes` → 4111000, `impclient_compteur_bornes_4119999` → 41110000, `impclient_compteur_bornes_vide` → 411001 existant donc aucune création, A01) |
| IMPCLIENT-T05 | replay | Fichier absent | chemin inexistant | message d'erreur, aucune table modifiée | `tests/fichier_absent/` | implémenté (`assets/impclient_fichier_absent/`) |
| IMPCLIENT-T06 | replay | Collectif absent | base sans compte collectif `41*` | `cli_collectif` = dernier collectif lu ou vide (figé) | `tests/sans_collectif/` | implémenté (`assets/impclient_sans_collectif/`, `cli_collectif` = 401000, A04) |

## Détail des tests

- **Principe** : chaque scénario est capturé dans le clone **Laurux non modifié** (`./Laurux -l
  --logfile …`) : menu Gestion → « Import des clients », saisie du chemin dans `Sauves`, clic
  `Button2`. Les valeurs attendues sont le dump normalisé des 4 tables (colonnes volatiles masquées),
  stocké dans `tests/<nom>/expected/`.
- **Données** : `Laurux01.sql` ; jeux dérivés par `gen_input.py` (fichiers CSV et requêtes
  `UPDATE Fiches_Parametres SET dnc = …` préalables).
- **Non testable automatiquement** : la musique, le `Dialog.OpenFile` (le chemin est saisi
  directement dans `Sauves`).
- **Scénarios synthétisés (phase 2)** : `.hidden/Tests/Utils/assets/<nom>/` (`scenario.log`, `meta.json`, fichiers d'entrée éventuels, chemins relatifs à la racine du clone) ; jeux dans `.src/Tests/Framework/datasets/`. Attendus à produire par `runner replay Utils/<nom> --expected` quand les rejeux seront rétablis.
  Jeux : `impclient_dnc_existant` (T03), `impclient_dnc_411999`, `impclient_dnc_vide`, `impclient_dnc_4119999` (T04, trois scénarios), `impclient_sans_collectif` (T06). Le CSV est saisi en **chemin absolu** vers le clone rework (`<REWORK>/.hidden/Tests/Utils/assets/<nom>/c.csv`) : un chemin relatif est résolu dans l'archive exécutable du projet, qui ne contient pas `.src/Tests` (fichier introuvable au rejeu). Le clone rework est monté au même chemin pour les deux rejeux (ref et rework) : c'est donc le même fichier. Ce chemin est propre au bac à sable (`/home/damscot/.cache/laurux-sandbox/sb2/rework`) : à réécrire vers la racine du dépôt lors de l'intégration (et à régénérer les attendus).
- **Rejeu (2026-11-09)** : attendus produits dans ref, IDENTIQUE sur rework. Observation T01 (candidat anomalie, non documentée) : l'`INSERT INTO Fiches_Cli` reçoit 34 valeurs pour 33 marqueurs ; à partir de `cli_cd_bq` les colonnes bancaires sont décalées d'un rang (`cli_cd_bq` = échéance `30`, `cli_cd_gch` = banque, …, `cli_iban` = tireur, `cli_bic` = IBAN, `cli_rum` = BIC, RUM perdu). T04 « vide » : `dnc` NULL donne 411001, code existant dans `Laurux01.sql`, donc aucune création (A01).
