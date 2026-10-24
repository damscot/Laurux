# Imp_Bilan — Architecture

> Source : `.src/Compta/Impressions/Imp_Bilan.module`

## Vue d'ensemble

`Imp_Bilan` produit l'**édition PDF du bilan** (`~/tmp/Bilan.pdf`, classe `Cbilan`) à partir du
paramétrage des rubriques `B…` (`Fiches_Rubriques`, `Fiches_RubCompt`) et des écritures d'un
exercice (`Fiches_Mvt` à `Fiches_Mvt5`). Il est appelé uniquement par
[RubImp](../RubImp.class/architecture.md) (`Button2_Click`, bouton radio « Bilan »), via
`Lancement(Detail, dte0, dte1, dt1, dt2, exercice)`.

Tout le traitement tient dans **une seule fonction de 805 lignes (CC 335)**, organisée en blocs
successifs qui passent par deux **tables de travail** créées dans la base de la société :

```
Fiches_Mvt<x>  ──(B, D)──▶  Comptes (un solde par compte, N et N-1)
Fiches_RubCompt ─(E)──────▶  Comptes.numrub (affectation compte → rubrique)
Fiches_Rubriques + Comptes ─(F, G)──▶ centralisation (cumul par rubrique : col3 brut N,
                                       col4 amortissements N, col1/col2 N-1)
centralisation ─(H)──▶ Cbilan ──▶ ~/tmp/Bilan.pdf
```

Conventions métier relevées dans le code :
- **actif / passif** : rubriques `B0001`…`B1000` à l'actif (sens `A`, colonnes brut,
  amortissements, net), au-delà de `B1000` au passif (sens `P`, une colonne) ; le titre `B0010`
  ouvre l'actif, `B1010` le passif ;
- **signe** : les soldes sont `débit − crédit` ; au passif, un solde négatif est rendu positif et un
  solde positif devient négatif ;
- **règles d'exclusion** : pour une dizaine de rubriques, un compte n'est retenu que si son solde a
  le « bon » signe (comptes de tiers, banques, TVA répartis entre actif et passif selon le solde) ;
- **résultat** : la rubrique `B1205` reçoit le résultat de l'exercice calculé sur les classes 6 et 7.

Les valeurs N-1 (`col1`, `col2`, `solde2`, `RTot6`) sont **calculées mais jamais imprimées** :
`Cbilan.Level1`/`Level1L`/`Level1S` ignorent `imp3`/`imp4` et `Level3` n'affiche pas son second
libellé (voir IMP_BILAN-A01).

Nature globale : **mixte** (calcul + SQL + impression PDF + `Message.Info`), sans aucun accès à
des contrôles : le module est séparable de la GUI.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dteN0` | var | Private | oui | String | 10 |
| `dteN1` | var | Private | oui | String | 11 |
| `dtes1` | var | Private | oui | String | 12 |
| `dtes2` | var | Private | oui | String | 13 |
| `Det` | var | Private | oui | String | 14 |
| `Tab0` | var | Private | oui | String | 15 |
| `PosY` | var | Private | oui | Integer | 16 |
| `Nbpage` | var | Private | oui | Integer | 17 |
| `Ste` | var | Private | oui | String | 18 |
| `dateedition` | var | Private | oui | String | 19 |
| `exo` | var | Private | oui | String | 20 |
| `pdf` | var | Private | oui | Cbilan | 21 |
| `compt` | var | Private | oui | String | 22 |
| `totsldhp` | var | Private | oui | Float | 23 |
| `Imp1` | var | Private | oui | String | 24 |
| `Imp2` | var | Private | oui | String | 25 |
| `Imp3` | var | Private | oui | String | 26 |
| `Imp4` | var | Private | oui | String | 27 |
| `Imp5` | var | Private | oui | String | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Lancement` | 30-834 | Public | 335 | 745 | 1 |  |
| `Button1_Click` | 839-843 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### `Lancement(Detail, dte0, dte1, dt1, dt2, exercice)` — structure par blocs

[portée : nécessaire (appelée par `RubImp`)] [nature : mixte]. Paramètres : `dte0`/`dte1` période
N au format `dd.mm.yyyy`, `dt1`/`dt2` période N-1 (écrasée sauf pour `N5`), `exercice` ∈ {`E1`,
`N1`…`N5`}, `Detail` seulement transmis à `Cbilan.Level0`, qui l'ignore.

