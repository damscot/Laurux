# Visimpayes — Rework

> Source : `.src/Compta/Lettrages/Visimpayes.class` · Message de commit (phase 4) : `reference/.src/Compta/Lettrages/Visimpayes.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 157 |
| Lignes de commentaire | 29 |
| Fonctions | 6 |
| Fonctions Public | 6 |
| Complexité cyclomatique totale | 18 |
| Complexité max (fonction) | 7 (`recup_bl`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 157 | 18 | 7 | 0 | 6 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VISIMPAYES-001 — [documentation] En-tête corrigé (« Visualisation des impayés clients », non
  « Facturation fin de mois ») et mention « écran sans point d'entrée » en attendant la décision
  sur A01 · appelants : aucun · tests : aucun · sources : [Visimpayes.class:21-24](../../../../../.src/Compta/Lettrages/Visimpayes.class#L21-L24)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VISIMPAYES-A01 — [anomalie] Couple `Visimpayes.class` + `Visimpayes.form` mort (aucun point
  d'entrée) : suppression proposée · tests : T01 · sources : [Visimpayes.class:_New](../../../../../.src/Compta/Lettrages/Visimpayes.class#L36-L78)
- [ ] VISIMPAYES-A02 — [anomalie] `recup_bl` détruit et recrée `Facturefm`, table de travail de la
  facturation de fin de mois (`FacturefmA`, `ObjFacB`) avec une autre structure · tests : T01 · sources : [Visimpayes.class:101](../../../../../.src/Compta/Lettrages/Visimpayes.class#L101), [Visimpayes.class:102](../../../../../.src/Compta/Lettrages/Visimpayes.class#L102), [FacturefmA.class:179](../../../../../.src/Gestion/Facturation/FacturefmA.class#L179)
- [ ] VISIMPAYES-A03 — [anomalie] Suppr marque lettrées **toutes** les lignes de l'écriture
  (`where numero = &1`) dans `Fiches_Mvt`, sans lot ni SHA1 ; fiche client lue sans test
  `Available` · tests : aucun · sources : [Visimpayes.class:194](../../../../../.src/Compta/Lettrages/Visimpayes.class#L194), [Visimpayes.class:125](../../../../../.src/Compta/Lettrages/Visimpayes.class#L125)
