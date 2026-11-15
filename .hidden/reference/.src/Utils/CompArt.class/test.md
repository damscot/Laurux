# CompArt — Tests

> Source : `.src/Utils/CompArt.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| COMPART-T01 | replay | Comparaison nominale | fichier de 5 lignes dont 2 codes absents de `Laurux01.sql` | `~/tmp/Diff.txt` = 2 lignes | `tests/comparaison/` | implémenté (scénario Utils/compart_comparaison : chemin saisi dans ChemFic, fichier déposé par entrees en /tmp/laurux-test ; ~/tmp/Diff.txt comparé) |
| COMPART-T02 | replay | Tous présents | fichier de codes existants | message seul, pas de visualiseur, `Diff.txt` vide | `tests/tous_presents/` | implémenté (scénario Utils/compart_tous_presents : Diff.txt vide) |
| COMPART-T03 | replay | Ligne sans `;` / fichier absent | ligne `ABC` ; chemin inexistant | figer les erreurs d'exécution | `tests/erreurs/` | implémenté (scénarios Utils/compart_ligne_sans_separateur « Out of bounds » et compart_fichier_absent « Null object » : erreurs fatales figées, code 125) |

## Détail des tests

- Capture dans le clone **Laurux non modifié** via « Appel programme » → `CompArt` ; `HOME` de test
  avec `tmp/` ; `Visualiseur.Prog` neutralisé. Comparaison de `Diff.txt` ; diff BDD vide.
- **Implémentation (phase 2, vague 7)** : scénarios `.hidden/Tests/Utils/assets/compart_*` (Prgm « CompArt ») : chemin tapé dans `ChemFic` (le dialogue `Svs` n'est pas utilisé), fichiers `compart_shared/*.csv` déposés en `/tmp/laurux-test/codes.csv` par `entrees`, `CmdVis` factice (`true`), `~/tmp/Diff.txt` comparé ; écran ShowModal non refermé (REPLAYOBSERVER-A15).
