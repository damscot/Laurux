# Balance — Architecture

> Source : `.src/Compta/Impressions/Balance.class`

## Vue d'ensemble

`Balance` est l'**écran d'édition des balances comptables** (menu Comptabilité > Impressions >
Balances, `Fmenu.Menu31_Click` → `Balance.Show`, auto-instance). Il propose :

- trois natures de balance (`Bclient`, `Bfournisseur`, `Bgestion`), mémorisées dans `Type`/`Type2`
  (`"C"/"C"`, `"F"/"F"`, `"G"/"B"` pour la balance générale = comptes de gestion **et** de bilan) ;
- une période (`dteN0`, `dteN1`) préremplie à partir des dates de clôture `dteclec*` de
  `Fiches_Parametres`, et une table d'écritures `Tab0` (`Fiches_Mvt` … `Fiches_Mvt5`) choisie par les
  boutons radio d'exercice ;
- une plage de comptes (`Cpt`, `Cpt2`, sélection assistée par `TriCpt`) et, pour les clients, un
  filtre par type de client (`TypeClient1`, contrôle `TypeClient` qui produit un fragment
  `cli_typec IN(...)`) ;
- deux options (`Impcumul` : colonnes « hors période », `Impc` : comptes non mouvementés) ;
- deux sorties : **Imprimer** (`Button1_Click` → [`BalanceM.Imprime`](../BalanceM.module/architecture.md),
  PDF `~/tmp/Balance.pdf`) et **Exporter** (`Button2_Click`, fichier texte `;` `~/balances.txt`, code
  local à la classe).

Correspondance boutons d'exercice ↔ période ↔ table (les commentaires du source sont trompeurs :
`Ex1` est commenté « exercice en cours » mais `Exo` « exercice en cours de bilan ») :

| Bouton (`.form`) | Handler | Période calculée | `Tab0` |
|---|---|---|---|
| `E0` « Exercice en cours » | `E0_Click` → `Ex1` | `Calc_mois(dteclec)` → aujourd'hui (ou `Exo` si aujourd'hui est avant le début) | `TabMvt` |
| `E1` « Exercice précédent » | `E1_Click` → `Exo` | `Calc_mois(dteclec1)` → `dteclec` | `TabMvt` |
| `N1` … `N4` | `Nn_Click` → `Exon` | `Calc_mois(dteclec(n+1))` → `dteclec(n)` | `TabMvt1` … `TabMvt4` |
| `N5` | `N5_Click` → `Exo5` | `dteclec5 − 1 an + 1 jour` → `dteclec5` | `TabMvt5` |

`Fiches_Mvt` contient donc l'exercice courant **et** l'exercice précédent non archivé (« exercice en
cours de bilan »), `Fiches_Mvt1` l'exercice clos le `dteclec1`, etc. (lecture conforme à
[`LDate`](../../../Utils/LDate.class/architecture.md), propriétés `EDeb`/`EFin`/`EInd`).

