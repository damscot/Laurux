# Imp_Bilan — Rework

> Source : `.src/Compta/Impressions/Imp_Bilan.module` · Message de commit (phase 4) : `reference/.src/Compta/Impressions/Imp_Bilan.module/rework.md <REWORK_ID>`

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 767 |
| Lignes de commentaire | 46 |
| Fonctions | 2 |
| Fonctions Public | 2 |
| Complexité cyclomatique totale | 336 |
| Complexité max (fonction) | 335 (`Lancement`) |
| Variables globales | 0 |
| Variables Public | 0 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Historique des KPI

<!-- AUTO:historique -->
| Étape | Commit | Date | LOC | CC tot. | CC max | Globales | Fonc. Public | Couverture | Durée tests |
|---|---|---|---|---|---|---|---|---|---|
| initial | `6b6b9dfc` | 2026-10-24 | 767 | 336 | 335 | 0 | 2 | n/a | n/a |
<!-- /AUTO:historique -->

## Étapes

<!-- Cases séquentielles : - [ ] <ID>-NNN — [catégorie] description · appelants impactés · tests à repasser -->

- [ ] IMP_BILAN-001 — [documentation] En-tête en français : rôle, schéma des blocs A à I, tables
  de travail, conventions actif/passif et signe, tableau des règles d'exclusion, types de rubriques
  à l'impression, valeurs N-1 non imprimées · appelants : aucun · tests : aucun · sources : [Imp_Bilan.module:Lancement](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L30-L834)
- [ ] IMP_BILAN-002 — [code mort] Supprimer `Button1_Click` (handler dans un module, jamais
  déclenché ni appelé), les variables inutilisées (`RubO`, `typeE`, `cpt3`, `cptE`, `Ltot1`,
  `Otot2`, `Nbpage`, `dateedition`, `totsldhp`), les affectations sans effet (`Stot1 = Stot1`…),
  le test `58` dupliqué, `Shell "cd …"` et `Try cptE = Rubcompt!compte` ; arguments `Exec` sans
  `&n` retirés (SQL identique) · appelants : aucun · tests : T01-T05 · sources : [Imp_Bilan.module:Button1_Click](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L839-L843), [Imp_Bilan.module:409](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L409), [Imp_Bilan.module:647](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L647), [Imp_Bilan.module:818](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L818), [Imp_Bilan.module:700](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L700)