| Bloc | Lignes | Rôle | SQL émis |
|---|---|---|---|
| A. Initialisation | 111-166 | ouvre `~/tmp/BilanDetail.csv` et `~/tmp/BilanRub.csv` ; choisit `Tab5` (exercice N) et `Tab6` (N-1) selon `exercice` (`E1` → `Fiches_Mvt`/`Fiches_Mvt1`… `N5` → `Fiches_Mvt5`/rien) ; lit le nom de la société | `SELECT * FROM Fiches_Societes Where cd_sc = &1` |
| B. Tables de travail | 169-211 | `DROP` + `CREATE` de `centralisation` (clé `numrub, amortissement, amortissement2`) et `Comptes` (clé `compte`) | DDL avec `Utils.db.Engine()` |
| C. Résultat N et N-1 | 220-263 | somme débit/crédit des classes 6 et 7 : `RTot5 = (C7 − D7) − (D6 − abs(C6))` ; même calcul sur `Tab6` avec les dates N − 1 an pour `RTot6` (sans filtre `validee`) | `SELECT * FROM Tab5 WHERE left(compte,1) = &1 and dte … and validee = 1` (×2), idem `Tab6` (×2) |
| D. Soldes par compte N et N-1 | 268-343 | pour **chaque** compte de `Fiches_Comptes` hors types `C`, `F`, `G` : somme des écritures validées → `INSERT INTO Comptes (solde, annee 'N')` ; écrit chaque écriture dans `BilanDetail.csv` ; puis N-1 → `solde2` (`Try INSERT`, sinon `UPdate`) | 1 `SELECT` sur `Fiches_Comptes` + **1 `SELECT` `Tab5` par compte** + 1 `INSERT` par compte ; même chose sur `Tab6` |
| E. Affectation des comptes | 347-361 | pour chaque plage des rubriques `B` (`Fiches_RubCompt` ⋈ `Fiches_Rubriques`), écrit `numrub`, `intitrub` (40 car.), `type`, `amortissement` sur les comptes de `Comptes` compris dans la plage | 1 `SELECT` + 1 `SELECT Comptes` par plage + 1 `UPdate` par compte |
| F. Centralisation N | 367-502 | pour chaque rubrique `B` (ordre `numrub`) : ligne d'en-tête dans `centralisation` ; si type `L`, pour chaque plage puis chaque compte de `Comptes` de la plage : règles d'exclusion, inversion de signe au passif, cumul dans `col3` (brut) ou `col4` (amortissement) ; écrit `BilanRub.csv` ; pour un type `O`, écrit le cumul `Etot1` sur la rubrique `O` précédente | par rubrique : `SELECT`/`INSERT` en-tête, `SELECT Fiches_RubCompt`, `SELECT Comptes` par plage, `SELECT`+`UPdate centralisation` par compte |
| G. Centralisation N-1 | 507-634 | même parcours sur `solde2` → `col1`/`col2`, avec des règles d'exclusion **différentes** (voir tableau) | idem F |
| H. Impression | 639-828 | parcours de `centralisation` (`B…`, ordre `numrub`) et pilotage de `Cbilan` selon le type de rubrique (tableau ci-dessous) ; `Output` puis `Visualiseur.Prog` ; sinon `Message.Info("Rien a imprimer pour cette période !")` | `SELECT * FROM centralisation …` + 1 `SELECT intitule_cc FROM Cbase.Table("TabComptes")` par ligne |
| I. Fin | 831-832 | `Try Close` des deux CSV | — |

Pour 1 000 comptes, le bloc D seul émet environ 4 000 requêtes ; F et G en émettent une par
compte retenu. Le module ne lit jamais `Fiches_Parametres` (variable `Tab2` affectée puis
réaffectée).

#### Règles d'exclusion (blocs F et G)

Un compte de la rubrique est **exclu** (`imp = False`) si son préfixe et le signe de son solde
correspondent. Les préfixes de 2 ou 3 caractères sont comparés par `Left$`. Dans les expressions,
`Or If` (court-circuit) a la priorité la plus faible : chaque groupe `préfixe And condition` est
évalué seul.

| Rubrique | Bloc F (solde N) : préfixes exclus | condition N | Bloc G (solde N-1) : préfixes exclus | condition N-1 |
|---|---|---|---|---|
| `B0360` | tous | `<= 0` | — | — |
| `B0370` | tous | `<= 0` | tous | `< 0` |
| `B0420` | 428, 437, 438, 443, 444, 448, 451, 456, 467, 468, 478 | `<= 0` | 428, 438, 443, 444, 445, 448, 451, 456, 467, 468, 478 | `< 0` |
| `B0430` | 512 | `<= 0` | — | — |
| `B0450` | 52, 512, 514, 517, 518 | `<= 0` | 52, 512, 514, 517, 518 | `< 0` |
| `B1380` | 51, 58 (58 testé deux fois) | `> 0` | 51, 58 | `> 0` |
| `B1400` | 45 | `> 0` | 45 | `> 0` |
| `B1460` | 428, 437, 438, 443, 444, 445, 448, 451, 456, 467, 468, 478 | `> 0` | 443, 444, 445, 448, 475 | `> 0` |
| `B1500` | 451, 458, 467, 478, 411, 409 | `> 0` | 451, 458, 467, 478 | `> 0` |
| `B1510` | 52 | `> 0` | 52 | `> 0` |