Nature globale : **GUI**, avec deux blocs de traitement noyés dans les handlers (lecture des
bornes d'exercice, export texte).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DebHP` | var | Private |  | Float | 29 |
| `CredHP` | var | Private |  | Float | 30 |
| `TotSldHP` | var | Private |  | Float | 31 |
| `TotDeb` | var | Private |  | Float | 32 |
| `TotCred` | var | Private |  | Float | 33 |
| `TotSld` | var | Private |  | Float | 34 |
| `debit` | var | Private |  | Float | 35 |
| `credit` | var | Private |  | Float | 36 |
| `solde` | var | Private |  | Float | 37 |
| `dte` | var | Private |  | String | 38 |
| `dte1` | var | Private |  | String | 39 |
| `dte2` | var | Private |  | String | 40 |
| `Txt` | var | Private |  | String | 41 |
| `Filename` | var | Private |  | String | 42 |
| `Filetxt` | var | Private |  | String | 43 |
| `jour` | var | Private |  | String | 44 |
| `Type` | var | Private |  | String | 45 |
| `Type2` | var | Private |  | String | 46 |
| `hfile` | var | Private |  | File | 47 |
| `Tab0` | var | Private |  | String | 48 |
| `Nom` | var | Private |  | String | 49 |
| `Compt` | var | Private |  | String | 50 |
| `TotDeb2` | var | Private |  | Float | 51 |
| `TotCred2` | var | Private |  | Float | 52 |
| `TotSld2` | var | Private |  | Float | 53 |
| `PosY` | var | Private |  | Integer | 54 |
| `Ste` | var | Private |  | String | 55 |
| `Bsel` | var | Public |  | Boolean | 57 |
| `Bval` | var | Public |  | String | 58 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 63-78 | Public | 1 | 14 | 0 | méthode spéciale |
| `Ex1` | 83-111 | Public | 4 | 26 | 0 | portée réductible ? |
| `Exo` | 116-140 | Public | 3 | 22 | 0 | portée réductible ? |
| `Exo1` | 145-164 | Public | 3 | 17 | 0 | portée réductible ? |
| `Exo2` | 169-188 | Public | 3 | 17 | 0 | portée réductible ? |
| `Exo3` | 193-212 | Public | 3 | 17 | 0 | portée réductible ? |
| `Exo4` | 217-236 | Public | 3 | 17 | 0 | portée réductible ? |
| `Exo5` | 241-261 | Public | 3 | 18 | 0 | portée réductible ? |
| `Bal_KeyPress` | 266-311 | Public | 12 | 36 | 0 | handler GUI |
| `Btn_Click` | 316-333 | Public | 6 | 11 | 0 | handler GUI |
| `Bal_GotFocus` | 338-344 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LF` | 349-369 | Public | 5 | 19 | 0 | portée réductible ? |
| `dteN1_LF` | 371-402 | Public | 8 | 27 | 0 | portée réductible ? |
| `Compdate` | 404-416 | Public | 3 | 11 | 0 | portée réductible ? |
| `compdate2` | 418-430 | Public | 3 | 11 | 0 | portée réductible ? |
| `Raz` | 435-452 | Public | 1 | 16 | 0 | portée réductible ? |
| `Bclient_Click` | 457-467 | Public | 1 | 9 | 0 | handler GUI |
| `Bfournisseur_Click` | 472-482 | Public | 1 | 9 | 0 | handler GUI |
| `Bgestion_Click` | 487-497 | Public | 1 | 9 | 0 | handler GUI |
| `E0_Click` | 502-507 | Public | 1 | 4 | 0 | handler GUI |
| `E1_Click` | 512-517 | Public | 1 | 4 | 0 | handler GUI |
| `N1_Click` | 522-527 | Public | 1 | 4 | 0 | handler GUI |
| `N2_Click` | 532-537 | Public | 1 | 4 | 0 | handler GUI |
| `N3_Click` | 542-547 | Public | 1 | 4 | 0 | handler GUI |
| `N4_Click` | 552-557 | Public | 1 | 4 | 0 | handler GUI |
| `N5_Click` | 562-567 | Public | 1 | 4 | 0 | handler GUI |
| `Button4_Click` | 569-584 | Public | 3 | 13 | 0 | handler GUI |
| `Button5_Click` | 586-601 | Public | 3 | 13 | 0 | handler GUI |
| `donnees2` | 603-607 | Public | 1 | 3 | 0 | portée réductible ? |
| `donnees1` | 609-613 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button1_Click` | 618-622 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button2_Click` | 627-720 | Public | 20 | 91 | 0 | portée réductible ? |
| `Button3_Click` | 726-730 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. Fixe `Filetxt = ~/balances.txt`,
  charge le son, centre la fenêtre, branche les observateurs (`Utils.Observers(Me)`), appelle
  `E0_Click()` (donc `Tab0 = TabMvt` et `Ex1`), puis positionne la balance client
  (`Cpt = 41100001`, `Cpt2 = 99999999`, `Type = Type2 = "C"`, `Nom = "Client"`, avec une majuscule
  alors que `Bclient_Click` écrit `"client"` : le titre du PDF diffère selon le chemin).

### Bornes d'exercice (`Ex1`, `Exo`, `Exo1` … `Exo5`)

- **`Ex1()`** [portée : réductible] [nature : mixte]. `Raz()`, vide les dates, lit
  `SELECT * FROM Fiches_Parametres` (`Cbase.Table("TabParam")`), `dteN0 = Utils.Calc_mois(dteclec)`
  (1er jour du mois suivant la clôture). Si la date du jour est antérieure à ce début (comparaison de
  chaînes `aaaammjj`), bascule sur `Exo()` ; sinon `dteN1 = aujourd'hui`. Mémorise les bornes
  autorisées dans `dte1`/`dte2`. `Catch` : son + `Message.Error`.
- **`Exo()`** [portée : réductible] [nature : mixte]. Même requête ; période
  `Calc_mois(dteclec1)` → `Cdate_aff(dteclec)`. Appelé aussi par `Compdate`/`compdate2` et par
  `dteN1_LF` après une saisie incohérente.
- **`Exo1()` … `Exo4()`** [portée : réductible] [nature : mixte]. Corps identiques au champ près
  (`dteclec(n+1)` / `dteclec(n)`), sans remise à blanc des champs. Chacun refait le `SELECT *`.
- **`Exo5()`** [portée : réductible] [nature : mixte]. Début = `DateAdd(DateAdd(dteclec5, -1 an),
  +1 jour)` (suppose un exercice de 12 mois, comme `LDate.Exercice_Debut`, cf. LDATE-A02) ; variable
  locale `Mois` inutilisée.

Ces sept fonctions répètent le même squelette (requête, `With Utils`, `Catch` identique) : 7 × 15 à
24 lignes. Les mêmes fonctions existent, sans `Cbase` ni `Catch`, dans
[`Editcompte`](../Editcompte.class/architecture.md) et [`EditcompteA`](../EditcompteA.class/architecture.md),
et dans `Journaux`, `JournauxA`, `Jourcent`, `EcrM`, `ExportA47`, `RubImp` (9 fichiers définissent `Exo5`).

### Navigation clavier et contrôles de date

- **`Bal_KeyPress()`** [portée : nécessaire, handler du groupe `Bal`] [nature : GUI]. Entrée/Tab :
  passe au champ suivant selon `Last.Tag` (1 `dteN0` → contrôle `dteN0_LF`, 2 `dteN1` → `dteN1_LF`,
  3 `Cpt`, 4 `Cpt2` → retour à `dteN0`). F2 sur `Cpt`/`Cpt2` ouvre `TriCpt` ; F1 ouvre l'aide.
- **`Bal_GotFocus()`** [portée : nécessaire, handler] [nature : GUI]. Coloration du champ actif
  (`Utils.SetEditColor`).
- **`dteN0_LF()` / `dteN1_LF()`** [portée : réductible] [nature : mixte]. Normalisent la saisie
  (`Utils.Cdate_calc` puis `Cdate_aff` ; la valeur sentinelle `"00.00.0:00"` est remplacée par la
  date du jour), puis comparent (`Val` de `aaaammjj`) aux bornes `dte1`/`dte2` : hors bornes →
  `Txt` + `Compdate()` / `compdate2()`. `dteN1_LF` signale en plus `dteN1 < dteN0` et repasse alors
  sur `Exo()`. Ce ne sont pas des handlers (appelés seulement par `Bal_KeyPress`) ; un clic souris
  hors du champ ne déclenche aucun contrôle.
- **`Compdate()` / `compdate2()`** [portée : réductible] [nature : GUI]. Son, `Message.Warning(Txt)`
  (un seul bouton, donc toujours 1), puis `Exo()` et `E0.Value = True`, focus sur `dteN0`/`dteN1`.
  ⚠️ Après une date hors période, la période est remise sur **l'exercice précédent** (`Exo`) alors que
  le bouton coché devient « Exercice en cours » ; `Tab0` n'est pas modifié sauf si l'affectation de
  `E0.Value` lève `E0_Click` (comportement Gambas à confirmer) — anomalie BALANCE-A04.

### Boutons

- **`Btn_Click()`** [portée : nécessaire, handler du groupe `Btn`] [nature : GUI]. Tag 1 →
  `Button2_Click` (export), 2 → `Button1_Click` (impression), 3 → fermeture ; avant de fermer,
  `Try Kill filename` sur une variable **jamais affectée** (code mort).
- **`Bclient_Click` / `Bfournisseur_Click` / `Bgestion_Click`** [portée : nécessaire, handlers]
  [nature : GUI]. Fixent `Cpt` (`41100001`, `40100001`, `10000`), `Type`/`Type2`, `Nom`, et la
  visibilité de `TypeClient1` (clients seulement). `Cpt2` n'est pas modifié.
- **`E0_Click`, `E1_Click`, `N1_Click` … `N5_Click`** [portée : nécessaire, handlers] [nature : mixte].
  `Tab0 = Cbase.Table("TabMvt…")` puis la fonction de bornes correspondante.
- **`Button4_Click` / `Button5_Click`** [portée : nécessaire, handlers] [nature : GUI]. Ouvrent
  `New TriCpt(TriCpt.General | Type, TriCpt.Avec_Solde, Me)` (général si `Type <> Type2`) ; `TriCpt`
  renvoie la sélection par `Object.SetProperty(Me, "Bsel"/"Bval")`, recopiée dans `Cpt`/`Cpt2`.
  Corps identiques à la cible près.
- **`Button1_Click()`** [portée : nécessaire, handler] [nature : GUI]. Délègue à
  `BalanceM.Imprime(cpt, cpt2, Type, Type2, dteN0, dteN1, Impcumul.Value, Impc.Value, Tab0, nom,
  TypeClient1)` ; le **contrôle** `TypeClient1` est passé au module.
- **`Button3_Click()`** [portée : nécessaire, handler] [nature : GUI]. `Doc.Open("Balances")`.

### Export texte

- **`Button2_Click()`** (CC 20, max du fichier) [portée : nécessaire, handler] [nature : mixte].
  1. Réécrit `~/balances.txt` (`Open … For Write Create`).
  2. `SELECT * FROM Fiches_Societes WHERE cd_sc = Start.Societe` : `Ste` est calculé mais **jamais
     écrit** dans le fichier.
  3. Liste des comptes (`Fiches_Comptes`, `Cbase.Table("TabComptes")`) :
     - balance générale : `… compte_cc >= &1 and … <= &2 and coll <> 1 and type_cc = 'G' or type_cc =
       'B'` : **sans parenthèses**, tous les comptes de bilan sont exportés quels que soient la plage
       et le drapeau collectif (anomalie BALANCE-A02) ;
     - client/fournisseur : `FROM Fiches_Comptes Fiches_Cli WHERE cli_code = compte_cc …` : la virgule
       manque, `Fiches_Cli` devient un **alias** de `Fiches_Comptes` qui n'a pas de colonne
       `cli_code` → erreur SQL systématique (anomalie BALANCE-A01). La correction équivalente a été
       faite dans `BalanceM` (commit `729b22cf`, 2019) mais pas ici.
  4. Pour chaque compte : `SELECT * FROM <Tab0> WHERE compte = &1 and validee = 1 and dte >= &3 and
     dte <= &4 order by dte`, puis re-filtrage des dates en Gambas (`Cdate_Comp`, redondant). Cumule
     débit/crédit/solde de la période et écrit `compte;intitulé;débit;crédit;solde`
     (`donnees1`, montants `Format$(CStr(x), "0.00")`). Les cumuls « hors période » (`DebHP`…) ne
     retiennent que les écritures **du jour `dteN0`** et ne sont jamais écrits ; `totdeb2`…,
     `posy`, la branche `Impcumul` (deux branches identiques) sont du code mort.
  5. Comptes sans écriture : ligne vide (`compte;intitulé;;;`) si `Impc`.
  6. Fin : son, proposition d'ouvrir le fichier (`Editeur.Prog_Editeur`) ou « Aucune ecriture ».
  `Catch` : son + `Message.Error` (le fichier reste ouvert).
- **`donnees1(p1…p5)`** [portée : réductible] [nature : calcul]. Écrit une ligne `;` dans `hFile`.
- **`donnees2(p1…p11)`** [portée : réductible] — **code mort** (aucun appel).
- **`Raz()`** [portée : réductible, aucun appel externe ; `Raz` est aussi le nom d'une classe] [nature :
  calcul]. Remet les cumuls à zéro (`debhp`/`credhp` deux fois).

## État global utilisé

- `Utils.db` ; `Cbase.Table("TabParam" | "TabSoc" | "TabComptes" | "TabMvt" … "TabMvt5")` ; table
  `Fiches_Cli` en dur (export client, de toute façon cassé).
- `Utils.Calc_mois`, `Cdate_aff`, `Cdate_calc`, `Cdate_Dbase`, `Cdate_Comp`, `SetEditColor`,
  `Observers`.
- `Start.Musique`, `Start.son`, `Start.Societe`.
- `Bsel`/`Bval` (`Public`) : écrits par `TriCpt` via `Object.SetProperty` — **à garder `Public`**.
- Auto-instance du formulaire : `BalanceM` modifie `Balance.Mouse`.
- Fichier `~/balances.txt` (le message parle de « Balances.txt »).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer `Exo`, `Exo1` … `Exo4` par une fonction privée `Periode(debut As String, fin As String)`
  ou `ChargePeriode(i As Integer)` qui lit **une** fois `Fiches_Parametres` ; `Exo5` et `Ex1` gardent
  leur calcul spécifique. Le `Catch` commun est conservé.
- `dteN0_LF`/`dteN1_LF` : helper privé `CleDate(s As String) As Integer` (= `Val(aaaammjj)`) pour
  les six comparaisons, et un helper `HorsPeriode(s) As String` qui renvoie le message ou `""`.
- `Button2_Click` : retirer les calculs jamais écrits (hors période, `totdeb2`…, `posy`, branche
  `Impcumul` dupliquée) et le re-filtrage Gambas des dates (déjà fait en SQL).

### Commonalisation avec d'autres fichiers

- **Bornes d'exercice** : `Ex1`/`Exo`…`Exo5` sont présents dans 9 fichiers de
  `Compta/Impressions` ([Editcompte](../Editcompte.class/architecture.md),
  [EditcompteA](../EditcompteA.class/architecture.md), [Journaux](../Journaux.class/architecture.md),
  [JournauxA](../JournauxA.class/architecture.md), [Jourcent](../Jourcent.class/architecture.md),
  [EcrM](../EcrM.class/architecture.md), [ExportA47](../ExportA47.class/architecture.md),
  [RubImp](../RubImp.class/architecture.md)). Socle proposé (phase 3) : une fonction commune
  `Bornes(index As Integer) As String[]` (début, fin au format `jj.mm.aaaa`) qui reproduit **à
  l'identique** `Calc_mois(dteclec(n+1))`/`Cdate_aff(dteclec(n))` et le cas N-5, placée dans
  [`LDate`](../../../Utils/LDate.class/architecture.md) (à côté de `Exercice_Cloture`) ou dans un
  module `Compta/Utils`.
- **Écran de sélection compte/période** : `Btn_Click`, `Bal_KeyPress`/`Cmpt_KeyPress`,
  `Bal_GotFocus`/`Cmpt_GotFocus`, `Compdate`/`compdate2`, `dteN0_LF`/`dteN0_LostFocus`,
  `Button4_Click`/`Button5_Click` sont identiques ou presque (ratio 0,82 à 1,0) entre `Balance`,
  `Editcompte` et `EditcompteA` (310 lignes en commun en séquence entre `Balance` et `Editcompte`).
  Un helper `ControleDate(texte, debut, fin) As Integer` (−1, 0, +1) partagé, sans GUI, garderait
  les `Message.Warning` dans chaque écran.
- **Ligne CSV** : `donnees1`/`donnees2` ≈ `Editcompte.donnees`/`content1`/`donnees2` : helper commun
  `LigneCsv(hFile, champs As String[])`.
- **Nom de société** : la séquence `SELECT * FROM TabSoc WHERE cd_sc = Start.Societe` + `int_sc`
  est répétée dans 12 fichiers (ici, `BalanceM`, `EditcompteA`…), cible d'un `Utils.NomSociete()`.

### Réduction de portée

- `Ex1`, `Exo` … `Exo5`, `dteN0_LF`, `dteN1_LF`, `Compdate`, `compdate2`, `donnees1`, `Raz` : aucun
  appelant externe (vérifié par `grep -rn`), passage en `Private` couvert par les replays.
- `Bsel`, `Bval` : **faux positif** de `deps.py`, écrits par `TriCpt` (`Object.SetProperty`).
- Handlers `Objet_Evenement` (`Bal_*`, `Btn_Click`, `B*_Click`, `E0_Click`…) : intouchables.

### Séparation traitement / GUI

- `Button2_Click` : extraire `ExporteBalance(fichier, cpt1, cpt2, type, type2, filtre, tab0, d0, d1,
  impc) As Boolean` (SQL + écriture du fichier, sans contrôle) ; le handler garde la souris, le son
  et les messages.
- Bornes d'exercice : la lecture de `Fiches_Parametres` peut renvoyer les deux dates ; l'affectation
  des `TextBox` reste dans le handler.
- `Button1_Click` : passer `TypeClient1.where` (chaîne) plutôt que le contrôle à `BalanceM.Imprime`
  (voir BALANCEM-007).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Comptes stockés en `int` mais comparés via `cast(compte_cc as char)` : un `compte_cc` en
  `varchar(8)` indexé éviterait le cast et permettrait l'usage de l'index sur la plage.
- Bornes d'exercice en 6 colonnes `dteclec`…`dteclec5` et écritures en 6 tables `Fiches_Mvt`…`Mvt5` :
  une table `Fiches_Exercices(index, debut, fin)` et une table d'écritures unique avec un index
  d'exercice supprimeraient `Tab0` et les sept fonctions de bornes (voir LDate).
