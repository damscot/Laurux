# Pointage — Rework

> Source : `.src/Compta/Pointage.class` · Message de commit (phase 4) : `reference/.src/Compta/Pointage.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 646 |
| Lignes de commentaire | 72 |
| Fonctions | 35 |
| Fonctions Public | 33 |
| Complexité cyclomatique totale | 126 |
| Complexité max (fonction) | 23 (`Imprime_Click`) |
| Variables globales | 0 |
| Variables Public | 2 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 646 | 126 | 23 | 0 | 33 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] POINTAGE-001 — [documentation] En-tête en français : déroulé du rapprochement (compte,
  relevé, sélection, pointage), rôle de `IsLast`/`soldep`, dépendance à `Listextcpt` ; commentaires
  `'''` sur les méthodes non-handlers ; mention explicite que `Bsel`/`Bval` sont écrits par
  `Object.SetProperty` · appelants : aucun · tests : T01-T13 · sources : [Pointage.class:_New](../../../../.src/Compta/Pointage.class#L38-L65), [Pointage.class:28-29](../../../../.src/Compta/Pointage.class#L28-L29)
- [ ] POINTAGE-002 — [code mort] Supprimer les variables inutilisées (`f` dans `Update_Req`, `Res`
  dans `TriGen_MajSel`, `rResult` dans `ToggleButton3_Click`, `PosX`), le `Shell "cd …"`, les tests
  `= Null` sur chaînes formatées, les en-têtes de colonnes commentés et la branche `Else` vide de
  `ToggleButton1_MouseDown` · appelants : aucun · tests : T01, T08, T11 · sources : [Pointage.class:Update_Req](../../../../.src/Compta/Pointage.class#L67-L135), [Pointage.class:TriGen_MajSel](../../../../.src/Compta/Pointage.class#L139-L162), [Pointage.class:ToggleButton3_Click](../../../../.src/Compta/Pointage.class#L490-L501), [Pointage.class:786](../../../../.src/Compta/Pointage.class#L786), [Pointage.class:828-829](../../../../.src/Compta/Pointage.class#L828-L829), [Pointage.class:844-845](../../../../.src/Compta/Pointage.class#L844-L845)
- [ ] POINTAGE-003 — [commonalisation] Fusionner `Pointage2_Click` et `Depointage_Click` dans
  `Private Sub Enregistre_Pointage(point As Boolean)` (mêmes messages, même SQL) · appelants : aucun ·
  tests : T03, T04 · sources : [Pointage.class:Pointage2_Click](../../../../.src/Compta/Pointage.class#L636-L669), [Pointage.class:Depointage_Click](../../../../.src/Compta/Pointage.class#L671-L704)
- [ ] POINTAGE-004 — [complexité] `Imprime_Click` (CC 23) : helper privé `Entete_Page` (en-tête
  répété 3 fois) et fonction privée `Lignes_Impression() As Result` (sélection SQL selon le mode,
  mêmes requêtes) ; PDF identique · appelants : aucun · tests : T11 · sources : [Pointage.class:Imprime_Click](../../../../.src/Compta/Pointage.class#L739-L867)
- [ ] POINTAGE-005 — [commonalisation] Sélection multiple sur `TriGen` (`TriGen_MajSel`,
  `TriGen_Raz`, `TriGen_Data`, `SelectAllFil_Click`, `DeSelectAllFil_Click`) déléguée à un helper
  commun avec `GedR` et `TriFacture` (classe `TriSelection` ou méthodes de `TriGen`) ; handlers
  conservés · appelants : `GedR`, `TriFacture` (dans leurs propres reworks) · tests : T03, T08 · sources : [Pointage.class:TriGen_MajSel](../../../../.src/Compta/Pointage.class#L139-L162), [Pointage.class:SelectAllFil_Click](../../../../.src/Compta/Pointage.class#L525-L543), [Pointage.class:DeSelectAllFil_Click](../../../../.src/Compta/Pointage.class#L545-L563), [GedR.class:SelectAllFil_Click](../../../../.src/Utils/GedR.class#L59-L76), [TriFacture.class:SelectAllFil_Click](../../../../.src/Affichages/TriFacture.class#L186-L204)
- [ ] POINTAGE-006 — [commonalisation] Remplacer `Left($lst.requete, -14)` par une propriété de
  `Listextcpt` renvoyant la requête sans `ORDER BY` (même SQL émis) · appelants : `Listextcpt`
  (ajout de propriété) · tests : T01, T09, T10 · sources : [Pointage.class:127-128](../../../../.src/Compta/Pointage.class#L127-L128), [Listextcpt.class:_new](../../../../.src/Compta/Utils/Listextcpt.class#L36-L134)
- [ ] POINTAGE-007 — [complexité] Supprimer les doubles appels `Update_Req()`/`Calc_Solde()` qui
  suivent `ClearChampsAll()` dans `cptman` et `Colrlv_Man` (SQL modifié : moins de `SELECT`, dump
  identique) · appelants : aucun · tests : T01, T02, T05 · sources : [Pointage.class:cptman](../../../../.src/Compta/Pointage.class#L458-L488), [Pointage.class:Colrlv_Man](../../../../.src/Compta/Pointage.class#L301-L406)
- [ ] POINTAGE-008 — [séparation traitement/GUI] Extraire en `Private` les accès SQL de
  `Colrlv_Man` (`Releve_Precedent`, `Releve_Suivant_Existe`, `Cree_Releve`), de
  `SuppressionRlv_Click` (`Supprime_Releve`) et le calcul pur de `Calc_Solde` ; requêtes inchangées ·
  appelants : aucun · tests : T02, T05, T06 · sources : [Pointage.class:Colrlv_Man](../../../../.src/Compta/Pointage.class#L301-L406), [Pointage.class:SuppressionRlv_Click](../../../../.src/Compta/Pointage.class#L706-L737), [Pointage.class:Calc_Solde](../../../../.src/Compta/Pointage.class#L589-L618)
- [ ] POINTAGE-009 — [commonalisation] Solde pointé avec report à nouveau (`cptman`,
  `Imprime_Click`) vers un helper commun avec `Calcsolde.Calcul` (le journal `90` en dur est
  conservé tant que POINTAGE-A04 n'est pas validée) · appelants : aucun · tests : T01, T11 · sources : [Pointage.class:479](../../../../.src/Compta/Pointage.class#L479), [Pointage.class:795](../../../../.src/Compta/Pointage.class#L795), [Calcsolde.class:Calcul](../../../../.src/Utils/Calcsolde.class#L97-L129)
- [ ] POINTAGE-010 — [réduction de portée] `Update_Req`, `Colrlv_Man`, `cptman`, `ClearChamps`,
  `ClearChampsAll`, `Calc_Solde` → `Private` (`Bsel`/`Bval` restent `Public`) · appelants : aucun ·
  tests : T01-T12 · sources : [Pointage.class:Update_Req](../../../../.src/Compta/Pointage.class#L67-L135), [Pointage.class:Colrlv_Man](../../../../.src/Compta/Pointage.class#L301-L406), [Pointage.class:cptman](../../../../.src/Compta/Pointage.class#L458-L488), [Pointage.class:ClearChamps](../../../../.src/Compta/Pointage.class#L565-L571), [Pointage.class:ClearChampsAll](../../../../.src/Compta/Pointage.class#L573-L587), [Pointage.class:Calc_Solde](../../../../.src/Compta/Pointage.class#L589-L618)
- [ ] POINTAGE-011 — [complexité] `ToggleButton1_MouseDown` : boucle `Do … Loop Until` remplacée par
  l'idiome `Repeat … Until` du dépôt (comportement identique) · appelants : aucun · tests : T05 · sources : [Pointage.class:248-255](../../../../.src/Compta/Pointage.class#L248-L255)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] POINTAGE-A01 — [anomalie] **Grave** : `If Message.Question(…) Then` est toujours vrai (1 ou
  2) : le relevé est supprimé et ses écritures dépointées même si l'utilisateur répond « Non »
  · tests : T07 · sources : [Pointage.class:722](../../../../.src/Compta/Pointage.class#L722)
- [ ] POINTAGE-A02 — [anomalie] La suppression d'un relevé ne dépointe que `Fiches_Mvt` (exercice
  courant) alors que le pointage porte sur `Fiches_Mvt` … `Mvt5` ; elle écrit `nrlv = ''` au lieu de
  `NULL` · tests : T06, T10 · sources : [Pointage.class:726](../../../../.src/Compta/Pointage.class#L726), [Listextcpt.class:enregistrepointage](../../../../.src/Compta/Utils/Listextcpt.class#L330-L346)
- [ ] POINTAGE-A03 — [anomalie] `Calcsolde.Calcul(cpt, True)` sans journal d'à-nouveaux :
  `soldep` n'est pas recalculé après suppression d'un relevé (= CALCSOLDE-A01) · tests : T06 · sources : [Pointage.class:728](../../../../.src/Compta/Pointage.class#L728), [Calcsolde.class:Calcul](../../../../.src/Utils/Calcsolde.class#L97-L129)
- [ ] POINTAGE-A04 — [anomalie] Journal d'à-nouveaux `90` en dur dans le calcul du solde pointé
  (au lieu de `Fiches_Parametres.jdr`) ; calcul limité à l'exercice courant · tests : T01, T11 · sources : [Pointage.class:479](../../../../.src/Compta/Pointage.class#L479), [Pointage.class:795](../../../../.src/Compta/Pointage.class#L795)
- [ ] POINTAGE-A05 — [anomalie] `Update_Req` : `IF(pointee=TRUE, …)` (MySQL) non traduit pour
  SQLite (à confirmer) ; sortie sans liste si `Fiches_Mvt` est vide alors que des exercices
  antérieurs existent · tests : T13 · sources : [Pointage.class:94-96](../../../../.src/Compta/Pointage.class#L94-L96)
- [ ] POINTAGE-A06 — [anomalie] Impression « non pointées » : le filtre `dte <= date du relevé` ne
  porte que sur la branche `pointee is null` du `or` ; branche « sans relevé » avec `nrlv <= ''` ;
  `Fiches_Societes` lu sans test `Available` ; impression limitée à l'exercice courant · tests : T11 · sources : [Pointage.class:795](../../../../.src/Compta/Pointage.class#L795), [Pointage.class:807](../../../../.src/Compta/Pointage.class#L807), [Pointage.class:774-775](../../../../.src/Compta/Pointage.class#L774-L775)
- [ ] POINTAGE-A07 — [anomalie] `Dépointer` met aussi à jour `Fiches_Comptes.soldep` avec le solde
  final saisi (comme `Pointer`), et le changement de période (`dtinf`/`dtsup`, groupe `Dte`) réécrit
  le relevé courant (à confirmer : comportement voulu ?) · tests : T04, T12 · sources : [Pointage.class:694-696](../../../../.src/Compta/Pointage.class#L694-L696), [Pointage.class:Dte_LostFocus](../../../../.src/Compta/Pointage.class#L424-L430)
