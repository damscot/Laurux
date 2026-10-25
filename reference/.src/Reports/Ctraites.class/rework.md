# Ctraites — Rework

> Source : `.src/Reports/Ctraites.class` · Message de commit (phase 4) : `reference/.src/Reports/Ctraites.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 19 |
| Lignes de commentaire | 2 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 3 |
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
| initial | `6b6b9dfc` | 2026-10-25 | 19 | 3 | 1 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CTRAITES-001 — [code mort] Supprimer `.src/Reports/Ctraites.class` (sans `.form`, jamais
  référencée : `jamais_reference` confirmé par grep et par l'historique git) ; seule méthode
  `EnteteN`, morte · appelants : aucun · tests : T01 · sources : [Ctraites.class:EnteteN](../../../../.src/Reports/Ctraites.class#L22-L30), [Ctraites.class:_new](../../../../.src/Reports/Ctraites.class#L8-L15)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : la classe n'est jamais exécutée.
