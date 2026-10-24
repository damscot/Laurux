# Impcpostaux — Tests

> Source : `.src/Utils/Exports-Imports/Impcpostaux.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPCPOSTAUX-T01 | replay | Import nominal | `Cpostaux.csv` : 5 lignes dont 1 cp à 4 chiffres et 1 doublon existant | diff `Fiches_Cpostaux` (4 insertions, cp complété) | `tests/import_nominal/` | à faire |
| IMPCPOSTAUX-T02 | replay | Réimport | même fichier importé deux fois | aucune insertion au second passage | `tests/reimport/` | à faire |
| IMPCPOSTAUX-T03 | replay | Ligne sans `;` et cp vide | ligne `PARIS` ; ligne `PARIS;` | figer les lignes insérées (anomalies A01, A03) | `tests/ligne_invalide/` | à faire |
| IMPCPOSTAUX-T04 | replay | Fichier absent | chemin inexistant | avertissement, table inchangée | `tests/fichier_absent/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** (menu « Import des codes postaux », chemin saisi dans
  `FilePath`, `Button1`). Comparaison du dump trié de `Fiches_Cpostaux`.
- Fichiers d'entrée générés par `gen_input.py` à partir de `Laurux01.sql`.
- Le `FileChooser` intégré n'est pas piloté (chemin saisi directement).
