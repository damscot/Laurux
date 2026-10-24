# Cprod — Rework

> Source : `.src/Utils/Cprod.class` · Message de commit (phase 4) : `reference/.src/Utils/Cprod.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 86 |
| Lignes de commentaire | 25 |
| Fonctions | 5 |
| Fonctions Public | 5 |
| Complexité cyclomatique totale | 20 |
| Complexité max (fonction) | 6 (`Coul_Dblclick`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 86 | 20 | 6 | 0 | 5 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CPROD-002 — [code mort] (si 001 est refusé) Supprimer le membre `sColor` jamais lu, la branche `Case 5` inatteignable et le `Music.Load` inutile · tests : T01 · sources : [Cprod.class:28](../../../../.src/Utils/Cprod.class#L28), [Cprod.class:85-88](../../../../.src/Utils/Cprod.class#L85-L88), [Cprod.class:41](../../../../.src/Utils/Cprod.class#L41)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CPROD-A01 — [anomalie] `Case 5` : `Val(Facture)` sur le nom de la classe `Facture` (erreur
  d'exécution si un contrôle recevait `Tag = 5`) · tests : T01 · sources : [Cprod.class:86](../../../../.src/Utils/Cprod.class#L86)
- [ ] CPROD-A02 — [anomalie][code mort] Supprimer `Cprod.class` et `Cprod.form` (aucun appelant ; fonction reprise par
  `SetColors`). ⚠️ Supprimer un `.form` déroge au principe « `.form` intouchable » de PLAN.md :
  **validation utilisateur requise** avant exécution · appelants : aucun · tests : T01, T02 · sources : [Cprod.class:_New](../../../../.src/Utils/Cprod.class#L39-L63), [Cprod.class:Btn_Click](../../../../.src/Utils/Cprod.class#L122-L136)
