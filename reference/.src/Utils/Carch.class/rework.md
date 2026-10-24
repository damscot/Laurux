# Carch — Rework

> Source : `.src/Utils/Carch.class` · Message de commit (phase 4) : `reference/.src/Utils/Carch.class/rework.md <REWORK_ID>`

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

- [ ] CARCH-002 — [code mort] (si 001 est refusé) Supprimer le membre `sColor` jamais lu · tests : T01 · sources : [Carch.class:28](../../../../.src/Utils/Carch.class#L28)

### Anomalies : changement de comportement, validation utilisateur requise

- [ ] CARCH-A01 — [anomalie] `Fmenu.Menu156_Click` (menu « Etiquettes ») ouvre `Carch` (couleurs des
  archives) : association menu/fenêtre incohérente, probablement morte · tests : T02 · sources : [Fmenu.class:Menu156_Click](../../../../.src/Communs/Fmenu.class#L1415-L1419)
- [ ] CARCH-A02 — [anomalie][code mort] Supprimer `Carch.class` et `Carch.form` (appelée seulement par `Fmenu.Menu156_Click` (menu parent probablement inactif, à confirmer) ; fonction reprise par
  `SetColors`). ⚠️ Supprimer un `.form` déroge au principe « `.form` intouchable » de PLAN.md :
  **validation utilisateur requise** avant exécution · appelants : `Fmenu` (supprimer `Menu156_Click` ou son contenu : handler d'un contrôle du `.form`, à arbitrer) · tests : T01, T02 · sources : [Carch.class:_New](../../../../.src/Utils/Carch.class#L37-L50), [Fmenu.class:Menu156_Click](../../../../.src/Communs/Fmenu.class#L1415-L1419)
