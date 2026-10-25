# EtiqRecpt — Rework

> Source : `.src/Gestion/Etiquettes/EtiqRecpt.class` · Message de commit (phase 4) : `reference/.src/Gestion/Etiquettes/EtiqRecpt.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 322 |
| Lignes de commentaire | 31 |
| Fonctions | 11 |
| Fonctions Public | 11 |
| Complexité cyclomatique totale | 68 |
| Complexité max (fonction) | 36 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 322 | 68 | 36 | 0 | 11 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] ETIQRECPT-001 — [documentation] En-tête en français : files `Fiches_EtiProd` (produit +
  casier) et `Fiches_EtiGond`, écrivains, effacement après impression, repli sur `art_cfour` ·
  appelants : aucun · tests : T01 · sources : [EtiqRecpt.class:_New](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L49-L70), [EtiqRecpt.class:Calc_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L90-L119)
- [ ] ETIQRECPT-002 — [code mort] Supprimer membres et variables jamais lus (`SorP`, couleurs,
  `dte`, `rect`, `fami`, `fourn`) et `Shell "cd ~"` · appelants : aucun · tests :
  T02-T04 · sources : [EtiqRecpt.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L121-L310), [EtiqRecpt.class:179](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L179)
- [ ] ETIQRECPT-003 — [complexité] `Button4_Click` : un seul `DELETE FROM <file>` au lieu d'un
  `DELETE … WHERE code = &1` par ligne (SQL modifié, dump identique) ; `Calc_Etiq` : `SUM(nombre)`
  (SQL modifié, affichage identique) · appelants : aucun · tests : T01, T03, T04 · sources : [EtiqRecpt.class:Button4_Click](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L352-L372), [EtiqRecpt.class:Calc_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L90-L119)
- [ ] ETIQRECPT-004 — [complexité] `Button2_Click` (CC 36) : `LitArticle`, dessins par type, boucle ;
  appels PDF dans le même ordre · appelants : aucun · tests : T02-T05 · sources : [EtiqRecpt.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L121-L310)
- [ ] ETIQRECPT-005 — [réduction de portée] `init_ComboBox`, `Calc_Etiq`, `pos_Etiq` → `Private` ·
  appelants : aucun · tests : T01-T05 · sources : [EtiqRecpt.class:init_ComboBox](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L72-L88), [EtiqRecpt.class:Calc_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L90-L119), [EtiqRecpt.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L312-L344)
- [ ] ETIQRECPT-006 — [commonalisation] Format, ouverture PDF, `pos_Etiq` (V2, identique à
  `Etigond.pos_Etiq`) et dessins produit/gondole/casier via `PlancheEtiquettes` (après
  ETIQART-010, ETIGOND-009, ETIQCASIER-009) ; PDF identique à prouver · appelants : aucun · tests :
  T02-T04, T07 · sources : [EtiqRecpt.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L312-L344), [EtiqRecpt.class:Button2_Click](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L121-L310), [Etigond.class:pos_Etiq](../../../../../.src/Gestion/Etiquettes/Etigond.class#L997-L1029)
- [ ] ETIQRECPT-007 — [séparation traitement/GUI] `CompteFile`, `ViderFile`, `LitArticle` sans
  accès aux contrôles ; `Cbase.Table("TabEtiqp"/"TabEtiqg"/"TabEtiq"/"TabArt")` (SQL identique) ·
  appelants : aucun · tests : T01-T05 · sources : [EtiqRecpt.class:Calc_Etiq](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L90-L119), [EtiqRecpt.class:Button4_Click](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L352-L372)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] ETIQRECPT-A01 — [anomalie] Saut de positions (`Posetiq`) exécuté **avant** la création du PDF
  avec `pdf.Code` : « Null object » au premier passage, écriture dans l'ancien PDF ensuite ; et
  `Posetiq - 2` itérations (une position de moins que les autres écrans) · tests : T07 · sources : [EtiqRecpt.class:173](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L173), [EtiqRecpt.class:176](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L176)
- [ ] ETIQRECPT-A02 — [anomalie] Lectures sans test `Available` : ligne de file orpheline (article
  supprimé, ARTICLES-A05) → erreur à `rarts!art_code`, impression interrompue et file non vidée ;
  code TVA absent → erreur · tests : T06 · sources : [EtiqRecpt.class:220](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L220), [EtiqRecpt.class:221](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L221), [EtiqRecpt.class:235](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L235)
- [ ] ETIQRECPT-A03 — [anomalie] Imprimante Zebra non gérée (pas de PDF, `pdf.Open()` sur `Null`) ;
  format lu par `code` seul (page ignorée) · tests : T08 · sources : [EtiqRecpt.class:205](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L205), [EtiqRecpt.class:157](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L157)
- [ ] ETIQRECPT-A04 — [anomalie] Type casier : l'effacement proposé vide `Fiches_EtiProd`, donc aussi
  les étiquettes **produit** en attente (et inversement) ; effacement ligne à ligne sans transaction
  · tests : T04 · sources : [EtiqRecpt.class:357](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L357), [EtiqRecpt.class:366](../../../../../.src/Gestion/Etiquettes/EtiqRecpt.class#L366)
