# Enrgcp — Rework

> Source : `.src/Utils/Enrgcp.module` · Message de commit (phase 4) : `reference/.src/Utils/Enrgcp.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 7 |
| Lignes de commentaire | 2 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`Ecp`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 7 | 3 | 3 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ENRGCP-001 — [documentation] Commentaire `'''` sur `Ecp` (paramètres, effet, cas du CP vide) ·
  appelants : aucun · tests : aucun · sources : [Enrgcp.module:Ecp](../../../../.src/Utils/Enrgcp.module#L4-L13)
- [ ] ENRGCP-002 — [commonalisation] `Impcpostaux` appelle `Enrgcp.Ecp` au lieu de recopier le
  `SELECT`/`INSERT` (à faire dans le même commit que le rework d'`Impcpostaux`) · appelants :
  `Impcpostaux` · tests : T01, T02, replay d'import des codes postaux (IMPCPOSTAUX) · sources : [Enrgcp.module:Ecp](../../../../.src/Utils/Enrgcp.module#L4-L13), [Impcpostaux.class:37-38](../../../../.src/Utils/Exports-Imports/Impcpostaux.class#L37-L38)
