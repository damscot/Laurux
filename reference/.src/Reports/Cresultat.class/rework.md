# Cresultat — Rework

> Source : `.src/Reports/Cresultat.class` · Message de commit (phase 4) : `reference/.src/Reports/Cresultat.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 66 |
| Lignes de commentaire | 5 |
| Fonctions | 8 |
| Fonctions Public | 8 |
| Complexité cyclomatique totale | 12 |
| Complexité max (fonction) | 3 (`Level1`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 66 | 12 | 3 | 0 | 8 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CRESULTAT-001 — [documentation] En-tête de classe en français : gabarit du compte de
  résultat, colonnes N / N-1, règle de formatage des montants ; commentaire `'''` par méthode ·
  appelants : aucun · tests : T01, T02 · sources : [Cresultat.class:Level1](../../../../.src/Reports/Cresultat.class#L47-L59), [Cresultat.class:Level3](../../../../.src/Reports/Cresultat.class#L87-L96)
- [ ] CRESULTAT-002 — [séparation traitement/GUI] Fonction privée `MontantResultat(s) As String`
  (`Try Format$(Val(s), ",#")`) pour `Level1` et `Level7` ; rendu identique · appelants : aucun ·
  tests : T01, T03 · sources : [Cresultat.class:Level1](../../../../.src/Reports/Cresultat.class#L47-L59), [Cresultat.class:Level7](../../../../.src/Reports/Cresultat.class#L62-L72)
- [ ] CRESULTAT-003 — [code mort] Supprimer `_free`, le paramètre `detail` de `Level0` et le
  paramètre `p5` de `Level1`/`Level2` (toujours vide) en gardant deux cellules vides de 30 mm à sa
  place (rendu identique) · appelants : `RubImp` (tous les appels de `level1`, `level2`, `Level0`,
  même commit) · tests : T01, T03 · sources : [Cresultat.class:Level1](../../../../.src/Reports/Cresultat.class#L47-L59), [Cresultat.class:Level2](../../../../.src/Reports/Cresultat.class#L74-L85), [RubImp.class:1058](../../../../.src/Compta/Impressions/RubImp.class#L1058)
- [ ] CRESULTAT-004 — [commonalisation] (phase 3) Dériver de `PdfLaurux` : `_new`, `BasPage`
  standard, `Level0` via `TitreEtat(…, rempli = False)` ; PDF identique · appelants : aucun · tests :
  T01, T02 · sources : [Cresultat.class:BasPage](../../../../.src/Reports/Cresultat.class#L22-L29), [Cresultat.class:Level0](../../../../.src/Reports/Cresultat.class#L32-L44)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CRESULTAT-A01 — [anomalie, latente, à confirmer sur données réelles] `Level1`/`Level7`
  formatent par `Val(x)` sans `Utils.cpoint` : un montant décimal au point est imprimé brut, non
  formaté (même défaut que CSIG-A01) · appelants : `RubImp` · tests : T01, T03 · sources : [Cresultat.class:49](../../../../.src/Reports/Cresultat.class#L49), [Cresultat.class:64](../../../../.src/Reports/Cresultat.class#L64)
