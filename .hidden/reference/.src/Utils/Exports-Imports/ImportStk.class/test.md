# ImportStk — Tests

> Source : `.src/Utils/Exports-Imports/ImportStk.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPORTSTK-T01 | replay | Import nominal | `stock.csv` : 3 codes existants de `Laurux01.sql` + 1 inconnu | diff `Fiches_Art` (`art_qte`, `art_stkdep`) ; `~/tmp/Diff.txt` = 1 ligne | `tests/import_nominal/` | à faire |
| IMPORTSTK-T02 | replay | Code avec espaces | ligne `" 0001 ;5"` pour un code existant `0001` | figer : aucune mise à jour, pas de ligne dans `Diff.txt` | `tests/code_espaces/` | à faire |
| IMPORTSTK-T03 | replay | Ligne mal formée | ligne sans `;` en 2e position | figer l'erreur d'exécution et l'état partiel de `Fiches_Art` | `tests/ligne_invalide/` | à faire |
| IMPORTSTK-T04 | replay | Fichier inexistant | chemin absent | figer : avertissement puis erreur sur `Close` | `tests/fichier_absent/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `ImportStk`, `HOME` de test
  contenant `tmp/`. `Visualiseur.Prog` lance un programme externe : le runner le neutralise (variable
  d'environnement ou `xdg-open` factice) et compare `Diff.txt`.
- Données : `Laurux01.sql` ; fichiers d'entrée générés par `gen_input.py`.
