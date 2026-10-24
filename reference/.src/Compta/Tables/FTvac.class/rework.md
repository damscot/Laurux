# FTvac — Rework

> Source : `.src/Compta/Tables/FTvac.class` · Message de commit (phase 4) : `reference/.src/Compta/Tables/FTvac.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 262 |
| Lignes de commentaire | 32 |
| Fonctions | 23 |
| Fonctions Public | 23 |
| Complexité cyclomatique totale | 67 |
| Complexité max (fonction) | 16 (`Tva_KeyPress`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 262 | 67 | 16 | 0 | 23 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FTVAC-001 — [documentation] En-tête en français : table gérée, propagation vers
  `Fiches_Comptes.taux_tachat`, contrôles du groupe `Tva` et handlers inactifs (`Txtva_LostFocus`,
  `Tvacc_LostFocus`) signalés en commentaire · appelants : aucun · tests : aucun · sources : [FTvac.class:_New](../../../../../.src/Compta/Tables/FTvac.class#L33-L51), [FTvac.class:Txtva_LostFocus](../../../../../.src/Compta/Tables/FTvac.class#L217-L231), [FTvac.class:Tvacc_LostFocus](../../../../../.src/Compta/Tables/FTvac.class#L239-L243)
- [ ] FTVAC-002 — [code mort] Supprimer `Cleanchamps` (jamais appelée), le second `Txtva.clear` de
  `Refresh`, les `Else` vides et l'affectation `Enr = 1` redondante de `Tva_KeyPress` · appelants :
  aucun · tests : T01-T05 · sources : [FTvac.class:Cleanchamps](../../../../../.src/Compta/Tables/FTvac.class#L109-L115), [FTvac.class:84](../../../../../.src/Compta/Tables/FTvac.class#L84), [FTvac.class:158](../../../../../.src/Compta/Tables/FTvac.class#L158)
- [ ] FTVAC-003 — [commonalisation] `cpoint` local → `Utils.cpoint` dans `Txtva_LostFocus` (même
  résultat pour une saisie non vide ; fonction inactive) · appelants : aucun · tests : T01 · sources : [FTvac.class:cpoint](../../../../../.src/Compta/Tables/FTvac.class#L53-L57), [FTvac.class:Txtva_LostFocus](../../../../../.src/Compta/Tables/FTvac.class#L217-L231)
- [ ] FTVAC-004 — [réarchitecture] `Cbase.Table("TabTvac")`/`Cbase.Table("TabComptes")` à la place
  du membre `Tab` et des noms en dur (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [FTvac.class:Form_Open](../../../../../.src/Compta/Tables/FTvac.class#L59-L77), [FTvac.class:Button1_Click](../../../../../.src/Compta/Tables/FTvac.class#L251-L273), [FTvac.class:Button4_Click](../../../../../.src/Compta/Tables/FTvac.class#L298-L330)
- [ ] FTVAC-005 — [séparation traitement/GUI] `EnregistreTva(sCode, sTaux, sCompte)` et
  `SupprimeTva(sCode) As String` sans contrôle ; SQL inchangé (concaténations conservées jusqu'à A02) ·
  appelants : aucun · tests : T01-T03 · sources : [FTvac.class:Button1_Click](../../../../../.src/Compta/Tables/FTvac.class#L251-L273), [FTvac.class:Button3_Click](../../../../../.src/Compta/Tables/FTvac.class#L275-L296)
- [ ] FTVAC-006 — [commonalisation] Module commun avec `FTvav` (liste, zones, liste des comptes
  445, suppression avec contrôle d'usage), paramétré par la table TVA et la colonne de
  `Fiches_Comptes` ; même commit que FTVAV-007 · appelants : aucun · tests : T01-T05, FTVAV-T01 à T05 · sources : [FTvac.class:Form_Open](../../../../../.src/Compta/Tables/FTvac.class#L59-L77), [FTvac.class:Button4_Click](../../../../../.src/Compta/Tables/FTvac.class#L298-L330), [FTvav.class:Button4_Click](../../../../../.src/Compta/Tables/FTvav.class#L311-L343)
- [ ] FTVAC-007 — [réduction de portée] `Refresh`, `Maj_Zones`, `Tvaman`, `cpoint` → `Private`
  (noms de handlers inchangés) · appelants : aucun · tests : T01-T05 · sources : [FTvac.class:Refresh](../../../../../.src/Compta/Tables/FTvac.class#L79-L89), [FTvac.class:Maj_Zones](../../../../../.src/Compta/Tables/FTvac.class#L91-L107), [FTvac.class:Tvaman](../../../../../.src/Compta/Tables/FTvac.class#L374-L390)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FTVAC-A01 — [anomalie] `Txtva_LostFocus` et `Tvacc_LostFocus` ne sont jamais déclenchés
  (groupe `Tva`) : taux non normalisé, compte de TVA jamais contrôlé (`Tvaman`), `Enr` toujours 0 →
  Entrée sur le compte ne passe jamais au bouton Enregistrer et un compte inexistant est accepté.
  Proposition : appeler ces contrôles depuis `Tva_KeyPress`/`Button1_Click` · tests : T04 · sources : [FTvac.class:Txtva_LostFocus](../../../../../.src/Compta/Tables/FTvac.class#L217-L231), [FTvac.class:Tvacc_LostFocus](../../../../../.src/Compta/Tables/FTvac.class#L239-L243), [FTvac.class:152](../../../../../.src/Compta/Tables/FTvac.class#L152)
- [ ] FTVAC-A02 — [anomalie] SQL par concaténation dans `Button1_Click`, `Button3_Click`,
  `Button4_Click` : une apostrophe dans une saisie provoque une erreur SQL · tests : T01, T05 · sources : [FTvac.class:258](../../../../../.src/Compta/Tables/FTvac.class#L258), [FTvac.class:260](../../../../../.src/Compta/Tables/FTvac.class#L260), [FTvac.class:263](../../../../../.src/Compta/Tables/FTvac.class#L263), [FTvac.class:316](../../../../../.src/Compta/Tables/FTvac.class#L316)
- [ ] FTVAC-A03 — [anomalie] La suppression teste et supprime le code de la ligne sélectionnée
  (`Tvalist.Current[0]`) et non le code saisi ; erreur si aucune ligne n'est sélectionnée ·
  tests : T03 · sources : [FTvac.class:285](../../../../../.src/Compta/Tables/FTvac.class#L285), [FTvac.class:289](../../../../../.src/Compta/Tables/FTvac.class#L289)
- [ ] FTVAC-A04 — [anomalie] `Btn_KeyPress` : n'importe quelle touche sur le bouton Enregistrer
  (Tab, flèches) déclenche l'enregistrement · tests : T04 · sources : [FTvac.class:Btn_KeyPress](../../../../../.src/Compta/Tables/FTvac.class#L177-L186)
- [ ] FTVAC-A05 — [anomalie] Pas de contrôle d'unicité du compte de TVA entre codes, contrairement
  à `FTvav.Button1_Click` (à confirmer : règle voulue pour les ventes seulement ?) · tests : T01 · sources : [FTvac.class:Button1_Click](../../../../../.src/Compta/Tables/FTvac.class#L251-L273), [FTvav.class:261](../../../../../.src/Compta/Tables/FTvav.class#L261)
