# ticpe — Rework

> Source : `.src/Gestion/option/ticpe.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/ticpe.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 40 |
| Lignes de commentaire | 1 |
| Fonctions | 4 |
| Fonctions Public | 3 |
| Complexité cyclomatique totale | 9 |
| Complexité max (fonction) | 5 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 40 | 9 | 5 | 0 | 3 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TICPE-001 — [documentation] En-tête : ébauche de règle TICPE (catégories GNR agricole /
  carburant, table `Art_Tipp`), état non implémenté, aucun appelant · appelants : aucun · tests :
  T01-T03 · sources : [ticpe.class:_new](../../../../../.src/Gestion/option/ticpe.class#L19-L35), [ticpe.class:_call](../../../../../.src/Gestion/option/ticpe.class#L37-L44)
- [ ] TICPE-002 — [code mort] Supprimer `Valide` (jamais appelée, requête invalide) et la variable
  `$val` (jamais utilisée) · appelants : aucun · tests : T01-T03 · sources : [ticpe.class:Valide](../../../../../.src/Gestion/option/ticpe.class#L46-L55), [ticpe.class:10](../../../../../.src/Gestion/option/ticpe.class#L10)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TICPE-A01 — [anomalie, décision utilisateur] Classe-ébauche sans appelant : achever (paramètre
  `client` optionnel pour l'auto-instance, propriétés alimentées, usage par `Parametre`) ou
  supprimer · tests : T01-T03 · sources : [ticpe.class:_new](../../../../../.src/Gestion/option/ticpe.class#L19-L35), [Parametre.class:630](../../../../../.src/Communs/Parametre.class#L630)
