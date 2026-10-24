# Condition — Rework

> Source : `.src/Utils/Condition.class` · Message de commit (phase 4) : `reference/.src/Utils/Condition.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 4 |
| Lignes de commentaire | 5 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 4 | 0 | 0 | 0 | 0 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CONDITION-001 — [code mort] Supprimer `Condition.class` dans le même commit que CONDITIONS-001 ·
  appelants : `Conditions` (supprimé) · tests : T01 · sources : [Condition.class:7-10](../../../../.src/Utils/Condition.class#L7-L10)
- [ ] CONDITION-002 — [code mort] (si CONDITIONS-001 refusé) Supprimer le membre `{Table}` jamais
  utilisé · appelants : aucun · tests : CONDITIONS-T02 · sources : [Condition.class:7](../../../../.src/Utils/Condition.class#L7)
