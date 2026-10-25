# ValidBR1 — Rework

> Source : `.src/Gestion/Stock/ValidBR1.class` · Message de commit (phase 4) : `reference/.src/Gestion/Stock/ValidBR1.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 459 |
| Lignes de commentaire | 4 |
| Fonctions | 19 |
| Fonctions Public | 13 |
| Complexité cyclomatique totale | 85 |
| Complexité max (fonction) | 15 (`ValideSaisie`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 459 | 85 | 15 | 0 | 13 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] VALIDBR1-001 — [documentation] En-tête en français : rôle (validation des BR, avec ou sans
  écriture), valeurs de `validee` (0, 1 = comptabilisée, 2 = validée seule), sélection
  fournisseurs/BR par `TriGen`, appel `Ecritures` depuis `commande1` sur l'auto-instance, défauts
  A01-A06 · appelants : aucun · tests : aucun · sources : [ValidBR1.class:_new](../../../../../.src/Gestion/Stock/ValidBR1.class#L17-L100), [ValidBR1.class:Ecritures](../../../../../.src/Gestion/Stock/ValidBR1.class#L239-L274)
- [ ] VALIDBR1-002 — [code mort] Supprimer `Dim ch As Chainage` (`_new`), `Dim i As Float`
  (`TriBr_majsel`), `vr`/`id` inutilisés de `ValideSaisie` et le bloc vide
  `If $Apdf And … Then Endif` d'`Ecritures` · appelants : aucun · tests : T01, T02, T09 ·
  sources : [ValidBR1.class:21](../../../../../.src/Gestion/Stock/ValidBR1.class#L21), [ValidBR1.class:156](../../../../../.src/Gestion/Stock/ValidBR1.class#L156), [ValidBR1.class:261-262](../../../../../.src/Gestion/Stock/ValidBR1.class#L261-L262)
- [ ] VALIDBR1-003 — [séparation traitement/GUI] `ValideSaisie` : `libel.Text` et `datej.dte`
  passés en paramètres par `valide` et `Ecritures` (valeurs identiques à la lecture actuelle) ;
  calcul des lignes dans `LignesEcriture(…) As VarEcr` sans contrôle · appelants : aucun ·
  tests : T01, T02, T06, T09 · sources : [ValidBR1.class:ValideSaisie](../../../../../.src/Gestion/Stock/ValidBR1.class#L370-L446), [ValidBR1.class:ajouligne](../../../../../.src/Gestion/Stock/ValidBR1.class#L448-L492)
- [ ] VALIDBR1-004 — [complexité] Helper privé « écriture + impression + scan » partagé par
  `valide` et `Ecritures` (ordre des appels conservé) · appelants : `commande1` (inchangé) ·
  tests : T02, T09 · sources : [ValidBR1.class:valide](../../../../../.src/Gestion/Stock/ValidBR1.class#L276-L316), [ValidBR1.class:Ecritures](../../../../../.src/Gestion/Stock/ValidBR1.class#L239-L274)
- [ ] VALIDBR1-005 — [réarchitecture] `Cbase.Table(…)` pour `TabEntrecpt`, `TabLigrecpt`,
  `TabFour`, `TabComptes`, `TabArt`, `TabFam` (noms identiques) · appelants : aucun · tests :
  T01, T02 · sources : [ValidBR1.class:_new](../../../../../.src/Gestion/Stock/ValidBR1.class#L17-L100), [ValidBR1.class:ValideSaisie](../../../../../.src/Gestion/Stock/ValidBR1.class#L370-L446)
- [ ] VALIDBR1-006 — [commonalisation] Libellé par `LVar.Calcule` (LVAR-004, prérequis) dans
  `_new` et `ValideSaisie` · appelants : aucun · tests : T02 · sources : [ValidBR1.class:94-97](../../../../../.src/Gestion/Stock/ValidBR1.class#L94-L97), [ValidBR1.class:394-402](../../../../../.src/Gestion/Stock/ValidBR1.class#L394-L402)
- [ ] VALIDBR1-007 — [commonalisation] Scan GED via `LGed.Archive`/helper commun (LGED-007,
  prérequis), lecture de `tag_def` à l'identique tant que A04 n'est pas validée · appelants :
  aucun · tests : T08 · sources : [ValidBR1.class:scanged](../../../../../.src/Gestion/Stock/ValidBR1.class#L334-L368)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] VALIDBR1-A01 — [anomalie] Écriture de TVA par `LTaxe.Montant(lpx).PuBHT.G` : correcte
  aujourd'hui grâce à LPRIX-A01 ; LTAXE-A01 et LPRIX-A01 doivent être corrigées dans le **même
  commit**, sinon la TVA est multipliée deux fois par la quantité · tests : T02 · sources : [ValidBR1.class:419](../../../../../.src/Gestion/Stock/ValidBR1.class#L419), [LTaxe.class:137](../../../../../.src/Utils/LTaxe.class#L137)
- [ ] VALIDBR1-A02 — [anomalie] `scanged` : montants inversés (`TTC = LPrix(ht)`,
  `HT = LPrix(ttc)`) sur le document GED · tests : T08 · sources : [ValidBR1.class:358-359](../../../../../.src/Gestion/Stock/ValidBR1.class#L358-L359)
- [ ] VALIDBR1-A03 — [anomalie, à confirmer] Après validation, `$selfo`/`$listbr` ne sont pas
  vidés et `ValideSaisie` ne filtre pas sur `validee` : un second clic revalide les mêmes BR et
  génère des écritures en double · tests : T05 · sources : [ValidBR1.class:valide](../../../../../.src/Gestion/Stock/ValidBR1.class#L276-L316), [ValidBR1.class:389](../../../../../.src/Gestion/Stock/ValidBR1.class#L389)
- [ ] VALIDBR1-A04 — [anomalie] Tags GED du fournisseur lus par `"… WHERE fo_code = " & four`
  (sans quotes ni `&1`) : erreur SQL pour un code non numérique (même défaut que OBJFAC-A05) ·
  tests : T08 · sources : [ValidBR1.class:350](../../../../../.src/Gestion/Stock/ValidBR1.class#L350)
- [ ] VALIDBR1-A05 — [anomalie, à confirmer] `ValidBR1.Ecritures` (appel depuis `commande1`)
  s'exécute sur l'auto-instance jamais affichée : `libel` et `datej` vides (libellé par défaut,
  date GED vide), la date d'écriture choisie dans `commande1` n'est pas reportée dans la GED ;
  fenêtre cachée conservée · tests : T09 · sources : [ValidBR1.class:Ecritures](../../../../../.src/Gestion/Stock/ValidBR1.class#L239-L274), [ValidBR1.class:360](../../../../../.src/Gestion/Stock/ValidBR1.class#L360), [commande1.class:733](../../../../../.src/Gestion/Stock/commande1.class#L733)
- [ ] VALIDBR1-A06 — [anomalie] Écran non instrumenté (`Utils.Observers` absent) : l'ajouter
  change le log de rejeu et les couleurs ; `Panel1` (filtres) désactivé définitivement après la
  première sélection ; clé de BR = numéro seul (dates différentes confondues) · tests : T03, T04 ·
  sources : [ValidBR1.class:_new](../../../../../.src/Gestion/Stock/ValidBR1.class#L17-L100), [ValidBR1.class:106](../../../../../.src/Gestion/Stock/ValidBR1.class#L106), [ValidBR1.class:162](../../../../../.src/Gestion/Stock/ValidBR1.class#L162)
