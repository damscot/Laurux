# EntreeItem — Rework

> Source : `.src/Gestion/Lcr/EntreeItem.module` · Message de commit (phase 4) : `reference/.src/Gestion/Lcr/EntreeItem.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 14 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 6 |
| Complexité max (fonction) | 6 (`item`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 14 | 6 | 6 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ENTREEITEM-001 — [documentation] En-tête en français : rôle du code entrée LCR, correspondance
  avec les listes de `Preparation.form`/`Glcr.form` et avec le fichier bancaire de `Bordrx` ;
  commentaire `'''` sur `item` (valeur hors plage → `""`) · appelants : aucun · tests : T01, T02 ·
  sources : [EntreeItem.module:item](../../../../../.src/Gestion/Lcr/EntreeItem.module#L3-L24)
- [ ] ENTREEITEM-002 — [complexité] Remplacer le `Select Case` par un tableau constant de libellés
  indexé par le code (CC 6 → 2), résultat identique y compris hors plage · appelants : aucun
  (`Preparation` inchangé) · tests : T01, T02 · sources : [EntreeItem.module:item](../../../../../.src/Gestion/Lcr/EntreeItem.module#L3-L24)

### Anomalies : changement de comportement, validation utilisateur requise

Aucune anomalie relevée.
