# RazInv — Rework

> Source : `.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class/rework.md <REWORK_ID>`

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

- [ ] RAZINV-001 — [documentation] En-tête de classe en français (rôle, table de travail
  `Fiches_Inv`, absence de contrôle d'état, écrans rendus inopérants) · appelants : aucun · tests :
  T01-T03 · sources : [RazInv.class:_new](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class#L3-L8)
- [ ] RAZINV-002 — [séparation traitement/GUI] Extraire le `DROP` dans une fonction privée
  `Supprimer() As Boolean` (même SQL, `Try` conservé) ; le handler garde la question et le message ·
  appelants : aucun · tests : T01-T03 · sources : [RazInv.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class#L16-L23)
- [ ] RAZINV-003 — [commonalisation] Utiliser `Inventaire.Supprimer("F")` du socle commun
  inventaire (voir GENINV-006), partagé avec `RazInvT`, `Geninv`, `GeninvT` ; SQL identique ·
  appelants : aucun · tests : T01-T03, RAZINVT-T01..T03 · sources : [RazInv.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class#L16-L23), [RazInvT.class:Button1_Click](../../../../../../../.src/Gestion/Stock/Inventaires/Tournant/RazInvT.class#L16-L23)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RAZINV-A01 — [anomalie] Le `Try` masque l'échec du `DROP` : « Inventaire effacé ! » est
  affiché même si la table n'a pas été supprimée, et aucun avertissement n'est donné si l'inventaire
  contient des comptages saisis · tests : T01, T03 · sources : [RazInv.class:19](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class#L19), [RazInv.class:20](../../../../../../../.src/Gestion/Stock/Inventaires/Fin-annee/RazInv.class#L20)