- [ ] IMP_BILAN-003 — [commonalisation] `TablesExercice(sExercice) As String[]` basé sur
  `Cbase.Table("TabMvt…")`, partagé avec `Imp_Sig` et `RubImp` (même table de correspondance,
  SQL identique) · appelants : `Imp_Sig`, `RubImp` · tests : T01-T03, T09 · sources : [Imp_Bilan.module:129-151](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L129-L151), [Imp_Sig.module:109-131](../../../../../.src/Compta/Impressions/Imp_Sig.module#L109-L131), [RubImp.class:504-532](../../../../../.src/Compta/Impressions/RubImp.class#L504-L532)
- [ ] IMP_BILAN-004 — [commonalisation] En-tête société (`Fiches_Societes` → `"Societe  " &
  int_sc`) par un helper commun avec `Imp_Sig` et `RubImp` (SQL identique) · appelants : `Imp_Sig`,
  `RubImp` · tests : T01 · sources : [Imp_Bilan.module:152-154](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L152-L154), [Imp_Sig.module:132-134](../../../../../.src/Compta/Impressions/Imp_Sig.module#L132-L134), [RubImp.class:533-535](../../../../../.src/Compta/Impressions/RubImp.class#L533-L535)
- [ ] IMP_BILAN-005 — [complexité] Règles d'exclusion pilotées par deux tables (`$aReglesN`,
  `$aReglesN1`, copie exacte du tableau d'architecture.md) et fonction pure `Exclu(sRub, sCpt,
  fSolde, aRegles) As Boolean` ; les différences F/G (remise à zéro d'`imp`, `amort` forcé) restent
  explicites. Sans changement SQL · appelants : aucun · tests : T04, T08 · sources : [Imp_Bilan.module:394-430](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L394-L430), [Imp_Bilan.module:543-571](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L543-L571)
- [ ] IMP_BILAN-006 — [complexité] Découper `Lancement` (CC 335) en procédures privées
  `CreeTablesTravail`, `ResultatPeriode`, `SoldesComptes`, `AffecteRubriques`, `Centralise(bN)`,
  `Imprime` (voir architecture.md), mêmes requêtes dans le même ordre (diff `Exec_SQL` bloquant) ;
  signature de `Lancement` inchangée · appelants : aucun · tests : T01-T07, T10 · sources : [Imp_Bilan.module:Lancement](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L30-L834)
- [ ] IMP_BILAN-007 — [complexité] `Imprime` : `Select Case` sur le type de rubrique, une
  procédure par type, impression différée des lignes `L` et ordre des remises à zéro conservés ·
  appelants : aucun · tests : T01-T05 · sources : [Imp_Bilan.module:639-828](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L639-L828)
- [ ] IMP_BILAN-008 — [réduction de portée] Variables de module (`dteN0`, `dteN1`, `dtes1`,
  `dtes2`, `Det`, `Tab0`, `PosY`, `Ste`, `exo`, `pdf`, `compt`, `Imp1`…`Imp5`) → variables locales
  ou paramètres des procédures de IMP_BILAN-006, **seulement si T06 montre que la seconde édition
  ne dépend pas de l'état laissé par la première** (sinon voir A09) · appelants : aucun · tests :
  T06, T01 · sources : [Imp_Bilan.module:10-28](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L10-L28)
- [ ] IMP_BILAN-009 — [commonalisation] Noms de tables par `Cbase.Table` (`TabSoc`, `TabComptes`,
  `TabMvt*`, `TabRubriques`/`TabRubCompt` ajoutées avec RUBCOMPT-006), SQL identique · appelants :
  `Cbase` · tests : T01 · sources : [Imp_Bilan.module:122-152](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L122-L152), [Imp_Bilan.module:269-273](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L269-L273)
- [ ] IMP_BILAN-010 — [séparation traitement/GUI] `Lancement` renvoie le chemin du PDF (ou `""`) ;
  `RubImp` affiche « Rien a imprimer… » et appelle `Visualiseur.Prog` (même message, même ordre) ·
  appelants : `RubImp` · tests : T01, T07 · sources : [Imp_Bilan.module:824-828](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L824-L828), [RubImp.class:588](../../../../../.src/Compta/Impressions/RubImp.class#L588)
- [ ] IMP_BILAN-011 — [complexité] Bloc D : une requête par table Mvt (`… WHERE validee = 1 AND
  dte … ORDER BY compte, dte`) parcourue en parallèle de `Fiches_Comptes` au lieu d'une requête par
  compte ; mêmes `INSERT` dans `Comptes` et même `BilanDetail.csv` (SQL modifié, dump identique ;
  ordre des écritures d'un même jour à valider par T01/T10, sinon abandon) · appelants : aucun ·
  tests : T01-T03, T10 · sources : [Imp_Bilan.module:276-305](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L276-L305), [Imp_Bilan.module:309-343](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L309-L343)

### Anomalies : changement de comportement, validation utilisateur requise

Ces étapes ne sont **pas** exécutées en phase 4 autonome sans accord explicite. Les tests de
caractérisation figent le comportement actuel et devront être mis à jour avec la correction.

- [ ] IMP_BILAN-A01 — [anomalie] Les valeurs N-1 (résultat `RTot6`, `Comptes.solde2`,
  `centralisation.col1/col2`, bloc G entier) sont calculées mais jamais imprimées (`Cbilan` ignore
  `imp3`/`imp4` et le libellé « Exercice N -1 ») : soit imprimer la colonne N-1, soit supprimer le
  calcul (dump des tables de travail modifié) · tests : T01-T03 · sources : [Imp_Bilan.module:243-263](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L243-L263), [Imp_Bilan.module:507-634](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L507-L634), [Cbilan.class:Level3](../../../../../.src/Reports/Cbilan.class#L173-L198)
- [ ] IMP_BILAN-A02 — [anomalie] N-1 : le cumul de `col1` part de `col3` (valeur N) au lieu de
  `col1` · tests : T01, T04 · sources : [Imp_Bilan.module:590](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L590)
- [ ] IMP_BILAN-A03 — [anomalie] N-1 : `imp` n'est pas remis à vrai pour chaque compte (un compte
  exclu exclut les suivants de la rubrique) et `amort` garde la dernière valeur lue en N ·
  tests : T04, T05 · sources : [Imp_Bilan.module:522](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L522), [Imp_Bilan.module:572](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L572)
- [ ] IMP_BILAN-A04 — [anomalie] Résultat N-1 calculé sans filtre `validee = 1` (le N filtre) ·
  tests : T01 · sources : [Imp_Bilan.module:249](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L249), [Imp_Bilan.module:221](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L221)
- [ ] IMP_BILAN-A05 — [anomalie, à valider par un comptable] Règles d'exclusion différentes entre
  N et N-1 (`B0360`, `B0430` absentes en N-1 ; listes `B0420`, `B1460`, `B1500` différentes ;
  `<= 0` contre `< 0`) et règle de signe du passif différente · tests : T04 · sources : [Imp_Bilan.module:394-441](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L394-L441), [Imp_Bilan.module:543-578](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L543-L578)
- [ ] IMP_BILAN-A06 — [anomalie] Tables de travail `centralisation` et `Comptes` créées par
  `DROP`/`CREATE` dans la base de la société, sous un nom partagé avec six autres éditions : deux
  éditions simultanées sur deux postes se corrompent ; les tables restent dans la base · tests :
  T01 · sources : [Imp_Bilan.module:169-211](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L169-L211)
- [ ] IMP_BILAN-A07 — [anomalie] Une rubrique de type `R` met `sens = 1` (ni `A` ni `P`) : mise en
  page passif pour la suite (aucune rubrique `B` de type `R` dans `Laurux01.sql`, latent) · tests :
  aucun (latent) · sources : [Imp_Bilan.module:800](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L800)
- [ ] IMP_BILAN-A08 — [anomalie] Compte `129` : `imp1 = "-" & imp1` produit `--x` si le cumul est
  déjà négatif (valeur lue ensuite par `Val`, résultat à confirmer) · tests : T05 · sources : [Imp_Bilan.module:724](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L724)
- [ ] IMP_BILAN-A09 — [anomalie, à confirmer] État de module persistant entre deux éditions
  (`Imp1`…`Imp5` testés avant leur remise à zéro en tête d'impression) · tests : T06 · sources : [Imp_Bilan.module:676-685](../../../../../.src/Compta/Impressions/Imp_Bilan.module#L676-L685)
