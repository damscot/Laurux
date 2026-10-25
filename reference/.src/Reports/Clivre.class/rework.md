# Clivre — Rework

> Source : `.src/Reports/Clivre.class` · Message de commit (phase 4) : `reference/.src/Reports/Clivre.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 142 |
| Lignes de commentaire | 14 |
| Fonctions | 19 |
| Fonctions Public | 19 |
| Complexité cyclomatique totale | 32 |
| Complexité max (fonction) | 7 (`Logo`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 142 | 32 | 7 | 0 | 19 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CLIVRE-001 — [code mort] Supprimer `.src/Reports/Clivre.class` (classe sans `.form`, jamais
  référencée : `jamais_reference` confirmé par grep, aucun chargement dynamique ; dernier appelant
  `Caisse/Moulinage` retiré par `f442d721`). Toutes ses fonctions sont mortes, dont `Logo`
  (= `Creleve.Logo`) et `Logo2` · appelants : aucun · tests : T01 · sources : [Clivre.class:newPage](../../../../.src/Reports/Clivre.class#L20-L24), [Clivre.class:Entete](../../../../.src/Reports/Clivre.class#L27-L33), [Clivre.class:Level1](../../../../.src/Reports/Clivre.class#L85-L104), [Clivre.class:Logo](../../../../.src/Reports/Clivre.class#L186-L207), [Clivre.class:Logo2](../../../../.src/Reports/Clivre.class#L171-L184), [Clivre.class:BasPage](../../../../.src/Reports/Clivre.class#L210-L216)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : la classe n'est jamais exécutée.
