# Famille — Rework

> Source : `.src/Gestion/Tables/Famille.class` · Message de commit (phase 4) : `reference/.src/Gestion/Tables/Famille.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 761 |
| Lignes de commentaire | 52 |
| Fonctions | 40 |
| Fonctions Public | 40 |
| Complexité cyclomatique totale | 218 |
| Complexité max (fonction) | 28 (`Button1_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-25 | 761 | 218 | 28 | 0 | 40 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] FAMILLE-001 — [documentation] En-tête en français : table gérée, groupe `fam` et rôle des
  `Tag` (navigation, contrôles), handlers nominaux non levés (`Coef_LostFocus`,
  `Remise_LostFocus`, `Ecotx_LostFocus`, `Colcompt2_KeyPress`), sens du drapeau `b` ·
  appelants : aucun · tests : aucun · sources : [Famille.class:_New](../../../../../.src/Gestion/Tables/Famille.class#L38-L108), [Famille.class:fam_lostfocus](../../../../../.src/Gestion/Tables/Famille.class#L836-L868), [Famille.class:fam_KeyPress](../../../../../.src/Gestion/Tables/Famille.class#L870-L945)
- [ ] FAMILLE-002 — [code mort] Supprimer `Btn_KeyPress` (aucun contrôle ni groupe `Btn`),
  `Colcompt2_KeyPress` (contrôle du groupe `fam`, jamais visible), les 5 affectations répétées de
  `Tbrem2.Rows[n].text`, la variable `bb` et le `With Utils` inutile de `Button1_Click`, les
  appels commentés à `compteGman`. `Colcompt2_Click` est conservé (`replay_dynamic`) ·
  appelants : aucun · tests : T01, T03, T04 · sources : [Famille.class:Btn_KeyPress](../../../../../.src/Gestion/Tables/Famille.class#L947-L956), [Famille.class:Colcompt2_KeyPress](../../../../../.src/Gestion/Tables/Famille.class#L661-L682), [Famille.class:84](../../../../../.src/Gestion/Tables/Famille.class#L84), [Famille.class:Button1_Click](../../../../../.src/Gestion/Tables/Famille.class#L356-L439)
- [ ] FAMILLE-003 — [complexité] `Maj_Zones` et `Button1_Click` : boucle sur les 6 tranches de
  remise par quantité au lieu de 18 lignes / 36 paramètres (texte SQL et valeurs identiques) ·
  appelants : aucun · tests : T01, T06 · sources : [Famille.class:Maj_Zones](../../../../../.src/Gestion/Tables/Famille.class#L147-L196), [Famille.class:Button1_Click](../../../../../.src/Gestion/Tables/Famille.class#L356-L439)
- [ ] FAMILLE-004 — [complexité] `Test_Tva` et `compteGman` renvoient un booléen au lieu de
  positionner `b` ; `Button1_Click` et `fam_lostfocus` testent le retour (mêmes messages, même
  focus) · appelants : aucun · tests : T02, T03 · sources : [Famille.class:Test_Tva](../../../../../.src/Gestion/Tables/Famille.class#L805-L834), [Famille.class:compteGman](../../../../../.src/Gestion/Tables/Famille.class#L961-L976), [Famille.class:fam_lostfocus](../../../../../.src/Gestion/Tables/Famille.class#L836-L868)
- [ ] FAMILLE-005 — [séparation traitement/GUI] `EnregistreFamille(valeurs)`, `FamilleUtilisee(code)
  As String`, `TvaModifiable(famille, ancienCode)` sans accès aux contrôles, appelées par
  `Button1_Click`, `Button3_Click` et `Test_Tva` · appelants : aucun · tests : T01, T02, T05 ·
  sources : [Famille.class:Button1_Click](../../../../../.src/Gestion/Tables/Famille.class#L356-L439), [Famille.class:Button3_Click](../../../../../.src/Gestion/Tables/Famille.class#L447-L483), [Famille.class:Test_Tva](../../../../../.src/Gestion/Tables/Famille.class#L805-L834)
- [ ] FAMILLE-006 — [réduction de portée] `Refresh`, `Maj_Zones`, `MoveTo`, `ShowTextBox`,
  `HideTextBox`, `Cleanchamps`, `AffCpt`, `Test_Tva`, `compteGman` → `Private` (aucun appel
  externe, vérifié par `grep -rn`) ; handlers et `replay_dynamic` inchangés · appelants : aucun ·
  tests : T01-T07 · sources : [Famille.class:Refresh](../../../../../.src/Gestion/Tables/Famille.class#L139-L145), [Famille.class:AffCpt](../../../../../.src/Gestion/Tables/Famille.class#L527-L562), [Famille.class:compteGman](../../../../../.src/Gestion/Tables/Famille.class#L961-L976)
- [ ] FAMILLE-007 — [commonalisation] Composant commun d'édition de `TableView` par `TextBox`
  superposée (`MoveTo`, `ShowTextBox`, `HideTextBox`, gestion des touches) avec `Articles` et
  `Txmo` (phase 3) · appelants : aucun · tests : T06 · sources : [Famille.class:MoveTo](../../../../../.src/Gestion/Tables/Famille.class#L262-L275), [Famille.class:ShowTextBox](../../../../../.src/Gestion/Tables/Famille.class#L278-L301), [Famille.class:HideTextBox](../../../../../.src/Gestion/Tables/Famille.class#L304-L335), [Famille.class:tbxrem_KeyPress](../../../../../.src/Gestion/Tables/Famille.class#L229-L259)
- [ ] FAMILLE-008 — [commonalisation] Liste des familles (`Colfam`) et contrôle d'existence de
  famille partagés avec `CoefTypeC`, `Remisec`, `Remisecli` ; liste des comptes partagée avec
  `FTvac`/`FTvav`/`FJournaux` (phase 3) · appelants : aucun · tests : T04 · sources : [Famille.class:AffCpt](../../../../../.src/Gestion/Tables/Famille.class#L527-L562), [Famille.class:Colcompt_Click](../../../../../.src/Gestion/Tables/Famille.class#L604-L629)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] FAMILLE-A01 — [anomalie] `fam_KeyPress` : F2 sur `Codecompt2` (tag 7) ouvre la liste du
  **compte de remise** (`ToggleButton3_click`) ; F2 est sans effet sur `Cmptrem`, `Codecompt3`,
  `Codecompt4`, `Codecompt5` · tests : T04 · sources : [Famille.class:939](../../../../../.src/Gestion/Tables/Famille.class#L939), [Famille.class:940](../../../../../.src/Gestion/Tables/Famille.class#L940)
- [ ] FAMILLE-A02 — [anomalie] `Button3_Click` : en cas de refus, le pointeur reste en attente
  (`Mouse.Wait` rétabli seulement après suppression) ; le contrôle d'usage porte sur le code
  saisi mais la suppression sur la famille sélectionnée dans la liste · tests : T05 · sources : [Famille.class:457](../../../../../.src/Gestion/Tables/Famille.class#L457), [Famille.class:458](../../../../../.src/Gestion/Tables/Famille.class#L458), [Famille.class:475](../../../../../.src/Gestion/Tables/Famille.class#L475)
- [ ] FAMILLE-A03 — [anomalie] `Button3_Click` ne supprime pas les lignes `Fiches_FamDep` de la
  famille et ne notifie pas le serveur (`Serveur.Pass`), contrairement à la création et à la
  modification (à confirmer) · tests : T05, T09 · sources : [Famille.class:Button3_Click](../../../../../.src/Gestion/Tables/Famille.class#L447-L483)
- [ ] FAMILLE-A04 — [anomalie] `Button1_Click` écrit `Fiches_FamDep` même sans l'option dépôts
  (ligne `depot = ''` pour chaque famille enregistrée) · tests : T01 · sources : [Famille.class:406](../../../../../.src/Gestion/Tables/Famille.class#L406), [Famille.class:410](../../../../../.src/Gestion/Tables/Famille.class#L410)
- [ ] FAMILLE-A05 — [anomalie] `TBfam_click` rappelle `Utils.Observers(Me)` à chaque changement
  d'onglet : `ReplayObserver` en double (événements journalisés plusieurs fois, rejeu faussé) et
  croissance mémoire (voir UTILS-A08) · tests : T08 · sources : [Famille.class:112](../../../../../.src/Gestion/Tables/Famille.class#L112)
- [ ] FAMILLE-A06 — [anomalie] `Maj_Zones` lit la famille sans tester `Available` et masque toute
  erreur par un `Catch` vide (famille supprimée par un autre poste : zones partiellement
  remplies, sans message) · tests : T05 · sources : [Famille.class:151](../../../../../.src/Gestion/Tables/Famille.class#L151), [Famille.class:194](../../../../../.src/Gestion/Tables/Famille.class#L194)