Autres différences entre F et G (à conserver telles quelles en rework, voir IMP_BILAN-A02/A03/A05) :
- F remet `imp = True` **pour chaque compte** et force `imp = True` si le compte est
  d'amortissement ; G ne remet `imp` à vrai qu'au changement de rubrique (un compte exclu exclut
  les suivants de la même rubrique) et réutilise la dernière valeur d'`amort` lue en F ;
- au passif, F rend positif un solde négatif et **négatif un solde positif** ; G rend positif un
  solde négatif et laisse un solde positif inchangé ;
- F écrit si `(Ltot5 <> 0) Or If Ltot3 = 0`, G seulement si `Ltot5 <> 0` ;
- G cumule `col1` en partant de `col3` (valeur N) au lieu de `col1` (l.590).

#### Impression (bloc H) par type de rubrique

La ligne d'une rubrique `L` est imprimée **à la ligne suivante** de la boucle (impression
différée : `level1L` avec `intitrub2` et les cumuls `imp1`/`imp2` quand `rub` change).

| Type | Action `Cbilan` | Cumuls |
|---|---|---|
| `T` (titre) | `Baspage`, `Level0` (nouvelle page), `level3` (en-têtes de colonnes) ; mémorise le titre (`B0010` → sens `A`, `B1010` → `P`) | remet à zéro `Etot*`, `Stot*` |
| `E` (entête) | `level1` gras + filet ; pour `B1205`, imprime le résultat `RTot5` | `B1205` : `Stot1 += RTot5`, `Stot4` reçoit `RTot6` |
| `L` (ligne, `detail = O`) | aucune impression immédiate | `imp1 += col3` (signe inversé pour un compte `129…`), `imp2 = abs(imp2 + col4)`, `Stot1`/`Stot2` |
| `S` (sous-total) | `level1S` avec `Stot1`…`Stot4` + filet | ajoute à `Ttot*`, remet `Stot*` à 0 |
| `O` (total) | `level1S` avec `Ttot*` + filet | remet `Ttot*` et `Stot*` à 0 |
| `C`, `D` | `level1` avec `imp1`…`imp4` | — |
| `R`, `G` | `level1` ; `R` met `sens = 1` (ni `A` ni `P`) | — |

Pagination : `p` compte les lignes ; à `p = 40` nouvelle page (`Baspage` si déjà une page,
`Level0`, `level3`). Le compteur `p` est remis à 8 à chaque titre.

### `Button1_Click()`

