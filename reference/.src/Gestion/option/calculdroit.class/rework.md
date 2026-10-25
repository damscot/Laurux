# calculdroit — Rework

> Source : `.src/Gestion/option/calculdroit.class` · Message de commit (phase 4) : `reference/.src/Gestion/option/calculdroit.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 160 |
| Lignes de commentaire | 3 |
| Fonctions | 23 |
| Fonctions Public | 1 |
| Complexité cyclomatique totale | 37 |
| Complexité max (fonction) | 15 (`_new`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 160 | 37 | 15 | 0 | 1 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] CALCULDROIT-001 — [documentation] En-tête en français : formules (volume, alcool pur, droit,
  seuil de sécu, TVA), unités (cl, % vol, € par hl), arrondis à 2 décimales, taux de TVA en
  fraction, relation avec `calculdroit1` · appelants : aucun · tests : T01-T06 · sources : [calculdroit.class:_new](../../../../../.src/Gestion/option/calculdroit.class#L43-L98)
- [ ] CALCULDROIT-002 — [complexité] `_new` (CC 15) : extraire `LireRegie`, `CalculVolumes`,
  `CalculSecu` privés (même SQL, même ordre) · appelants : aucun · tests : T01-T05, T07 ·
  sources : [calculdroit.class:_new](../../../../../.src/Gestion/option/calculdroit.class#L43-L98)
- [ ] CALCULDROIT-003 — [séparation traitement/GUI] Les trois `Message.Error` de `_new` : calcul
  pur renvoyant un code d'erreur, message affiché par `_new` (texte et ordre identiques) ·
  appelants : aucun · tests : T07 · sources : [calculdroit.class:_new](../../../../../.src/Gestion/option/calculdroit.class#L43-L98)
- [ ] CALCULDROIT-004 — [complexité] Accesseurs triviaux (`lib`, `volap`, `vol`, `type`, `cptreg`,
  `codetva`, `suspendu`, `drsurfac`, `famille`, `code`, `volumess`) en `Property Read … Use $membre`
  (API inchangée) · appelants : aucun · tests : T05 · sources : [calculdroit.class:lib_Read](../../../../../.src/Gestion/option/calculdroit.class#L134-L138), [calculdroit.class:volumess_Read](../../../../../.src/Gestion/option/calculdroit.class#L234-L238)
- [ ] CALCULDROIT-005 — [réarchitecture] `Cbase.Table("TabTvav")`, `Cbase.Table("TabParam")` dans
  `_new` (SQL identique) · appelants : aucun · tests : T01-T03 · sources : [calculdroit.class:_new](../../../../../.src/Gestion/option/calculdroit.class#L43-L98)
- [ ] CALCULDROIT-006 — [commonalisation] Lecture de la régie partagée avec `calculdroit1.LecDra`
  (voir CALCULDROIT1-006, même commit) · appelants : aucun · tests : T01-T07,
  CALCULDROIT1-T06/T07 · sources : [calculdroit.class:_new](../../../../../.src/Gestion/option/calculdroit.class#L43-L98), [calculdroit1.class:LecDra](../../../../../.src/Gestion/option/calculdroit1.class#L38-L70)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] CALCULDROIT-A01 — [anomalie, à confirmer] `tauxtvadr_Read`/`tauxtvass_Read` formatent une
  fraction sur 2 décimales (`0.055` → `"0,06"`) : un lecteur qui réécrit cette valeur
  (`tauxtvadr_Write`) arrondit le taux (`Mvtex:530` écrit la valeur formatée dans `Fiches_ligregie.txtvadr`, `ObjFacB:143` la relit dans `tauxtvadr`) · tests : T06 · sources : [calculdroit.class:tauxtvadr_Read](../../../../../.src/Gestion/option/calculdroit.class#L200-L204), [calculdroit.class:tauxtvass_Read](../../../../../.src/Gestion/option/calculdroit.class#L214-L218)
- [ ] CALCULDROIT-A02 — [anomalie] TVA sécu absente des paramètres : `Message.Error` mais la sécu
  reste comptée sans TVA ; TVA de régie absente : `Return` silencieux après le message, droits à 0
  sans que l'appelant le sache ; dans ce cas, comme pour `dra` vide (`art_dra = ''`), `lib` reste
  vide car `$slib` n'est affecté qu'en l. 86 (explication possible de FACOPT-A04 ; vérifié : `lib_Read`
  renvoie bien `$slib` = `Fiches_regie.nom` dans le cas nominal, FACOPT-A04 n'est donc pas un défaut
  général de `lib_Read`) · tests : T05, T07 · sources : [calculdroit.class:55](../../../../../.src/Gestion/option/calculdroit.class#L55), [calculdroit.class:80](../../../../../.src/Gestion/option/calculdroit.class#L80)
