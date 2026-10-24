# Balance — Rework

> Source : `.src/Compta/Impressions/Balance.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Balance.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 497 |
| Lignes de commentaire | 102 |
| Fonctions | 33 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 102 |
| Complexité max (fonction) | 20 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 497 | 102 | 20 | 0 | 33 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] BALANCE-001 — [documentation] En-tête en français : rôle (édition des balances), tableau
  bouton d'exercice ↔ période ↔ `Tab0`, sens de `Type`/`Type2`, sorties (PDF via `BalanceM`, export
  `~/balances.txt`) ; corriger les commentaires inversés de `Ex1`/`Exo` · appelants : aucun · tests :
  aucun · sources : [Balance.class:_New](../../../../../.src/Compta/Impressions/Balance.class#L63-L78), [Balance.class:Ex1](../../../../../.src/Compta/Impressions/Balance.class#L83-L111), [Balance.class:Exo](../../../../../.src/Compta/Impressions/Balance.class#L116-L140)
- [ ] BALANCE-002 — [code mort] Supprimer `donnees2`, la variable `Filename` et son `Try Kill` dans
  `Btn_Click`, la variable locale `Mois` d'`Exo5`, et dans `Button2_Click` les calculs jamais écrits
  (`dte`, cumuls hors période, `totdeb2`/`totcred2`/`totsld2`, `posy`, branche `Impcumul` dont les deux
  branches sont identiques) ; variables privées associées (`DebHP`, `CredHP`, `TotSldHP`, `TotDeb2`,
  `TotCred2`, `TotSld2`, `PosY`, `solde`, `debit`, `credit` si inutilisées après coup) · appelants :
  aucun · tests : T06, T08, T10 · sources : [Balance.class:donnees2](../../../../../.src/Compta/Impressions/Balance.class#L603-L607), [Balance.class:Btn_Click](../../../../../.src/Compta/Impressions/Balance.class#L316-L333), [Balance.class:Exo5](../../../../../.src/Compta/Impressions/Balance.class#L241-L261), [Balance.class:Button2_Click](../../../../../.src/Compta/Impressions/Balance.class#L627-L720)
- [ ] BALANCE-003 — [complexité] `Exo`, `Exo1` … `Exo4` → une fonction privée de chargement des
  bornes (une requête `Fiches_Parametres`, mêmes valeurs affichées, même `Catch`) ; `Ex1` et `Exo5`
  gardent leur calcul propre · appelants : aucun · tests : T01, T02, T04 · sources : [Balance.class:Exo](../../../../../.src/Compta/Impressions/Balance.class#L116-L140), [Balance.class:Exo1](../../../../../.src/Compta/Impressions/Balance.class#L145-L164), [Balance.class:Exo4](../../../../../.src/Compta/Impressions/Balance.class#L217-L236)
- [ ] BALANCE-004 — [commonalisation] Bornes d'exercice via un helper commun `Bornes(index)` partagé
  avec `Editcompte`, `EditcompteA`, `Journaux`, `JournauxA`, `Jourcent`, `EcrM`, `ExportA47`,
  `RubImp` (emplacement à décider en phase 3 : `LDate` ou module `Compta/Utils`), résultat identique
  au caractère près · appelants : aucun (helper nouveau) · tests : T01, T02, EDITCOMPTE-T01,
  EDITCOMPTEA-T01 · sources : [Balance.class:Ex1](../../../../../.src/Compta/Impressions/Balance.class#L83-L111), [Balance.class:Exo5](../../../../../.src/Compta/Impressions/Balance.class#L241-L261), [Editcompte.class:Exo5](../../../../../.src/Compta/Impressions/Editcompte.class#L227-L245), [EditcompteA.class:Exo5](../../../../../.src/Compta/Impressions/EditcompteA.class#L218-L237)
- [ ] BALANCE-005 — [complexité] `dteN0_LF`/`dteN1_LF` : helper privé `CleDate(s)` pour les six
  comparaisons `Val(aaaammjj)` et helper `ControleDate(texte, debut, fin)` sans GUI (message conservé
  dans l'appelant) ; à partager ensuite avec `Editcompte`/`EditcompteA` · appelants : aucun · tests :
  T04, T05 · sources : [Balance.class:dteN0_LF](../../../../../.src/Compta/Impressions/Balance.class#L349-L369), [Balance.class:dteN1_LF](../../../../../.src/Compta/Impressions/Balance.class#L371-L402)
- [ ] BALANCE-006 — [séparation traitement/GUI] `Button2_Click` : extraire
  `ExporteBalance(…) As Boolean` (requêtes + écriture du fichier, sans contrôle) ; le handler garde la
  souris, le son et les messages ; requêtes **inchangées** (anomalies A01/A02 conservées) · appelants :
  aucun · tests : T06, T07, T08, T10 · sources : [Balance.class:Button2_Click](../../../../../.src/Compta/Impressions/Balance.class#L627-L720), [Balance.class:donnees1](../../../../../.src/Compta/Impressions/Balance.class#L609-L613)
- [ ] BALANCE-007 — [réduction de portée] `Ex1`, `Exo` … `Exo5`, `dteN0_LF`, `dteN1_LF`, `Compdate`,
  `compdate2`, `donnees1`, `Raz` → `Private` (aucun appelant externe ; `Bsel`/`Bval` restent `Public`,
  écrits par `TriCpt`) · appelants : aucun · tests : T01 à T10 · sources : [Balance.class:Ex1](../../../../../.src/Compta/Impressions/Balance.class#L83-L111), [Balance.class:Compdate](../../../../../.src/Compta/Impressions/Balance.class#L404-L416), [Balance.class:donnees1](../../../../../.src/Compta/Impressions/Balance.class#L609-L613), [Balance.class:Raz](../../../../../.src/Compta/Impressions/Balance.class#L435-L452)
- [ ] BALANCE-008 — [réarchitecture] `Button1_Click` passe `TypeClient1.where` (chaîne) au lieu du
  contrôle `TypeClient1` à `BalanceM.Imprime` (même commit que BALANCEM-007) · appelants :
  `BalanceM.Imprime` · tests : BALANCEM-T01 à T08 · sources : [Balance.class:Button1_Click](../../../../../.src/Compta/Impressions/Balance.class#L618-L622), [BalanceM.module:Imprime](../../../../../.src/Compta/Impressions/BalanceM.module#L50-L259)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] BALANCE-A01 — [anomalie] Export client/fournisseur : `FROM Fiches_Comptes Fiches_Cli WHERE
  cli_code = compte_cc` (virgule manquante, `Fiches_Cli` devient un alias) → erreur SQL
  systématique, export impossible. Corriger comme `BalanceM` (commit `729b22cf`) avec
  `Cbase.Table("TabCli")` · tests : T07 · sources : [Balance.class:647](../../../../../.src/Compta/Impressions/Balance.class#L647), [BalanceM.module:82](../../../../../.src/Compta/Impressions/BalanceM.module#L82)
- [ ] BALANCE-A02 — [anomalie] Export balance générale : `… and type_cc = &4 or type_cc = &5` sans
  parenthèses → tous les comptes de bilan sont exportés, hors plage et collectifs compris · tests :
  T06 · sources : [Balance.class:644](../../../../../.src/Compta/Impressions/Balance.class#L644)
- [ ] BALANCE-A03 — [anomalie] L'export exclut les comptes collectifs (`coll <> 1`) alors que
  l'impression (`BalanceM`) les inclut : export et PDF diffèrent (intention à confirmer) · tests :
  T06, BALANCEM-T03 · sources : [Balance.class:644](../../../../../.src/Compta/Impressions/Balance.class#L644), [BalanceM.module:84](../../../../../.src/Compta/Impressions/BalanceM.module#L84)
- [ ] BALANCE-A04 — [anomalie] `Compdate`/`compdate2` remettent la période sur l'exercice précédent
  (`Exo`) et cochent « Exercice en cours » (`E0`) ; `Tab0` n'est pas recalculé de façon cohérente
  (dépend de la levée de `E0_Click`, à confirmer) · tests : T04 · sources : [Balance.class:410](../../../../../.src/Compta/Impressions/Balance.class#L410), [Balance.class:424](../../../../../.src/Compta/Impressions/Balance.class#L424)
- [ ] BALANCE-A05 — [anomalie] Textes incohérents : « Balances.txt » annoncé pour `~/balances.txt`,
  `Nom = "Client"` à l'ouverture contre `"client"` après clic (titre du PDF) · tests : T03, T06 · sources : [Balance.class:74](../../../../../.src/Compta/Impressions/Balance.class#L74), [Balance.class:463](../../../../../.src/Compta/Impressions/Balance.class#L463), [Balance.class:698](../../../../../.src/Compta/Impressions/Balance.class#L698)
