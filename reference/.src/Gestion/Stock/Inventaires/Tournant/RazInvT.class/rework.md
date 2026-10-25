# RazInvT — Rework

> Source : `.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 13 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 3 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 13 | 5 | 3 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RAZINVT-001 — [documentation] En-tête de classe en français (rôle, `Fiches_InvT`,
  historique non touché, état après `ValidinvT`) · appelants : aucun · tests : T01-T03 · sources : [RazInvT.class:_new](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class#L3-L8)
- [ ] RAZINVT-002 — [séparation traitement/GUI] Extraire le `DROP` dans une fonction privée (même
  SQL) · appelants : aucun · tests : T01-T03 · sources : [RazInvT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class#L16-L23)
- [ ] RAZINVT-003 — [commonalisation] `Inventaire.Supprimer("T")` du socle commun (voir
  GENINV-006, RAZINV-003) ; SQL identique · appelants : aucun · tests : T01-T03 · sources : [RazInvT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class#L16-L23), [RazInv.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class#L16-L23)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZINVT-A01 — [anomalie] Comme RAZINV-A01 : « Inventaire effacé ! » affiché même si le `DROP`
  échoue (erreur absorbée par `Try`) · tests : T01, T03 · sources : [RazInvT.class:19](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class#L19), [RazInvT.class:20](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class#L20)
