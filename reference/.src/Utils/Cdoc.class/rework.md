# Cdoc — Rework

> Source : `.src/Utils/Cdoc.class` · Message de commit (phase 4) : `reference/.src/Utils/Cdoc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 103 |
| Lignes de commentaire | 27 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 26 |
| Complexité max (fonction) | 6 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 103 | 26 | 6 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CDOC-001 — [documentation] Remplacer l'en-tête de licence par un en-tête signalant que
  l'écran est inaccessible et remplacé par `SetColors` · appelants : aucun · tests : T01 · sources : [Cdoc.class:1-26](../../../../.src/Utils/Cdoc.class#L1-L26)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CDOC-A01 — [code mort] Supprimer `Cdoc.class` **et** `Cdoc.form` (écran inaccessible,
  doublon de `SetColors`). Validation explicite requise : PLAN.md interdit la modification des
  `.form` · appelants : aucun · tests : T01 · sources : [Cdoc.class:_New](../../../../.src/Utils/Cdoc.class#L40-L68)