[portée : réductible] [nature : GUI] — **code mort**. `Doc.Open("Bcrimp")` dans un module : aucun
contrôle ne peut déclencher ce handler et aucun fichier ne l'appelle (`grep -rn
"Imp_Bilan.Button1"` : aucun résultat). L'aide est déjà ouverte par `RubImp.Button1_Click`.

## État global utilisé

- `Start.Societe` (en-tête), `Utils.db`, `Utils.cpoint`, `Utils.PointBase`, `Utils.Cdate_Dbase`,
  `Cbase.Table("TabComptes")` (une seule fois, l.673), `Visualiseur.Prog`, `User.Home`.
- **Variables de module** (persistantes entre deux appels de `Lancement`) : `dteN0`, `dteN1`,
  `dtes1`, `dtes2`, `Det`, `Tab0`, `PosY`, `Ste`, `exo`, `pdf`, `compt`, `totsldhp`, `Imp1`…`Imp5`.
  `Imp1`…`Imp5` ne sont remises à zéro qu'en cours d'impression : une valeur résiduelle de
  l'édition précédente peut être lue en tête de la suivante (à confirmer par T06).
  `Nbpage`, `dateedition`, `totsldhp` sont écrites mais jamais lues ; `Imp3`, `Imp4`, `Imp5` ne
  valent jamais autre chose que 0.
- Variables locales inutilisées ou constantes : `RubO`, `typeE`, `cpt3`, `cptE`, `Ltot1`, `Otot2`,
  `Ttot3` (toujours 0), `p5` (toujours `""`), `Hnew`/`Hnew2` corrects ; `Tab2`/`Tab3`/`Tab4`
  réaffectés en cours de route (`Tab3` désigne d'abord `Fiches_RubCompt` puis `Comptes`).

## Propositions d'amélioration

### Réécriture / refactorisation (découpage proposé, résultat identique)

Découper `Lancement` en procédures privées qui émettent **le même SQL dans le même ordre**
(rework « sans changement SQL », le diff `Exec_SQL` du replay est bloquant) :

1. `TablesExercice(sExercice) As String[]` → `[Tab5, Tab6]` (bloc A, commun avec `Imp_Sig` et
   `RubImp`) ;
2. `CreeTablesTravail()` (bloc B) ;
3. `ResultatPeriode(sTab, sDeb, sFin, bValidee) As Float` (bloc C, appelée deux fois ; le filtre
   `validee` n'existe que pour N) ;
4. `SoldesComptes(sTab, sDeb, sFin, bN As Boolean, hCsv As File)` (bloc D) ;
5. `AffecteRubriques()` (bloc E) ;
6. `Centralise(bN As Boolean)` (blocs F et G) avec une **table de règles** par période :
   `$aReglesN`/`$aReglesN1` (lignes `rubrique;préfixes;condition`) et une fonction pure
   `Exclu(sRub, sCpt, fSolde, aRegles) As Boolean` ; les différences F/G listées plus haut deviennent
   des paramètres explicites (remise à zéro d'`imp`, règle de signe du passif, colonne cible,
   colonne de départ du cumul) pour garder le résultat exact ;
7. `Imprime()` (bloc H) : `Select Case type` sur les sept types, une procédure par type, en
   conservant l'impression différée des lignes `L` et l'ordre des remises à zéro.

CC visée : ≤ 15 par procédure (335 aujourd'hui). Le tableau de règles rend aussi visibles les
incohérences N/N-1 (A05) sans les corriger.

Autres simplifications sans effet : suppression des affectations sans effet (`Stot1 = Stot1`,
`Stot4 = Stot4`, `Stot2 = Stot2`), du test `58` dupliqué (l.409-412), du `Shell "cd " & User.Home`
(l.647, sans effet sur le processus), du `Try cptE = Rubcompt!compte` (l.818), des arguments en trop
passés à `Exec` (`"N"`, `amort`, `actif` sans `&n` correspondant : SQL identique).

### Commonalisation avec d'autres fichiers

- **Choix des tables Mvt par exercice** : copié dans [Imp_Sig](../Imp_Sig.module/architecture.md)
  et [RubImp](../RubImp.class/architecture.md) ; `Cbase.Table("TabMvt" & n)` existe déjà
  (`TabMvt`, `TabMvt1`…`TabMvt5`) : un helper `TablesExercice` commun.
- **En-tête société** (`"Societe " & " " & int_sc`) : même code dans `Imp_Sig`, `RubImp` et trois
  autres fichiers.
- **Table de travail `centralisation`** : créée avec des structures différentes par `Imp_Sig`,
  `RubImp`, [Jourcent](../Jourcent.class/architecture.md), [EcrM](../EcrM.class/architecture.md),
  [ExportA47](../ExportA47.class/architecture.md), `Intjdv`, `JournauxM` : un helper
  `Utils.TableTravail(sNom, sColonnes)` (DROP + CREATE + `Engine()`) éviterait sept copies.
- **Parcours rubrique → plages → comptes** : même double boucle dans `Imp_Sig` (une fois) et `RubImp`
  (deux fois) ; un itérateur commun `PlagesRubrique(sPrefixe)` est envisageable après les tests.

### Réduction de portée

- `Button1_Click` : supprimé (code mort).
- Variables de module → variables locales passées en paramètre (sous réserve de T06 : si une
  valeur résiduelle d'`Imp1` influe aujourd'hui sur la seconde édition, le changement devient une
  anomalie).

### Séparation traitement / GUI

- Le module ne touche aucun contrôle. Le seul couplage GUI est `Message.Info` (rien à imprimer) et
  `Visualiseur.Prog` : `Lancement` peut renvoyer le chemin du PDF (ou `""`), l'appelant affichant le
  message et le visualiseur. Utile pour un test gb.test de `Centralise` sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Tables de travail `centralisation` et `Comptes` en `CREATE TEMPORARY TABLE` (propres à la
  connexion) ou suffixées par poste : supprime les collisions entre postes et ne laisse plus de
  tables hors `db_control.csv` dans la base.
- Règles d'exclusion actuellement codées en dur : une colonne dans `Fiches_RubCompt` (sens de
  solde attendu) permettrait de les paramétrer avec les plages.
- Soldes par compte calculés par `SELECT compte, SUM(montantd - montantc) … GROUP BY compte` avec
  un index `(compte, validee, dte)` sur les tables `Fiches_Mvt*`.
