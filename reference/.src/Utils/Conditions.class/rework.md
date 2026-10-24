# Conditions — Rework

> Source : `.src/Utils/Conditions.class` · Message de commit (phase 4) : `reference/.src/Utils/Conditions.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 79 |
| Lignes de commentaire | 6 |
| Fonctions | 9 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 13 (`Compute`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 79 | 21 | 13 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CONDITIONS-001 — [code mort] Supprimer `Conditions` et `Condition`, ainsi que la propriété
  `CondFormats`, `$aCondFormats` et la boucle l.160-176 de `RichDataGrid.Grid_Data` (jamais
  alimentées) · appelants : `RichDataGrid` (même commit) · tests : T01, T04 · sources : [Conditions.class:Compute](../../../../.src/Utils/Conditions.class#L59-L91), [RichDataGrid.class:160-176](../../../../.src/Utils/RichDataGrid.class#L160-L176), [RichDataGrid.class:CondFormats_Write](../../../../.src/Utils/RichDataGrid.class#L303-L307)
- [ ] CONDITIONS-002 — [réduction de portée] (si 001 refusé) `Add`, `Clear` → `Private` ou
  suppression de `Clear` ; suppression du jeu de constantes anglaises ou françaises non utilisé ·
  tests : T02, T03 · sources : [Conditions.class:Add](../../../../.src/Utils/Conditions.class#L41-L51), [Conditions.class:Clear](../../../../.src/Utils/Conditions.class#L53-L57), [Conditions.class:7-21](../../../../.src/Utils/Conditions.class#L7-L21)
- [ ] CONDITIONS-003 — [complexité] (si 001 refusé) `Select Case` sur `CompareMode` · tests : T02, T03 · sources : [Conditions.class:Compute](../../../../.src/Utils/Conditions.class#L59-L91)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CONDITIONS-A01 — [anomalie] Opérateur inconnu : réutilise le résultat de la condition
  précédente au lieu d'échouer · tests : T03 · sources : [Conditions.class:68-83](../../../../.src/Utils/Conditions.class#L68-L83)
