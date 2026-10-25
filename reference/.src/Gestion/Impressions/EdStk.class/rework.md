# EdStk — Rework

> Source : `.src/Gestion/Impressions/EdStk.class` · Message de commit (phase 4) : `reference/.src/Gestion/Impressions/EdStk.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 435 |
| Lignes de commentaire | 65 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 101 |
| Complexité max (fonction) | 27 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 435 | 101 | 27 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] EDSTK-001 — [documentation] En-tête en français : stock théorique `art_qte` non recalculé,
  articles stockés seulement, valorisation PA/PMP, renvoi au tableau des sources de Stockmvt ·
  appelants : aucun · tests : aucun · sources : [EdStk.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L463-L586)
- [ ] EDSTK-002 — [code mort] Supprimer `Dte`, `PosX`, `Shell "cd …"`, `Print code`, `Tab` dans
  `SelectionArt`, le `Case 1` inatteignable de `Btn_Click` · appelants : aucun · tests : T01, T07 ·
  sources : [EdStk.class:477](../../../../../.src/Gestion/Impressions/EdStk.class#L477), [EdStk.class:517](../../../../../.src/Gestion/Impressions/EdStk.class#L517), [EdStk.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdStk.class#L83-L105), [EdStk.class:Btn_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L382-L398)
- [ ] EDSTK-003 — [complexité] Membres de travail (`Code`, `Intitule`, `Fami`, `Fourn`, `Pbht`,
  `Rem`, `Paht`, `Qte`, `Totpa`, `Totpmp`, `Nbd`, `Nbdec`) → variables locales de `Button2_Click` ;
  en-tête `Entete`+`Level1/2` factorisé (3 copies) · appelants : aucun · tests : T01 à T06 ·
  sources : [EdStk.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L463-L586)
- [ ] EDSTK-004 — [séparation traitement/GUI] Extraire `ValoriseLigne(paht, pmp, qte, nbdec)` et
  `CumulStock` (arrondi identique) et la requête `SelectArticlesStockes` ; le handler garde les
  contrôles et le PDF · appelants : aucun · tests : T01, T06, T08 · sources : [EdStk.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L463-L586)
- [ ] EDSTK-005 — [commonalisation] Listes famille/fournisseur et `SelectionArt` vers le socle
  `EdSelection` (EDART1-003, même commit) · appelants : aucun · tests : T04, T07 · sources : [EdStk.class:ToggleButton3_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L110-L142), [EdStk.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdStk.class#L83-L105), [EdArt1.class:ToggleButton3_Click](../../../../../.src/Gestion/Impressions/EdArt1.class#L80-L113)
- [ ] EDSTK-006 — [réduction de portée] `SelectionArt`, `Button2_Click` → `Private` · appelants :
  aucun · tests : T01 · sources : [EdStk.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdStk.class#L83-L105), [EdStk.class:Button2_Click](../../../../../.src/Gestion/Impressions/EdStk.class#L463-L586)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] EDSTK-A01 — [anomalie] Cumuls `Totpa`/`Totpmp` reformatés à 2 décimales à chaque ligne alors
  que les lignes peuvent avoir 3 décimales : total ≠ somme des lignes imprimées · tests : T06 ·
  sources : [EdStk.class:533](../../../../../.src/Gestion/Impressions/EdStk.class#L533), [EdStk.class:535](../../../../../.src/Gestion/Impressions/EdStk.class#L535)
- [ ] EDSTK-A02 — [anomalie] Aucun pied de page (`Footer` jamais appelé alors qu'`AliasNbPages` est
  posé) : pas de numéro de page · tests : T05 · sources : [EdStk.class:544](../../../../../.src/Gestion/Impressions/EdStk.class#L544)
- [ ] EDSTK-A03 — [anomalie] `Pbht` garde la valeur de l'article précédent si `Format$` échoue
  (membre de classe) · tests : T06 · sources : [EdStk.class:515](../../../../../.src/Gestion/Impressions/EdStk.class#L515)
- [ ] EDSTK-A04 — [anomalie] Défauts communs avec `EdArt1` : `Bsel` jamais remis à faux,
  impression pour toute touche sur « Imprimer » (`Btn_KeyPress`) · tests : T07 · sources : [EdStk.class:SelectionArt](../../../../../.src/Gestion/Impressions/EdStk.class#L83-L105), [EdStk.class:Btn_KeyPress](../../../../../.src/Gestion/Impressions/EdStk.class#L400-L407)
