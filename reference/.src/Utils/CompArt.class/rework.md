# CompArt — Rework

> Source : `.src/Utils/CompArt.class` · Message de commit (phase 4) : `reference/.src/Utils/CompArt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 53 |
| Lignes de commentaire | 2 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 14 |
| Complexité max (fonction) | 10 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 53 | 14 | 10 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] COMPART-001 — [séparation traitement/GUI] `ComparerArticles(sSource, sRapport) As Integer`
  sans contrôle · tests : T01-T03 · sources : [CompArt.class:Button2_Click](../../../../.src/Utils/CompArt.class#L29-L70)
- [ ] COMPART-002 — [commonalisation] Boucle de lecture et rapport `Diff.txt` partagés avec
  `ImportStk` (IMPORTSTK-003) · tests : T01, IMPORTSTK-T01 · sources : [CompArt.class:Button2_Click](../../../../.src/Utils/CompArt.class#L29-L70), [ImportStk.class:Button2_Click](../../../../.src/Utils/Exports-Imports/ImportStk.class#L29-L72)
- [ ] COMPART-003 — [réarchitecture] `Cbase.Table("TabArt")` · tests : T01 · sources : [CompArt.class:52](../../../../.src/Utils/CompArt.class#L52)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] COMPART-A01 — [anomalie] `Close` sur fichiers non ouverts si le chemin n'existe pas ; ligne sans
  `;` → erreur hors bornes · tests : T03 · sources : [CompArt.class:55](../../../../.src/Utils/CompArt.class#L55), [CompArt.class:64-65](../../../../.src/Utils/CompArt.class#L64-L65)
