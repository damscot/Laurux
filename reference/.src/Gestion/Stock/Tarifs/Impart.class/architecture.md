# Impart — Architecture

> Source : `.src/Gestion/Stock/Tarifs/Impart.class`

## Vue d'ensemble

Écran **« Import et Maj articles »** (`Fmenu.Menu186_Click`, `ShowModal`) : importe un fichier
de tarif fournisseur (texte séparé ou à largeur fixe) selon une **définition d'import** éditée par
[`ImpartParam`](../ImpartParam.class/architecture.md) (`Fiches_ImpArtDef`, `Fiches_ImpArtDef2`),
et selon les options cochées :

| Option (contrôle) | Traitement | Fonction |
|---|---|---|
| `MajPrix` | mise à jour des prix des articles existants (et création si `Creation`) | `Import` |
| `MajFtbt` (+ date) | écriture de la **future base tarif** (`art_pbfbt`, `art_datefbt`) appliquée ensuite par [`MajFbtarif2`](../MajFbtarif2.class/architecture.md) | `Import` |
| `MajZones` | codes équivalents (`Fiches_Cequ` via [`MajEqu`](../MajEqu.module/architecture.md)) ou codes-barres (`Fiches_CdBarre`) | `Maj_Equ` |
| `MajZones2` | réf. liée, stock mini/maxi, casier, poids, article stocké | `Maj_Divers` |
| `centrale` (+ code centrale) | rattachement des articles à une centrale d'achat | `Maj_Centrale` |
| `MajRefour` | référence fournisseur `art_cfour` | `Maj_Ref_fournisseur` |
| `Majdesg`, `MajCbarre`, `MajCequ`, `Majpvcons`, `MajCoeff`, `Tbrut`/`Tnet`, `Stockes` | options de `Import` | `Import` |

`Import` (lignes 889-1327, **CC 186**) lit le fichier ligne par ligne, découpe les champs
(`rechercheKey` en mode séparé, `Mid$` en largeur fixe) dans **~45 variables de module `String`**,
cherche l'article (code, centrale, code-barre, référence fournisseur), calcule la chaîne de prix
(`prix_base` ou `Prix_achat`), puis crée l'article (`INSERT` de 58 colonnes) ou le met à jour, et
écrit deux comptes rendus `~/tmp/Artnew.txt` et `~/tmp/Artmaj.txt` ouverts ensuite dans
`Editeur`. Ajouts du 06/2011 (F. Lalande) : choix de la définition d'import.

