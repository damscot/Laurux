# modCrBcode — Rework

> Source : `.src/Utils/modCrBcode.module` · Message de commit (phase 4) : `reference/.src/Utils/modCrBcode.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 79 |
| Lignes de commentaire | 14 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 17 |
| Complexité max (fonction) | 17 (`PrintBarcode`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 79 | 17 | 17 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] MODCRBCODE-001 — [code mort] Supprimer `modCrBcode.module` (aucun appelant ; remplacé par
  `Cdocuments.EAN13`) · appelants : aucun · tests : T01 (`gbc3 -agt`) · sources : [modCrBcode.module:PrintBarcode](../../../../.src/Utils/modCrBcode.module#L7-L103)
