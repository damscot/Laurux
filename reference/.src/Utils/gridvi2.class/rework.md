# gridvi2 — Rework

> Source : `.src/Utils/gridvi2.class` · Message de commit (phase 4) : `reference/.src/Utils/gridvi2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 387 |
| Lignes de commentaire | 15 |
| Fonctions | 13 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 92 |
| Complexité max (fonction) | 20 (`bouton_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 387 | 92 | 20 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] GRIDVI2-001 — [code mort] Supprimer `.src/Utils/gridvi2.class` (aucun appelant, aucun
  `.form`, aucune référence en chaîne ; 86 lignes dupliquées de `gridvi`) · appelants : aucun ·
  tests : T01, GRIDVI-T01 à T08 · sources : [gridvi2.class:_new](../../../../.src/Utils/gridvi2.class#L16-L82)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune : les défauts relevés dans architecture.md (`resbl!marge` absent pour le type `M`, bornes de
dates incohérentes) disparaissent avec la suppression.
