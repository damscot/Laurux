# FPrepRel2 — Rework

> Source : `.src/Compta/Relances/FPrepRel2.class` · Message de commit (phase 4) : `reference/.src/Compta/Relances/FPrepRel2.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 346 |
| Lignes de commentaire | 23 |
| Fonctions | 21 |
| Fonctions Public | 21 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 10 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 346 | 67 | 10 | 0 | 21 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FPREPREL2-001 — [documentation] Tant que le fichier existe : en-tête signalant qu'il n'est
  plus appelé (remplacé par `FEditrel`) et nom de fichier corrigé (`FPrepRel2`) · appelants :
  aucun · tests : aucun · sources : [FPrepRel2.class:21-24](../../../../../.src/Compta/Relances/FPrepRel2.class#L21-L24)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FPREPREL2-A01 — [anomalie] Supprimer le couple `FPrepRel2.class` + `FPrepRel2.form` (aucun
  appelant, remplacé par `FEditrel`) et mettre à jour `STRUCTURE.md` · tests : T01 · sources :
  [FPrepRel2.class:_New](../../../../../.src/Compta/Relances/FPrepRel2.class#L32-L48), [Fmenu.class:781](../../../../../.src/Communs/Fmenu.class#L781)
