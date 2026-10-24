# CompArt — Tests

> Source : `.src/Utils/CompArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMPART-T01 | replay | Comparaison nominale | fichier de 5 lignes dont 2 codes absents de `Laurux01.sql` | `~/tmp/Diff.txt` = 2 lignes | `tests/comparaison/` | à faire |
| COMPART-T02 | replay | Tous présents | fichier de codes existants | message seul, pas de visualiseur, `Diff.txt` vide | `tests/tous_presents/` | à faire |
| COMPART-T03 | replay | Ligne sans `;` / fichier absent | ligne `ABC` ; chemin inexistant | figer les erreurs d'exécution | `tests/erreurs/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `CompArt` ; `HOME` de test
  avec `tmp/` ; `Visualiseur.Prog` neutralisé. Comparaison de `Diff.txt` ; diff BDD vide.
