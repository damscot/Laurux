# CheckProg — Rework

> Source : `.src/Utils/CheckProg.module` · Message de commit (phase 4) : `reference/.src/Utils/CheckProg.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 13 |
| Lignes de commentaire | 1 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 2 |
| Complexité max (fonction) | 2 (`Chk`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 13 | 2 | 2 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CHECKPROG-001 — [documentation] Commentaire de rôle en français · appelants : aucun · tests :
  aucun · sources : [CheckProg.module:Chk](../../../../.src/Utils/CheckProg.module#L3-L18)
- [ ] CHECKPROG-002 — [complexité] `Chk` sans fichier temporaire (`Shell … Wait To`), même
  résultat · appelants : aucun · tests : T01 · sources : [CheckProg.module:8-11](../../../../.src/Utils/CheckProg.module#L8-L11)
- [ ] CHECKPROG-003 — [code mort] Supprimer le module **après** la suppression de
  `Editeur.Prog_Email` (sans appelant), si elle est retenue dans le rework d'`Editeur` · appelants :
  `Editeur.module` · tests : T01 (retiré) · sources : [CheckProg.module:Chk](../../../../.src/Utils/CheckProg.module#L3-L18), [Editeur.module:Prog_Email](../../../../.src/Gestion/Impressions/Editeur.module#L22-L30)
