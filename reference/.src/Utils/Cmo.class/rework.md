# Cmo — Rework

> Source : `.src/Utils/Cmo.class` · Message de commit (phase 4) : `reference/.src/Utils/Cmo.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 55 |
| Lignes de commentaire | 25 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 13 |
| Complexité max (fonction) | 3 (`_New`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 55 | 13 | 3 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CMO-002 — [code mort] (si 001 est refusé) Supprimer le membre `sColor` jamais lu · tests : T01 · sources : [Cmo.class:29](../../../../.src/Utils/Cmo.class#L29)

### Anomalies : changement de comportement, validation utilisateur requise
- [ ] CMO-A01 — [anomalie][code mort] Supprimer `Cmo.class` et `Cmo.form` (aucun appelant ; fonction reprise par
  `SetColors`). ⚠️ Supprimer un `.form` déroge au principe « `.form` intouchable » de PLAN.md :
  **validation utilisateur requise** avant exécution · appelants : aucun · tests : T01, T02 · sources : [Cmo.class:_New](../../../../.src/Utils/Cmo.class#L38-L50), [Cmo.class:Btn_Click](../../../../.src/Utils/Cmo.class#L86-L96)
