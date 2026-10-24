# RubImp — Rework

> Source : `.src/Compta/Impressions/RubImp.class` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/RubImp.class/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 983 |
| Lignes de commentaire | 62 |
| Fonctions | 29 |
| Fonctions Public | 29 |
| Complexité cyclomatique totale | 198 |
| Complexité max (fonction) | 135 (`Button2_Click`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 983 | 198 | 135 | 0 | 29 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] RUBIMP-001 — [documentation] En-tête en français : rôle de l'écran, aiguillage vers
  `Imp_Bilan`/`Imp_Sig`, blocs A à J du compte de résultat, signification de `dteclec`…`dteclec5`,
  table de travail · appelants : aucun · tests : aucun · sources : [RubImp.class:_New](../../../../../.src/Compta/Impressions/RubImp.class#L27-L36), [RubImp.class:Button2_Click](../../../../../.src/Compta/Impressions/RubImp.class#L421-L1133)
- [ ] RUBIMP-002 — [code mort] Supprimer `E0_Click` et `Ex1` (contrôle `E0` absent du `.form`),
  `Raz` (vide) et ses 7 appels, `Shell "cd …"`, `det = rResult!detail & "detail"`, les variables
  inutilisées (`Tab2`, `Tab4`, `RubO`, `cpt3`, `Otot1`, `Ttot1`, `Ltot1`, `Etot4`, `Nbpage`,
  `dateedition`) · appelants : aucun · tests : T01-T05 · sources : [RubImp.class:E0_Click](../../../../../.src/Compta/Impressions/RubImp.class#L368-L373), [RubImp.class:Ex1](../../../../../.src/Compta/Impressions/RubImp.class#L87-L113), [RubImp.class:Raz](../../../../../.src/Compta/Impressions/RubImp.class#L417-L419), [RubImp.class:1002](../../../../../.src/Compta/Impressions/RubImp.class#L1002), [RubImp.class:817](../../../../../.src/Compta/Impressions/RubImp.class#L817)
- [ ] RUBIMP-003 — [commonalisation] `Exo(k)` unique et `Recup_Dtes` fondés sur
  `LDate.Exercice_Cloture(k)` (`Calc_mois(….G)` et `.L`, chaînes identiques vérifiées par T05/T09),
  helper `BornesExercice(k)` partagé avec `Verbal` (VERBAL-007) et proposé aux 8 écrans de
  `Compta/Impressions` ; handlers `E1_Click`…`N5_Click` inchangés · appelants : aucun · tests : T03,
  T05, T09 · sources : [RubImp.class:Exo](../../../../../.src/Compta/Impressions/RubImp.class#L115-L136), [RubImp.class:Exo5](../../../../../.src/Compta/Impressions/RubImp.class#L214-L234), [RubImp.class:Recup_Dtes](../../../../../.src/Compta/Impressions/RubImp.class#L38-L85), [LDate.class:Exercice_Cloture](../../../../../.src/Utils/LDate.class#L648-L672)
- [ ] RUBIMP-004 — [commonalisation] Choix des tables Mvt et en-tête société par les helpers de
  IMP_BILAN-003/004 (SQL identique) · appelants : aucun · tests : T01, T03 · sources : [RubImp.class:504-535](../../../../../.src/Compta/Impressions/RubImp.class#L504-L535)
- [ ] RUBIMP-005 — [complexité] Découper `Button2_Click` (CC 135) en `CreeCentralisation`,
  `SousTotaux`, `TotauxProduitsCharges`, `Resultat`, `LignesRG`, `Imprime` ; mêmes requêtes dans le
  même ordre (diff `Exec_SQL` bloquant), requêtes sans `ORDER BY` conservées · appelants : aucun ·
  tests : T01-T04, T08, T10 · sources : [RubImp.class:Button2_Click](../../../../../.src/Compta/Impressions/RubImp.class#L421-L1133)
- [ ] RUBIMP-006 — [commonalisation] Blocs D et E fusionnés en `CentralisePeriode(sTab, sDeb, sFin,
  sCol, sDetail, bEnteteComplet)` reproduisant exactement leurs différences (colonne, caractère de
  détail `O`/`0`, mise à jour de l'en-tête, `type`/`typeE`) ; sans changement SQL · appelants :
  aucun · tests : T01-T03 · sources : [RubImp.class:597-690](../../../../../.src/Compta/Impressions/RubImp.class#L597-L690), [RubImp.class:697-799](../../../../../.src/Compta/Impressions/RubImp.class#L697-L799)
- [ ] RUBIMP-007 — [séparation traitement/GUI] Lecture unique des contrôles puis
  `EditionResultat(sExercice, bDetail, sDeb, sFin, sPeriode)` sans accès aux contrôles ; le handler
  garde messages, souris et aiguillage · appelants : aucun · tests : T01-T04 · sources : [RubImp.class:Button2_Click](../../../../../.src/Compta/Impressions/RubImp.class#L421-L1133)
- [ ] RUBIMP-008 — [réduction de portée] `Recup_Dtes`, `Exo`…`Exo5`, `Compdate`, `compdate2` →
  `Private` (couverts par T05/T06) · appelants : aucun · tests : T05, T06 · sources : [RubImp.class:Recup_Dtes](../../../../../.src/Compta/Impressions/RubImp.class#L38-L85), [RubImp.class:Compdate](../../../../../.src/Compta/Impressions/RubImp.class#L342-L353), [RubImp.class:compdate2](../../../../../.src/Compta/Impressions/RubImp.class#L355-L366)
- [ ] RUBIMP-009 — [commonalisation] Noms de tables par `Cbase.Table` (`TabParam`, `TabSoc`,
  `TabMvt*`, `TabRubriques`, `TabRubCompt`), SQL identique · appelants : `Cbase` · tests : T01 ·
  sources : [RubImp.class:499-533](../../../../../.src/Compta/Impressions/RubImp.class#L499-L533)
- [ ] RUBIMP-010 — [séparation traitement/GUI] Recevoir de `Imp_Bilan.Lancement` /
  `Imp_Sig.Lancement` le chemin du PDF et afficher ici « Rien a imprimer… » ou le visualiseur
  (avec IMP_BILAN-010 et IMP_SIG-008, même commit) · appelants : `Imp_Bilan`, `Imp_Sig` · tests :
  T04, IMP_BILAN-T07, IMP_SIG-T06 · sources : [RubImp.class:588](../../../../../.src/Compta/Impressions/RubImp.class#L588), [RubImp.class:591](../../../../../.src/Compta/Impressions/RubImp.class#L591)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] RUBIMP-A01 — [anomalie] Quitter ne supprime jamais le PDF : `Btn_Click` teste la variable de
  classe `Filename`, jamais affectée (`Button2_Click` utilise une locale `filename`) · tests : T07 ·
  sources : [RubImp.class:275](../../../../../.src/Compta/Impressions/RubImp.class#L275), [RubImp.class:492](../../../../../.src/Compta/Impressions/RubImp.class#L492)
- [ ] RUBIMP-A02 — [anomalie] Contrôle des dates saisies : comparaison avec `dte` (chaîne brute
  `mm/dd/yyyy` recomposée en `aaaajjmm`) qui contient la clôture de l'exercice **précédent** :
  avertissements et remises à l'exercice en cours intempestifs ou absents (à confirmer) · tests :
  T06 · sources : [RubImp.class:302](../../../../../.src/Compta/Impressions/RubImp.class#L302), [RubImp.class:323](../../../../../.src/Compta/Impressions/RubImp.class#L323)
- [ ] RUBIMP-A03 — [anomalie] En-tête « Exercice N -1 du … au … » : la fin affichée est la clôture
  N-1 **+ 1 jour** et les dates affichées (`Recup_Dtes`) diffèrent de celles du calcul (`DteN0`/
  `DteN1` − 1 an) pour une période partielle · tests : T05 · sources : [RubImp.class:78](../../../../../.src/Compta/Impressions/RubImp.class#L78), [RubImp.class:706-709](../../../../../.src/Compta/Impressions/RubImp.class#L706-L709)
- [ ] RUBIMP-A04 — [anomalie] En N-1, le détail des comptes reçoit `detail = "0"` (zéro) au lieu de
  `"O"` : le tri `numrub, detail, compte` place ces comptes avant la ligne de synthèse et les autres
  après (édition détaillée) · tests : T02 · sources : [RubImp.class:742](../../../../../.src/Compta/Impressions/RubImp.class#L742)
- [ ] RUBIMP-A05 — [anomalie] `Resultat.csv` : chaque écriture est écrite deux fois (la première
  avec une ligne vide supplémentaire) · tests : T01 · sources : [RubImp.class:630](../../../../../.src/Compta/Impressions/RubImp.class#L630), [RubImp.class:631](../../../../../.src/Compta/Impressions/RubImp.class#L631)
- [ ] RUBIMP-A06 — [anomalie] Requêtes sans `ORDER BY` dont l'ordre conditionne les cumuls
  (`SELECT * FROM centralisation`, jointure des totaux, lecture des deux `O` dont la première est
  prise pour `Ttot` sans contrôle du préfixe au-delà de la première ligne) : résultat dépendant du
  moteur (SQLite : ordre d'insertion) · tests : T08 · sources : [RubImp.class:811](../../../../../.src/Compta/Impressions/RubImp.class#L811), [RubImp.class:868](../../../../../.src/Compta/Impressions/RubImp.class#L868), [RubImp.class:898-916](../../../../../.src/Compta/Impressions/RubImp.class#L898-L916), [RubImp.class:950](../../../../../.src/Compta/Impressions/RubImp.class#L950)
- [ ] RUBIMP-A07 — [anomalie] Bilan et SIG : la table `centralisation` du compte de résultat est
  créée puis détruite par `Imp_Bilan`/`Imp_Sig`, `Resultat.csv` est vidé et le message « traitement
  long » s'affiche ; `Impd` reste transmis bien que désactivé · tests : T04 · sources : [RubImp.class:494-498](../../../../../.src/Compta/Impressions/RubImp.class#L494-L498), [RubImp.class:552-566](../../../../../.src/Compta/Impressions/RubImp.class#L552-L566)
