# RenMvt — Rework

> Source : `.src/Compta/Utils/RenMvt.module` · Message de commit (phase 4) : `reference/.src/Compta/Utils/RenMvt.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 20 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 7 |
| Complexité max (fonction) | 4 (`Ren`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 48 | 7 | 4 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RENMVT-001 — [documentation] En-tête : script de reprise ponctuel, données attendues
  (journal 80, numéros préfixés), effets destructeurs · appelants : aucun · tests : T01 · sources : [RenMvt.module:Run](../../../../../.src/Compta/Utils/RenMvt.module#L3-L26)
- [ ] RENMVT-002 — [code mort] Supprimer `Ren` (aucun appelant) · appelants : aucun · tests :
  `gbc3 -agt`, T01 · sources : [RenMvt.module:Ren](../../../../../.src/Compta/Utils/RenMvt.module#L28-L77)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RENMVT-A01 — [anomalie] `DELETE` sur le numéro tronqué `nm` au lieu du numéro de l'écriture
  copiée : l'écriture reste dans `Fiches_Mvt` et une autre écriture peut être supprimée · tests :
  T01 · sources : [RenMvt.module:20](../../../../../.src/Compta/Utils/RenMvt.module#L20)
- [ ] RENMVT-A02 — [anomalie] Pas de test `Available` : erreur d'exécution sans journal 80 ;
  colonnes `control`, `numerodef`, `dateech`… non copiées (inaltérabilité rompue) · tests : T01,
  T02 · sources : [RenMvt.module:12](../../../../../.src/Compta/Utils/RenMvt.module#L12), [RenMvt.module:19](../../../../../.src/Compta/Utils/RenMvt.module#L19)
- [ ] RENMVT-A03 — [anomalie] Script ponctuel destructeur accessible par `Prgm` sans confirmation :
  retirer le module et l'entrée `RenMvt` de `Prgm` (avec PRGM-A02) · tests : T03 · sources : [RenMvt.module:Run](../../../../../.src/Compta/Utils/RenMvt.module#L3-L26), [Prgm.class:82](../../../../../.src/Communs/Prgm.class#L82)
