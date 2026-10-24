# Posnum — Rework

> Source : `.src/Utils/Posnum.module` · Message de commit (phase 4) : `reference/.src/Utils/Posnum.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 45 |
| Lignes de commentaire | 4 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 21 (`Pos`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 45 | 21 | 21 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] POSNUM-001 — [code mort] Supprimer le module `Posnum` (aucun appelant, vérifié par grep) ·
  appelants : aucun · tests : `gbc3 -agt`, `./Laurux -T all` · sources : [Posnum.module:Pos](../../../../.src/Utils/Posnum.module#L6-L73)
