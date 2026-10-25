# Cecheancier — Rework

> Source : `.src/Reports/Cecheancier.class` · Message de commit (phase 4) : `reference/.src/Reports/Cecheancier.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 39 |
| Lignes de commentaire | 4 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 1 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 39 | 6 | 1 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CECHEANCIER-001 — [code mort] Supprimer `.src/Reports/Cecheancier.class` (sans `.form`,
  jamais référencée : `jamais_reference` confirmé par grep et par l'historique git) ; fonctions
  mortes `Entete`, `BasPage`, `Level0`, `Level2` · appelants : aucun · tests : T01 · sources : [Cecheancier.class:Entete](../../../../.src/Reports/Cecheancier.class#L22-L30), [Cecheancier.class:BasPage](../../../../.src/Reports/Cecheancier.class#L33-L40), [Cecheancier.class:Level0](../../../../.src/Reports/Cecheancier.class#L42-L48), [Cecheancier.class:Level2](../../../../.src/Reports/Cecheancier.class#L52-L63)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : la classe n'est jamais exécutée.
