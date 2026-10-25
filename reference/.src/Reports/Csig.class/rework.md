# Csig — Rework

> Source : `.src/Reports/Csig.class` · Message de commit (phase 4) : `reference/.src/Reports/Csig.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 188 |
| Lignes de commentaire | 23 |
| Fonctions | 14 |
| Fonctions Public | 14 |
| Complexité cyclomatique totale | 72 |
| Complexité max (fonction) | 25 (`Level1S`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 188 | 72 | 25 | 0 | 14 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CSIG-001 — [documentation] En-tête de classe en français : gabarit paysage des SIG, trois
  colonnes et leurs abscisses, règle de formatage des montants (`Val` localisé, chaîne brute en cas
  d'échec) ; commentaire `'''` par méthode · appelants : aucun · tests : T01-T03 · sources : [Csig.class:Level1](../../../../.src/Reports/Csig.class#L48-L76), [Csig.class:Lines3](../../../../.src/Reports/Csig.class#L248-L256)
- [ ] CSIG-002 — [code mort] Supprimer `Level1L`, `Level1A`, `Level1S`, `Level7` (aucun appelant,
  vérifié par grep) et `_free` · appelants : aucun · tests : T01-T04 · sources : [Csig.class:Level1L](../../../../.src/Reports/Csig.class#L107-L154), [Csig.class:Level1A](../../../../.src/Reports/Csig.class#L157-L164), [Csig.class:Level1S](../../../../.src/Reports/Csig.class#L166-L214), [Csig.class:Level7](../../../../.src/Reports/Csig.class#L217-L227), [Csig.class:_free](../../../../.src/Reports/Csig.class#L17-L19)
- [ ] CSIG-003 — [séparation traitement/GUI] Fonction privée `MontantSig(s) As String`
  (`Try Format$(Val(s), ",#")`, `"0"` → `""` selon le niveau) utilisée par `Level1` et `Level2` ;
  rendu identique · appelants : aucun · tests : T02, T04 · sources : [Csig.class:Level1](../../../../.src/Reports/Csig.class#L48-L76), [Csig.class:Level2](../../../../.src/Reports/Csig.class#L78-L94)
- [ ] CSIG-004 — [code mort] Supprimer le paramètre inutilisé `detail` de `Level0` · appelants :
  `Imp_Sig:449`, `Imp_Sig:461` (même commit) · tests : T01, T04 · sources : [Csig.class:Level0](../../../../.src/Reports/Csig.class#L32-L45), [Imp_Sig.module:449](../../../../.src/Compta/Impressions/Imp_Sig.module#L449)
- [ ] CSIG-005 — [commonalisation] (phase 3) Dériver de `PdfLaurux` : `BasPage` (largeur 290),
  `Level0` via `TitreEtat` partagé avec `Cbilan`/`Cresultat`, `Lines*` → `Integer` ; PDF identique ·
  appelants : aucun · tests : T01, T03 · sources : [Csig.class:BasPage](../../../../.src/Reports/Csig.class#L22-L29), [Csig.class:Level0](../../../../.src/Reports/Csig.class#L32-L45), [Cbilan.class:Level0](../../../../.src/Reports/Cbilan.class#L32-L45)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CSIG-A01 — [anomalie, latente, à confirmer sur données réelles] `Level1`/`Level2` formatent par
  `Val(x)` sans `Utils.cpoint` : un montant décimal au point (`"1234.56"`) est imprimé brut, non
  formaté, alors qu'un entier l'est (`1 234`). Correction : `Val(Utils.cpoint(x))` comme `Cbilan` ·
  appelants : `Imp_Sig` · tests : T02, T04 · sources : [Csig.class:64](../../../../.src/Reports/Csig.class#L64), [Csig.class:80](../../../../.src/Reports/Csig.class#L80)
