# Epurfour — Rework

> Source : `.src/Utils/Epurfour.class` · Message de commit (phase 4) : `reference/.src/Utils/Epurfour.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 12 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 3 |
| Complexité max (fonction) | 3 (`run`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 12 | 3 | 3 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EPURFOUR-001 — [documentation] En-tête : rôle, irréversibilité · tests : aucun · sources : [Epurfour.class:run](../../../../.src/Utils/Epurfour.class#L3-L17)
- [ ] EPURFOUR-002 — [complexité] Un seul `UPDATE` sans boucle, en conservant le `SELECT` qui
  conditionne le message · tests : T01, T02 · sources : [Epurfour.class:8-13](../../../../.src/Utils/Epurfour.class#L8-L13)
- [ ] EPURFOUR-003 — [séparation traitement/GUI] `ViderRefFournisseurs()` sans message · tests : T01 · sources : [Epurfour.class:run](../../../../.src/Utils/Epurfour.class#L3-L17)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] EPURFOUR-A01 — [anomalie] Effacement de toutes les références fournisseurs sans confirmation ·
  tests : T01 · sources : [Epurfour.class:run](../../../../.src/Utils/Epurfour.class#L3-L17)
