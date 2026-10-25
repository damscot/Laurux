# Dymo — Rework

> Source : `.src/Gestion/Etiquettes/Dymo.module` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/Dymo.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 19 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 1 |
| Complexité max (fonction) | 1 (`Gondole1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 19 | 1 | 1 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] DYMO-001 — [code mort] Supprimer `Dymo.module` : `Gondole1` jamais appelé, copie exacte de
  `Zebra.Gondole1` ; le nom `Dymo` reste celui du RadioButton des six écrans d'étiquettes ·
  appelants : aucun · tests : DYMO-T01 (avant suppression), `gbc3 -agt`, replays « Dymo »
  d'ETIQART/ETIGOND/ETIQCASIER · sources : [Dymo.module:Gondole1](../../../../../.src/Gestion/Etiquettes/Dymo.module#L3-L23), [Zebra.module:Gondole1](../../../../../.src/Gestion/Etiquettes/Zebra.module#L4-L24)

### Anomalies : changement de comportement, validation utilisateur requise

_Aucune propre à ce module (les défauts du flux ZPL sont suivis dans ZEBRA-A01/A02)._
