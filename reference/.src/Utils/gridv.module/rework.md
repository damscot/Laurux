# gridv — Rework

> Source : `.src/Utils/gridv.module` · Message de commit (phase 4) : `reference/.src/Utils/gridv.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 56 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 10 |
| Complexité max (fonction) | 10 (`ajoustat`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 56 | 10 | 10 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GRIDV-001 — [code mort] Supprimer `.src/Utils/gridv.module` (aucun appelant ; 35 lignes
  dupliquées de `gridvi`) · appelants : aucun · tests : T01, GRIDVI-T01 à T08 · sources : [gridv.module:ajoustat](../../../../.src/Utils/gridv.module#L3-L69)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune.
