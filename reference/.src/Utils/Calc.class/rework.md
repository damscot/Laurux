# Calc — Rework

> Source : `.src/Utils/Calc.class` · Message de commit (phase 4) : `reference/.src/Utils/Calc.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 213 |
| Lignes de commentaire | 6 |
| Fonctions | 32 |
| Fonctions Public | 32 |
| Complexité cyclomatique totale | 76 |
| Complexité max (fonction) | 14 (`Box1_KeyPress`) |
| Variables globales | 1 |
| Variables Public | 1 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 213 | 76 | 14 | 1 | 32 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

_Aucune : les défauts relevés (pourcentage toujours nul car `a` jamais affecté, signe initial perdu
dans `calcul`, `*`/`/` combinés avec `Mt2 = "0"`) disparaissent avec la suppression du code mort et
ne sont observables par aucun utilisateur._
- [ ] CALC-A01 — [anomalie][code mort] Supprimer `Calc.class` et `Calc.form` (aucun appelant ; remplacée par
  `FCalc`), dans le même commit que FCALC-002 (suppression de `FCalc.GetParent() As Calc`) ·
  appelants : `FCalc` · tests : T01, FCALC-T01..T05 · sources : [Calc.class:calcul](../../../../.src/Utils/Calc.class#L217-L260), [Calc.class:pourcentage_Click](../../../../.src/Utils/Calc.class#L138-L154), [FCalc.class:GetParent](../../../../.src/Utils/FCalc.class#L101-L105)
