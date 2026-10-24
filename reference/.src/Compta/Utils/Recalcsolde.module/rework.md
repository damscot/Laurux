# Recalcsolde — Rework

> Source : `.src/Compta/Utils/Recalcsolde.module` · Message de commit (phase 4) : `reference/.src/Compta/Utils/Recalcsolde.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 48 |
| Lignes de commentaire | 4 |
| Fonctions | 1 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 5 |
| Complexité max (fonction) | 5 (`Calc`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 48 | 5 | 5 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RECALCSOLDE-001 — [code mort] Supprimer le module (aucun appelant, copie de `Csolde`) après
  grep de contrôle et exécution de T01 ·
  appelants : aucun · tests : T01 (avant suppression), `gbc3 -agt` · sources : [Recalcsolde.module:Calc](../../../../../.src/Compta/Utils/Recalcsolde.module#L13-L57), [Csolde.module:Recalc_solde](../../../../../.src/Utils/Csolde.module#L11-L28)
