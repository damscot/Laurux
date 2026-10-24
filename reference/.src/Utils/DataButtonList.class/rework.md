# DataButtonList — Rework

> Source : `.src/Utils/DataButtonList.class` · Message de commit (phase 4) : `reference/.src/Utils/DataButtonList.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 247 |
| Lignes de commentaire | 44 |
| Fonctions | 37 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 71 |
| Complexité max (fonction) | 13 (`LoadValues`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 247 | 71 | 13 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DATABUTTONLIST-001 — [code mort] Supprimer `.src/Utils/DataButtonList.class` (aucun
  appelant, aucun `.form`, aucune référence en chaîne) · appelants : aucun · tests : T01 · sources : [DataButtonList.class:_New](../../../../.src/Utils/DataButtonList.class#L46-L90)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : le défaut latent de `Tag_Write` disparaît avec la suppression.
