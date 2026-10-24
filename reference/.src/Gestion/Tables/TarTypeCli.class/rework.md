# TarTypeCli — Rework

> Source : `.src/Gestion/Tables/TarTypeCli.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/TarTypeCli.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 413 |
| Lignes de commentaire | 32 |
| Fonctions | 30 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 93 |
| Complexité max (fonction) | 8 (`Art_man`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 413 | 93 | 8 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] TARTYPECLI-001 — [documentation] En-tête en français : deux modes (`client`/`type`),
  arguments réels du constructeur `(choix, Parent, cat, article)`, tables touchées, cascade de
  prix et sens du coefficient (multiplicateur du prix de revient) · appelants : aucun ·
  tests : aucun · sources : [TarTypeCli.class:_new](../../../../../.src/Gestion/Tables/TarTypeCli.class#L16-L57), [TarTypeCli.class:Tcoeff_Lostfocus](../../../../../.src/Gestion/Tables/TarTypeCli.class#L446-L459)
- [ ] TARTYPECLI-002 — [code mort] Supprimer les membres `son` et `Dbl` (inutilisés), le test
  `Available` redondant de `TypeC_man` et les commentaires morts · appelants : aucun · tests :
  T01, T07 · sources : [TarTypeCli.class:7](../../../../../.src/Gestion/Tables/TarTypeCli.class#L7), [TarTypeCli.class:8](../../../../../.src/Gestion/Tables/TarTypeCli.class#L8), [TarTypeCli.class:158](../../../../../.src/Gestion/Tables/TarTypeCli.class#L158)
- [ ] TARTYPECLI-003 — [complexité] Membres `$table`/`$colonne` fixés dans `_new` selon `$choix`,
  utilisés par `TypeC_man`, `Aff_Tarart`, `ColTri_MajSel`, `Tart_LostFocus`, `Button3_Click`,
  `Button6_Click` (SQL identique) ; `ColTri_KeyPress` garde sa requête actuelle tant que A01 n'est
  pas validée · appelants : aucun · tests : T01-T07 · sources : [TarTypeCli.class:Aff_Tarart](../../../../../.src/Gestion/Tables/TarTypeCli.class#L167-L235), [TarTypeCli.class:Button6_Click](../../../../../.src/Gestion/Tables/TarTypeCli.class#L389-L422), [TarTypeCli.class:Button3_Click](../../../../../.src/Gestion/Tables/TarTypeCli.class#L374-L387)
- [ ] TARTYPECLI-004 — [réarchitecture] `Cbase.Table(…)` pour `TabTarcli`, `TabTcli`, `TabArt`,
  `TabTvav`, `TabCli` (SQL identique) · appelants : aucun · tests : T01-T08 · sources : [TarTypeCli.class:TypeC_man](../../../../../.src/Gestion/Tables/TarTypeCli.class#L144-L165), [TarTypeCli.class:Aff_Tarart](../../../../../.src/Gestion/Tables/TarTypeCli.class#L167-L235), [TarTypeCli.class:Art_man](../../../../../.src/Gestion/Tables/TarTypeCli.class#L307-L336)
- [ ] TARTYPECLI-005 — [réduction de portée] `TypeC_man`, `Aff_Tarart`, `SelectionArt`, `Art_man`,
  `Calc_Remise`, `Refresh`, `Calc_coeff` → `Private` (aucun appel externe, vérifié par
  `grep -rn`) ; handlers, `Coltype_Click` (`replay_dynamic`) et `Bsel`/`Bval` inchangés ·
  appelants : aucun · tests : T01-T08 · sources : [TarTypeCli.class:SelectionArt](../../../../../.src/Gestion/Tables/TarTypeCli.class#L287-L302), [TarTypeCli.class:Calc_Remise](../../../../../.src/Gestion/Tables/TarTypeCli.class#L359-L366), [TarTypeCli.class:Calc_coeff](../../../../../.src/Gestion/Tables/TarTypeCli.class#L524-L529)
- [ ] TARTYPECLI-006 — [séparation traitement/GUI] `EnregistreTarif`, `SupprimeTarif`,
  `SupprimeTarifs` sans contrôle ; `Calc_Remise`/`Calc_coeff` en fonctions pures à paramètres ·
  appelants : aucun · tests : T01, T03, T05, T06 · sources : [TarTypeCli.class:Button6_Click](../../../../../.src/Gestion/Tables/TarTypeCli.class#L389-L422), [TarTypeCli.class:Button3_Click](../../../../../.src/Gestion/Tables/TarTypeCli.class#L374-L387), [TarTypeCli.class:ColTri_KeyPress](../../../../../.src/Gestion/Tables/TarTypeCli.class#L461-L476)
- [ ] TARTYPECLI-007 — [commonalisation] Cascade de prix par la fabrique commune `PrixVente`
  (GESTAR-008) après preuve par gb.test de l'équivalence remise en montant / marge % (phase 3,
  même lot que GESTAR-008) · appelants : aucun · tests : T03 · sources : [TarTypeCli.class:Tcoeff_Lostfocus](../../../../../.src/Gestion/Tables/TarTypeCli.class#L446-L459), [TarTypeCli.class:Remise_LostFocus](../../../../../.src/Gestion/Tables/TarTypeCli.class#L492-L505), [TarTypeCli.class:Tpvht_LostFocus](../../../../../.src/Gestion/Tables/TarTypeCli.class#L481-L490)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] TARTYPECLI-A01 — [anomalie] `ColTri_KeyPress` en mode type : `DELETE FROM Fiches_Tarcli
  WHERE type = …` (mauvaise table, colonne inexistante) → erreur SQL, le tarif par type n'est
  jamais supprimé par Suppr · tests : T05 · sources : [TarTypeCli.class:469](../../../../../.src/Gestion/Tables/TarTypeCli.class#L469)
- [ ] TARTYPECLI-A02 — [anomalie] `ColTri_MajSel` filtre seulement sur `art_code` : le coefficient
  affiché peut être celui d'un autre client / type (et `Button6_Click` l'enregistre alors pour
  le client courant) · tests : T04 · sources : [TarTypeCli.class:241](../../../../../.src/Gestion/Tables/TarTypeCli.class#L241), [TarTypeCli.class:243](../../../../../.src/Gestion/Tables/TarTypeCli.class#L243)
- [ ] TARTYPECLI-A03 — [anomalie] `Aff_Tarart` : la requête `LIMIT 1` de lecture des champs n'a pas
  de filtre ; table vide → `Return` avant de fermer l'ancien `TriGen` (liste périmée affichée) ·
  tests : T06 · sources : [TarTypeCli.class:185](../../../../../.src/Gestion/Tables/TarTypeCli.class#L185), [TarTypeCli.class:186](../../../../../.src/Gestion/Tables/TarTypeCli.class#L186), [TarTypeCli.class:227](../../../../../.src/Gestion/Tables/TarTypeCli.class#L227)
- [ ] TARTYPECLI-A04 — [anomalie] `Art_man` écrit `artman` sur la sortie standard (trace de
  débogage) · tests : T08 · sources : [TarTypeCli.class:310](../../../../../.src/Gestion/Tables/TarTypeCli.class#L310)
- [ ] TARTYPECLI-A05 — [anomalie] `Tpvht_LostFocus`, `Remise_LostFocus`, `TpvTTc_LostFocus` testent
  `IsNull($resart)` mais pas `Available` : après un article introuvable, sortir de ces zones
  provoque une erreur · tests : T08 · sources : [TarTypeCli.class:485](../../../../../.src/Gestion/Tables/TarTypeCli.class#L485), [TarTypeCli.class:496](../../../../../.src/Gestion/Tables/TarTypeCli.class#L496), [TarTypeCli.class:513](../../../../../.src/Gestion/Tables/TarTypeCli.class#L513)