Nature globale : **mixte** ; aucune transaction, aucun verrou : chaque ligne du fichier est
écrite indépendamment.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Ecotaxe` | var | Private |  | String | 9 |
| `B` | var | Private |  | Integer | 10 |
| `Tvavente` | var | Private |  | Integer | 11 |
| `son` | var | Private |  | Integer | 12 |
| `Dne` | var | Private |  | String | 13 |
| `CoulZns` | var | Private |  | Integer | 14 |
| `CoulZnaf` | var | Private |  | Integer | 15 |
| `CoulFc` | var | Private |  | Integer | 16 |
| `Derart` | var | Private |  | String | 17 |
| `Nbdec` | var | Private |  | String | 18 |
| `Ref` | var | Private |  | String | 19 |
| `CodeA` | var | Private |  | String | 20 |
| `Intitule` | var | Private |  | String | 21 |
| `Intitule2` | var | Private |  | String | 22 |
| `FamImport` | var | Private |  | String | 23 |
| `FourImport` | var | Private |  | String | 24 |
| `PbHT` | var | Private |  | String | 25 |
| `PaHT` | var | Private |  | String | 26 |
| `Txconv` | var | Private |  | String | 27 |
| `Paua` | var | Private |  | String | 28 |
| `Prvt` | var | Private |  | String | 29 |
| `PHTn` | var | Private |  | String | 30 |
| `Pvht` | var | Private |  | String | 31 |
| `Pvttc` | var | Private |  | String | 32 |
| `Pvcons` | var | Private |  | String | 33 |
| `Pmp` | var | Private |  | String | 34 |
| `Stocke` | var | Private |  | String | 35 |
| `Margem` | var | Private |  | String | 36 |
| `Margep` | var | Private |  | String | 37 |
| `arr` | var | Private |  | String | 38 |
| `Remise` | var | Private |  | String | 39 |
| `Remise2` | var | Private |  | String | 40 |
| `Remise3` | var | Private |  | String | 41 |
| `Remise4` | var | Private |  | String | 42 |
| `Coeff` | var | Private |  | String | 43 |
| `Mtva` | var | Private |  | String | 44 |
| `Cbarre` | var | Private |  | String | 45 |
| `Cequ` | var | Private |  | String | 46 |
| `Volumes` | var | Private |  | String | 47 |
| `Copie` | var | Private |  | String | 48 |
| `Ecot` | var | Private |  | String | 49 |
| `Code` | var | Private |  | String | 50 |
| `Frais` | var | Private |  | String | 51 |
| `Divers` | var | Private |  | String | 52 |
| `Marque` | var | Private |  | String | 53 |
| `minCom` | var | Private |  | String | 54 |
| `Refliee` | var | Private |  | String | 55 |
| `$casier` | var | Private |  | String | 56 |
| `$mini` | var | Private |  | String | 57 |
| `$maxi` | var | Private |  | String | 58 |
| `$cond` | var | Private |  | String | 59 |
| `$unite` | var | Private |  | String | 60 |
| `Codecentrale` | var | Private |  | String | 61 |
| `Gpvcons` | var | Private |  | Boolean | 62 |
| `col_` | var | Private |  | New String[35] | 63 |
| `db_` | var | Private |  | New String[35] | 64 |
| `lg_` | var | Private |  | New String[35] | 65 |
| `pos_` | var | Private |  | New String[35] | 66 |
| `porg_` | var | Private |  | New String[35] | 67 |
| `Type_Champs` | var | Private |  | String | 68 |
| `filename` | var | Private |  | String | 69 |
| `filename2` | var | Private |  | String | 70 |
| `Lig` | var | Private |  | String | 71 |
| `Lig2` | var | Private |  | New String[] | 72 |
| `KeyLaurux` | var | Private |  | String | 73 |
| `Org` | var | Private |  | String | 74 |
| `Maj` | var | Private |  | Boolean | 75 |
| `cda` | var | Private |  | Boolean | 76 |
| `Etiqb` | var | Private |  | Boolean | 77 |
| `$ua` | var | Private |  | String | 78 |
| `$Poids` | var | Private |  | String | 79 |
| `bPoids` | var | Private |  | Float | 80 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 82-102 | Public | 4 | 18 | 0 | handler GUI |
| `Button3_Click` | 104-110 | Public | 5 | 5 | 0 | handler GUI |
| `Cmpt_KeyPress` | 112-188 | Public | 16 | 70 | 0 | handler GUI |
| `Fam_LostFocus` | 190-204 | Public | 3 | 13 | 0 | portée réductible ? |
| `Txchg_LostFocus` | 206-222 | Public | 4 | 15 | 0 | portée réductible ? |
| `Four_LostFocus` | 224-238 | Public | 3 | 13 | 0 | portée réductible ? |
| `FamMan` | 243-278 | Public | 6 | 33 | 0 | portée réductible ? |
| `fourMan` | 283-297 | Public | 3 | 12 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 302-337 | Public | 5 | 33 | 0 | handler GUI |
| `FamList_Click` | 342-355 | Public | 1 | 12 | 0 | handler GUI |
| `FamList_KeyPress` | 360-374 | Public | 5 | 11 | 0 | handler GUI |
| `Fam2` | 379-414 | Public | 6 | 33 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 419-451 | Public | 5 | 30 | 0 | handler GUI |
| `fourList_Click` | 456-468 | Public | 2 | 11 | 0 | handler GUI |
| `fourList_KeyPress` | 473-485 | Public | 5 | 11 | 0 | handler GUI |
| `ToggleButton2_Click` | 490-518 | Public | 4 | 26 | 0 | handler GUI |
| `Button2_Click` | 523-602 | Public | 30 | 77 | 0 | handler GUI |
| `Controle` | 604-606 | Public | 1 | 2 | 0 | portée réductible ? |
| `Maj_Equ` | 608-703 | Public | 47 | 92 | 0 | portée réductible ? |
| `Maj_Divers` | 705-765 | Public | 24 | 58 | 0 | portée réductible ? |
| `Maj_Centrale` | 767-829 | Public | 15 | 55 | 0 | portée réductible ? |
| `Maj_Ref_fournisseur` | 831-887 | Public | 13 | 52 | 0 | portée réductible ? |
| `Import` | 889-1327 | Public | 186 | 424 | 0 | portée réductible ? |
| `Maj_Etiqp` | 1330-1346 | Public | 2 | 12 | 0 | portée réductible ? |
| `Maj_Etiqg` | 1349-1363 | Public | 2 | 12 | 0 | portée réductible ? |
| `InitCode` | 1365-1371 | Public | 1 | 5 | 0 | portée réductible ? |
| `Button4_MouseDown` | 1373-1385 | Public | 2 | 11 | 0 | handler GUI |
| `Initialisation` | 1388-1425 | Public | 1 | 35 | 0 | portée réductible ? |
| `prix_base` | 1430-1468 | Public | 26 | 37 | 0 | portée réductible ? |
| `TrC` | 1473-1491 | Public | 5 | 17 | 0 | portée réductible ? |
| `Prix_achat` | 1493-1527 | Public | 18 | 32 | 0 | portée réductible ? |
| `Tva_Calcul` | 1532-1541 | Public | 4 | 8 | 0 | portée réductible ? |
| `Calc_Marge` | 1546-1559 | Public | 6 | 12 | 0 | portée réductible ? |
| `Svs_Click` | 1561-1569 | Public | 2 | 7 | 0 | handler GUI |
| `PvTTC_arrondi` | 1574-1611 | Public | 10 | 33 | 0 | portée réductible ? |
| `Cmpt_GotFocus` | 1616-1622 | Public | 1 | 5 | 0 | handler GUI |
| `Button1_Click` | 1627-1631 | Public | 1 | 3 | 0 | handler GUI |
| `TgleBtnFDef_Click` | 1633-1668 | Public | 4 | 32 | 0 | handler GUI |
| `DefList_Click` | 1670-1706 | Public | 3 | 30 | 0 | handler GUI |
| `ChargementFichierDef` | 1708-1740 | Public | 5 | 29 | 0 | portée réductible ? |
| `rechercheKey` | 1742-1847 | Public | 49 | 103 | 0 | portée réductible ? |
| `MajFtbt_Click` | 1849-1857 | Public | 2 | 7 | 0 | handler GUI |
| `MajPrix_Click` | 1859-1867 | Public | 2 | 7 | 0 | handler GUI |
| `MajZones_Click` | 1869-1877 | Public | 2 | 7 | 0 | handler GUI |
| `MajZones2_Click` | 1879-1887 | Public | 2 | 7 | 0 | handler GUI |
| `ToggleBtnDate_Click` | 1889-1897 | Public | 2 | 7 | 0 | handler GUI |
| `DateChooser1_Activate` | 1899-1904 | Public | 1 | 4 | 0 | handler GUI |
| `centrale_Click` | 1906-1914 | Public | 2 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et saisie

- **`Form_Open()`** [GUI] : son (`/son`), couleurs `/Coul/*`, `Gpvcons =
  /Soc<XX>/Pvcons` (masque `Majpvcons`), date du jour. ⚠️ `Utils.Observers(Me)` est appelé
  **deux fois** (lignes 93 et 97) : observateurs cumulés (IMPART-A12).
- **`Button3_Click()`** [GUI] : supprime les fichiers de compte rendu, ferme.
- **`Cmpt_KeyPress()`** [GUI] : groupe `Cmpt` ; tags 4 (`Fam`), 5 (`Txchg`), 6 (`Four`) sur
  Entrée/Tab ; F1 → aide ; F2 → listes famille/fournisseur. ⚠️ Pas de cas pour `Cdef` (tag 1) :
  un numéro de définition saisi au clavier ne charge rien (ni `Type_Champs`, ni séparateur).
- **`Cmpt_GotFocus()`** [GUI] : `Utils.SetEditColor`.
- **`Fam_LostFocus()`, `Four_LostFocus()`, `Txchg_LostFocus()`** [nature : mixte] : appelées
  explicitement (les contrôles sont dans le groupe `Cmpt`, Gambas ne lève donc pas
  `Fam_LostFocus`…) : pseudo-handlers, gardés `Public` par prudence. Contrôle de la famille, du
  fournisseur, normalisation du taux de change.
- **`FamMan()` / `Fam2()`** [portée : réductible] [mixte] : `SELECT` famille (`Cbase.Table("TabFam")`)
  sans test `Available` (erreur → `Catch` « Cette famille n'existe pas »), libellé, code et taux
  TVA (`Mtva`), écotaxe (`Ecotaxe`, jamais relue), contrôle du compte de TVA (`Fiches_Tvaav`,
  `Fiches_Comptes` en dur) ; `Tvavente = 1` jamais relu. Les deux fonctions ne diffèrent que par
  un `message.Error` et `b = 1`.
- **`fourMan()`** [portée : réductible] : `SELECT` fournisseur, erreur → `b = 1`.
- **`ToggleButton3_Click()`** (familles), **`ToggleButton1_Click()`** (fournisseurs),
  **`ToggleButton2_Click()`** (centrales) [mixte] : listes ; filtre par début de code
  `left(code_fam,'n') = '<texte>'` **concaténé** (IMPART-A13). **`FamList_Click()`**
  (`replay_dynamic`) recopie coefficient, TVA, remise de la famille puis `Fam2` ;
  **`fourList_Click()`** (`replay_dynamic`) remplit `Four` ou `Four2` selon `Org` ;
  **`FamList_KeyPress()`, `fourList_KeyPress()`** [GUI].
- **`TgleBtnFDef_Click()`**, **`DefList_Click()`** (`replay_dynamic`) [mixte] : liste et choix d'une
  définition : famille, fournisseur, fichier, séparateur (`Sep`, TextLabel), **`Type_Champs`**,
  coefficient/TVA/remise de la famille. C'est le **seul** endroit où `Type_Champs` est affecté.
- **`Svs_Click()`, `Button1_Click()`, `ToggleBtnDate_Click()`, `DateChooser1_Activate()`,
  `MajFtbt_Click()`, `MajPrix_Click()`, `MajZones_Click()`, `MajZones2_Click()`,
  `centrale_Click()`** [GUI] : fichier, aide, date, visibilité des panneaux (`MajZones_Click` et
  `MajZones2_Click` masquent `Panel2` dans les deux branches).
- **`InitCode()`** et **`Controle()`** (vide) : **code mort** (`unused`). `InitCode` est le seul
  moyen d'afficher `Panel3` : son handler **`Button4_MouseDown()`** (saisie d'un code de départ) est
  donc inatteignable.

### Lancement

- **`Button2_Click()`** [mixte] : selon les options, `Maj_Centrale`, `Maj_Ref_fournisseur`,
  `Maj_Equ`, `Maj_Divers` ou l'import. Pour l'import : contrôle famille et fournisseur,
  ⚠️ si le fichier est vide un avertissement est affiché **mais le traitement continue**
  (IMPART-A03) ; `ChargementFichierDef` ; si aucune colonne « code article » n'est définie,
  le code de départ est `Fiches_Parametres.dnart` (lu en dur, `Fiches_Parametres`) ; confirmation
  puis `Import`.
- **`ChargementFichierDef()`** [portée : réductible] : lit `Fiches_ImpArtDef2` (rangs 1 à 25) dans
  `col_`, `pos_`, `db_`, `lg_`, `porg_` ; seul `col_` est utilisé (drapeau `cda` = présence de
  « 2 - Code article ») : les quatre autres tableaux sont du code mort.

### Import (`Import`, CC 186)

1. Séparateur `Sep.Text` ou `;` ; comptes rendus `~/tmp/Artnew.txt` et `~/tmp/Artmaj.txt`
   (⚠️ `Open … For Write Create` hors `Try` : erreur si `~/tmp` n'existe pas, IMPART-A10) ;
   `Coeff = Coef.Text`.
2. Pour chaque ligne (`Line Input`, sans conversion d'encodage) :
   - **mode `S`** : `Initialisation`, découpage `Split`, `SELECT` de la définition **à chaque ligne**,
     pour les rangs 1 à 25 : `rechercheKey(pos_x, posorg_x)` ;
   - **mode `F`** : `Initialisation`, `SELECT` de la définition, rangs 1 à 25 : `Mid$(ligne, db_x,
     lg_x)` selon le n° de champ en tête de `col_x` (même `Select Case` 1-31 que `rechercheKey`,
     avec deux différences : code-barre de moins de 8 chiffres rejeté, `Break` à la première
     lettre) ;
   - ⚠️ **si `Type_Champs` n'est ni `S` ni `F`** (définition saisie au clavier, sans passer par la
     liste), aucune `Line Input` n'est exécutée : **boucle infinie**, l'application se fige
     (IMPART-A01, à confirmer par T09).
3. Valeurs par défaut : remise (`Tr`), coefficient (`Coef`), famille et fournisseur de l'écran si
   ceux du fichier sont absents ou inconnus ; fournisseur de centrale (`fo_centrale`,
   `fo_ccentrale`).
4. Recherche de l'article : par code + fournisseur, puis code + centrale, puis réf. centrale ; sans
   code : par code-barre (`Fiches_CdBarre`) puis réf. fournisseur, ou réf. fournisseur seule ;
   nouveau code par `Utils.Next_Code(code)` (incrément pur, **sans contrôle d'existence**).
5. ⚠️ « Vérification que la référence fournisseur n'est pas utilisée » : la requête teste
   `art_code = FourImport` (le **code fournisseur**) ; si un article porte le code du fournisseur,
   aucune ligne n'est importée (IMPART-A02).
6. **Création** (article absent, `Creation` coché) : `Prix_base`/`Prix_achat`, remise recalculée,
   valeurs par défaut casier/mini/maxi, `INSERT` de 58 colonnes sous `Try` (⚠️ coefficient
   `Coef.Text` de l'écran et non `Coeff` calculé ; arrondi `"0,01"` ; `art_tva` = code TVA de la
   famille de l'écran) ; si succès : `UPDATE` des colonnes complémentaires, `INSERT` code-barre,
   exports, ligne de compte rendu. Échec de l'`INSERT` (code existant) : **silencieux**, aucune
   trace (IMPART-A08).
7. **Mise à jour** (article trouvé) : chaîne de prix ; `MajPrix` : `UPDATE` des prix si le prix de
   base, la remise ou le coefficient change (et ⚠️ `art_pbfbt = ''`, `art_datefbt = ''`, voir
   MAJFBTARIF2-A01), étiquettes ; sinon (`MajFtbt`) : `UPDATE art_pbfbt, art_datefbt` ; puis options
   `Majdesg`, `MajCbarre`, `MajCequ` (⚠️ `MajEqu.Maj(Cequ, art_code)` : **arguments inversés**,
   IMPART-A04), `Majpvcons`, export.
8. Fin : fermeture des fichiers, ouverture des comptes rendus, impression des étiquettes.
   Le message « Traitement terminé » n'apparaît que si la **dernière** ligne a laissé `Maj = True`.
   ⚠️ `Initialisation` ne remet pas à zéro `remise2-4`, `Intitule2`, `CodeA`, `Codecentrale`,
   `FamImport`, `FourImport`, `$cond`, `$unite`, `$ua`, ni `Maj` : une valeur de la ligne
   précédente est reprise si le champ manque (IMPART-A06). Les champs 17 (copie privée) et
   18 (écotaxe) sont lus mais **jamais enregistrés** ; l'option `Remfam` n'a aucun effet (IMPART-A09).
   Un code de départ issu de `dnart` n'est pas réécrit en fin d'import : un second import repart du
   même code (A08).

### Autres traitements de fichier

- **`Maj_Equ()`** [portée : réductible] : selon le champ du rang 2 de la définition (code article,
  code équivalent, code-barre, réf. liée, mini, maxi, casier), met à jour `art_cequ` +
  `MajEqu.Maj(codep, codequ)`, ou `art_cbarre` + `Fiches_CdBarre`, ou une colonne de `Fiches_Art`
  (nom en dur). Définition relue à chaque ligne.
- **`Maj_Divers()`** [portée : réductible] : rangs 1 à 31 via `rechercheKey`, puis `UPDATE` de
  `art_refliee`, `art_stkmin`, `art_stkmax`, `art_casier`, `art_poids` (⚠️ condition sur `$poids`,
  valeur `bpoids`), `art_stocke` ; export `("CB", …)`.
- **`Maj_Centrale()`** [portée : réductible] : rangs 1 à 24 (« 2 » = code article, « 24 » =
  réf. centrale) ; rattache l'article si la réf. n'est pas déjà utilisée dans une autre centrale.
- **`Maj_Ref_fournisseur()`** [portée : réductible] : « 2 » = code article, « 1 » = réf.
  fournisseur ; `UPDATE art_cfour` (même si l'article n'existe pas).
  Ces quatre fonctions ne ferment jamais le fichier lu et indexent `Lig2[n - 1]` sans contrôle
  (ligne courte → erreur non interceptée, IMPART-A07) ; `Codep`/`Codec` gardent la valeur de la
  ligne précédente.

### Calcul et utilitaires

- **`rechercheKey(cle, KeyL)`** [portée : réductible] : affecte la variable de module du champ n°
  `KeyL` (1 à 31) à partir de `Lig2[cle - 1]` ; renvoie `"OK"` (jamais utilisé).
- **`Initialisation()`** [portée : réductible] : remise à blanc partielle (voir A06).
- **`prix_base()`** [portée : réductible] [calcul] : taux de change, prix d'achat après remise
  et remises 2-4 en cascade (`CPrix.Cascade`, ⚠️ garde `IsNull(remise2)` répétée pour `remise3` et
  `remise4`, IMPART-A06), prix de revient (calculé deux fois), PV HT = prix de revient × coefficient
  ou coefficient = PV HT / prix d'achat si le PV est fourni, `Tva_Calcul`, `PvTTC_arrondi`,
  `Calc_Marge`.
- **`Prix_achat()`** [calcul] : variante à partir du prix net.
- **`TrC()`** : **code mort** (`unused`).
- **`Tva_Calcul()`**, **`PvTTC_arrondi()`** (⚠️ `arr` remis à `""` par `Initialisation` et jamais
  affecté : aucun arrondi, IMPART-A05), **`Calc_Marge()`** (résultats jamais lus : sans effet).
- **`Maj_Etiqp(Cart, Stk)`**, **`Maj_Etiqg(Cart)`** : identiques à `MajFbtarif2` (+ `Etiqb`).

## État global utilisé

- `Start.LocalSettings` (`/son`, `/Coul/*`, `/Soc<XX>/Pvcons`), `Start.Societe`, `Utils.db`,
  `Utils.Observers`, `Utils.FColr`, `Utils.SetEditColor`, `Utils.cpoint`, `Utils.Next_Code`,
  `Utils.convBool`, `Utils.Cdate_Dbase`, `Cbase.Table`, `CPrix.Cascade`, `MajEqu`, `Editeur`,
  `EtiqRecpt`, `Doc`, `Variables.Sprix/Sexport/SMajArt`, `Serveur.Pass`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Import` : `LitLigne` (découpage), `ChercheArticle`, `CreeArticle`, `MajArticle`,
  `EcritCompteRendu` (CC 186 → aucune fonction > 30 visé), sans changer l'ordre des requêtes.
- Une seule fonction `AffecteChamp(iChamp, sValeur, bFixe)` pour le `Select Case` 1-31 de
  `rechercheKey` et du mode largeur fixe (les deux différences passées en paramètre).
- Sortir des boucles le `SELECT` de la définition (relu à chaque ligne dans `Import`, `Maj_Equ`,
  `Maj_Divers`, `Maj_Centrale`, `Maj_Ref_fournisseur`) : SQL modifié, dump identique.
- Fusionner `FamMan` et `Fam2` (paramètre pour le `Message.Error` supplémentaire).
- Supprimer le code mort : `Controle`, `InitCode`, `TrC`, `Calc_Marge`, variables `Ecotaxe`,
  `Tvavente`, `Derart`, `PHTn`, `Divers`, `Margem`, `Margep`, `Pmp`, `Stocke`, `stck`, tableaux
  `db_`, `lg_`, `pos_`, `porg_`, double calcul de `Prvt`.

### Commonalisation avec d'autres fichiers

- Définition d'import : classe `LImpDef` partagée avec [`ImpartParam`](../ImpartParam.class/architecture.md)
  (listes, chargement, IMPARTPARAM-005).
- `PvTTC_arrondi` → `ArrondiPvTTC` (ARTICLES-012, [`Articles`](../../../Tables/Articles.class/architecture.md)) ;
  `Maj_Etiqp`/`Maj_Etiqg` → module `EtiqMaj` (MAJFBTARIF2-005) ; `Calc_Marge` identique à
  [`MajFbtarif2`](../MajFbtarif2.class/architecture.md).
- Socle d'import de fichier texte (sélection, lecture, découpage) : `CompArt`, `ImportStk`,
  `Impclient`, `ImpExp` (notes transverses, phase 3).
- Numérotation automatique (`Fiches_Parametres.dnart` + `Utils.Next_Code`) partagée avec
  [`Articles`](../../../Tables/Articles.class/architecture.md).
- Garde d'export → `Serveur.Actif` (SERVEUR-008).

### Réduction de portée

- `FamMan`, `fourMan`, `Fam2`, `Maj_Equ`, `Maj_Divers`, `Maj_Centrale`, `Maj_Ref_fournisseur`,
  `Import`, `Maj_Etiqp`, `Maj_Etiqg`, `Initialisation`, `prix_base`, `Prix_achat`, `Tva_Calcul`,
  `Calc_Marge`, `PvTTC_arrondi`, `ChargementFichierDef`, `rechercheKey` → `Private` (aucun appelant
  externe ; les `.Import` de `Etigond`, `Majcasier`, `commande1` visent d'autres classes).
  `Controle`, `InitCode`, `TrC` sont supprimées. `Fam_LostFocus`, `Txchg_LostFocus`,
  `Four_LostFocus` (pseudo-handlers) restent `Public` par prudence.

### Séparation traitement / GUI

- `Import` lit une vingtaine de contrôles (`Coef`, `Tr`, `Tva`, `Txchg`, `Fam`, `Four`, `Casier`,
  `mini`, `maxi`, cases à cocher, `Date`, `Sep`, `Sauves`, `Cdef`) : les lire une fois dans une
  structure d'options passée aux fonctions de traitement.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Normaliser `Fiches_ImpArtDef2` (une ligne par zone) : voir [`ImpartParam`](../ImpartParam.class/architecture.md).
- Journal d'import en base (`Fiches_ImportLog`) au lieu de fichiers dans `~/tmp`.
- Compteur d'articles transactionnel (séquence) à la place de `dnart` + `Next_Code`.
