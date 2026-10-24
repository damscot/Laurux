# Impclient — Tests

> Source : `.src/Utils/Exports-Imports/Impclient.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre d'import sans API publique utile : tous les tests sont des **replays** (fichier d'entrée +
diff des tables après import).

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPCLIENT-T01 | replay | Import nominal | `clients_ok.csv` : 3 lignes complètes (28 champs) ; base `Laurux01.sql` | diff `Fiches_Cli`, `Fiches_Comptes`, `Mails_Cli`, `Fiches_Parametres.dnc` | `tests/import_nominal/` | à faire |
| IMPCLIENT-T02 | replay | Lignes courtes | 1 ligne complète puis 1 ligne de 3 champs | figer la reprise des valeurs de la ligne précédente (anomalie A02) | `tests/lignes_courtes/` | à faire |
| IMPCLIENT-T03 | replay | Code déjà existant | `dnc` positionné pour que le code suivant existe déjà | figer : aucune création, `dnc` inchangé (anomalie A01) | `tests/code_existant/` | à faire |
| IMPCLIENT-T04 | replay | Bornes de `Compteur` | `dnc` = vide, 411999, 4119999 ; 1 ligne importée | codes `411001`, `4111000`, `41110000` | `tests/compteur_bornes/` | à faire |
| IMPCLIENT-T05 | replay | Fichier absent | chemin inexistant | message d'erreur, aucune table modifiée | `tests/fichier_absent/` | à faire |
| IMPCLIENT-T06 | replay | Collectif absent | base sans compte collectif `41*` | `cli_collectif` = dernier collectif lu ou vide (figé) | `tests/sans_collectif/` | à faire |

## Détail des tests

- **Principe** : chaque scénario est capturé dans le clone **Laurux non modifié** (`./Laurux -l
  --logfile …`) : menu Gestion → « Import des clients », saisie du chemin dans `Sauves`, clic
  `Button2`. Les valeurs attendues sont le dump normalisé des 4 tables (colonnes volatiles masquées),
  stocké dans `tests/<nom>/expected/`.
- **Données** : `Laurux01.sql` ; jeux dérivés par `gen_input.py` (fichiers CSV et requêtes
  `UPDATE Fiches_Parametres SET dnc = …` préalables).
- **Non testable automatiquement** : la musique, le `Dialog.OpenFile` (le chemin est saisi
  directement dans `Sauves`).
