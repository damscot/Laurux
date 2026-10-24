# EcrReg — Rework

> Source : `.src/Compta/Utils/EcrReg.class` · Message de commit (phase 4) : `reference/.src/Compta/Utils/EcrReg.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 135 |
| Lignes de commentaire | 1 |
| Fonctions | 3 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 21 |
| Complexité max (fonction) | 18 (`reglement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 135 | 21 | 18 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ECRREG-001 — [documentation] En-tête : ordre des constructeurs, lignes produites par état,
  rôle de `cptint` · appelants : aucun · tests : aucun · sources : [EcrReg.class:_new](../../../../../.src/Compta/Utils/EcrReg.class#L8-L16)
- [ ] ECRREG-002 — [code mort] Supprimer `_call` et `Create Static` (aucun appelant) · appelants :
  aucun · tests : T01-T07 · sources : [EcrReg.class:_call](../../../../../.src/Compta/Utils/EcrReg.class#L18-L25), [EcrReg.class:3](../../../../../.src/Compta/Utils/EcrReg.class#L3)
- [ ] ECRREG-003 — [code mort] Supprimer les `trouve`/`modifi` sans effet (objets modifiés en place)
  · appelants : aucun · tests : T02-T05 · sources : [EcrReg.class:63](../../../../../.src/Compta/Utils/EcrReg.class#L63), [EcrReg.class:80](../../../../../.src/Compta/Utils/EcrReg.class#L80), [EcrReg.class:87-89](../../../../../.src/Compta/Utils/EcrReg.class#L87-L89), [EcrReg.class:114-116](../../../../../.src/Compta/Utils/EcrReg.class#L114-L116), [EcrReg.class:124](../../../../../.src/Compta/Utils/EcrReg.class#L124), [EcrReg.class:131](../../../../../.src/Compta/Utils/EcrReg.class#L131)
- [ ] ECRREG-004 — [complexité] Une fonction privée par état + helper `Contrepartie(…)` (CC 18 →
  ≤ 6 par fonction) · appelants : aucun · tests : T01-T05 · sources : [EcrReg.class:reglement](../../../../../.src/Compta/Utils/EcrReg.class#L27-L155)
- [ ] ECRREG-005 — [commonalisation] `Cbase.Table("TabComptes")` pour `Fiches_Comptes` (SQL identique)
  · appelants : aucun · tests : T02, T03 · sources : [EcrReg.class:64](../../../../../.src/Compta/Utils/EcrReg.class#L64), [EcrReg.class:107](../../../../../.src/Compta/Utils/EcrReg.class#L107)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ECRREG-A01 — [anomalie] `Fiches_Comptes` lu sans test `Available` (`L_modif`, `L_valide`) :
  erreur si un compte de ligne ou la banque du journal n'existe pas · tests : T02, T03 · sources :
  [EcrReg.class:64-65](../../../../../.src/Compta/Utils/EcrReg.class#L64-L65), [EcrReg.class:107-108](../../../../../.src/Compta/Utils/EcrReg.class#L107-L108)
