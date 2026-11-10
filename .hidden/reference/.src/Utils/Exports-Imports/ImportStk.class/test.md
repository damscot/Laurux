# ImportStk — Tests

> Source : `.src/Utils/Exports-Imports/ImportStk.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| IMPORTSTK-T01 | replay | Import nominal | `stock.csv` : 3 codes existants de `Laurux01.sql` + 1 inconnu | diff `Fiches_Art` (`art_qte`, `art_stkdep`) ; `~/tmp/Diff.txt` = 1 ligne | `tests/import_nominal/` | implémenté (`assets/importstk_import_nominal/`) : `Fiches_Art` comparé ; `Diff.txt` non comparé (sortie dans le HOME) |
| IMPORTSTK-T02 | replay | Code avec espaces | ligne `" 0001 ;5"` pour un code existant `0001` | figer : aucune mise à jour, pas de ligne dans `Diff.txt` | `tests/code_espaces/` | implémenté (`assets/importstk_code_espaces/`) : UPdate sur `' 001 '` sans effet ; `Diff.txt` non comparé |
| IMPORTSTK-T03 | replay | Ligne mal formée | ligne sans `;` en 2e position | figer l'erreur d'exécution et l'état partiel de `Fiches_Art` | `tests/ligne_invalide/` | implémenté (`assets/importstk_ligne_invalide/`) : 001 mis à jour puis « Out of bounds » non interceptée ; `code_sortie` 124 provisoire (erreur fatale non détectée par le runner, voir Détail) |
| IMPORTSTK-T04 | replay | Fichier inexistant | chemin absent | figer : avertissement puis erreur sur `Close` | `tests/fichier_absent/` | implémenté (`assets/importstk_fichier_absent/`) : avertissement puis « Null object » sur `Close`, `code_sortie` 125 |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `ImportStk`, `HOME` de test
  contenant `tmp/`. `Visualiseur.Prog` lance un programme externe : le runner le neutralise (variable
  d'environnement ou `xdg-open` factice) et compare `Diff.txt`.
- Données : `Laurux01.sql` ; fichiers d'entrée générés par `gen_input.py`.
- **Scénarios synthétisés (phase 2)** : `.hidden/Tests/Utils/assets/<nom>/` (`scenario.log`, `meta.json`, fichiers d'entrée éventuels, chemins relatifs à la racine du clone) ; jeux dans `.src/Tests/Framework/datasets/`. Attendus à produire par `runner replay Utils/<nom> --expected` quand les rejeux seront rétablis.
- **Rejeu (2026-11-09)** : Le fichier d'entrée est saisi en **chemin absolu** vers le clone rework (`<REWORK>/.hidden/Tests/Utils/assets/<nom>/<fichier>.csv`) : un chemin relatif est résolu dans l'archive exécutable, qui ne contient pas `.src/Tests`. Le clone rework est monté au même chemin pour les deux rejeux : même fichier. Chemin propre au bac (`/home/damscot/.cache/laurux-sandbox/sb2/rework`) : à réécrire vers la racine du dépôt lors de l'intégration, puis régénérer les attendus. T01 : `002;3,5` donne `art_qte` = 3 (virgule tronquée par MySQL, candidat anomalie). T03 : Erreur « Out of bounds » non interceptée : la pile `Classe.Méthode.ligne:` est affichée, mais collée à un fragment de la trace du rejeu (stdout de gbr3 vidé par blocs de 4 Ko, stderr non tamponné) ; `FATAL_RE` du runner, ancré en début de ligne, ne la reconnaît pas et le rejeu finit en délai dépassé. `code_sortie` figé à 124 en attendant que le runner détecte l'erreur (125). T04 : la pile n'est précédée d'aucune trace (sortie < 4 Ko), erreur détectée, `code_sortie` 125.
