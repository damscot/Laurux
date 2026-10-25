# Positions — Rework

> Source : `.src/Caisse/Positions.class` · Message de commit (phase 4) : `reference/.src/Caisse/Positions.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 1 |
| Lignes de commentaire | 1 |
| Fonctions | 0 |
| Fonctions Public | 0 |
| Complexité cyclomatique totale | 0 |
| Complexité max (fonction) | 0 |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 1 | 0 | 0 | 0 | 0 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] POSITIONS-001 — [code mort] Supprimer `Positions.class` (énumération jamais référencée,
  sans `.form`) et `reference/.src/Caisse/Positions.class/` · appelants : aucun · tests :
  `gbc3 -agt`, `./Laurux -T all` · sources : [Positions.class:3](../../../../.src/Caisse/Positions.class#L3)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune.
