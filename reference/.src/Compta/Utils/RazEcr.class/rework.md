# RazEcr — Rework

> Source : `.src/Compta/Utils/RazEcr.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/RazEcr.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 10 |
| Lignes de commentaire | 4 |
| Fonctions | 4 |
| Fonctions Public | 4 |
| Complexité cyclomatique totale | 4 |
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
| initial | `6b6b9dfc` | 2026-10-24 | 10 | 4 | 1 | 0 | 4 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZECR-001 — [documentation] Commentaire d'en-tête : écran sans effet, en attente de
  suppression (RAZECR-A01) · appelants : aucun · tests : T01 · sources : [RazEcr.class:Raz](../../../../../.src/Compta/Utils/RazEcr.class#L7-L13)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZECR-A01 — [anomalie] Couple `RazEcr.class` + `RazEcr.form` sans effet (corps de `Raz`
  commenté) : supprimer le couple et l'entrée `RazEcr` de `Prgm` · tests : T01, PRGM-T02 · sources : [RazEcr.class:Raz](../../../../../.src/Compta/Utils/RazEcr.class#L7-L13), [Prgm.class:78](../../../../../.src/Communs/Prgm.class#L78)
