# TresorFac — Architecture

> Source : `.src/Gestion/Reglements/TresorFac.class` · Formulaire : `.src/Gestion/Reglements/TresorFac.form`

## Vue d'ensemble

`TresorFac` est une ancienne variante de l'écran de trésorerie
[`Tresor`](../../../Compta/Tresor.class/architecture.md) dédiée à la **saisie des règlements
clients** : choix du mode de règlement (`CV` : « Especes » → journal `jrnal2`, sinon `jrnal3`),
date, compte client, montant et n° de document ; chaque ligne génère dans `Fiches_Mvt` une écriture
provisoire au crédit du client, sa contrepartie au débit du compte de trésorerie du journal
(`Fiches_Journaux.cde_banque`) et, le cas échéant, une ligne de collectif. La validation
(`Button2_Click`) passe les lignes en `validee = 1`, met à jour les soldes et lettre le lot si les
débits et crédits s'équilibrent. Un panneau de lettrage (`EcritL`) permet de choisir les factures
non lettrées du client.

**Le fichier est mort** :
- aucun appelant (`grep -rn TresorFac .src` ne renvoie que ce fichier et son `.form`) ; absent de
  `Fmenu`, du dispatcher `Prgm` et de tout `Object.New`/`Class.Load` ; l'en-tête le nomme encore
  « Tresor.class » ; dernière modification fonctionnelle en 2017-2020 (nettoyages globaux) ;
- s'il était ouvert, la recherche de compte (`compte`, F2) échouerait : `TriCpt` appelle
  `Object.SetProperty(Me, "Bsel"/"Bval")` sur la fenêtre appelante, or `TresorFac` n'a ni `Bsel` ni
  `Bval` (erreur à la sélection, à confirmer) ; le code lit ensuite `Comptabilite.Bsel`/`sCmpt`,
  que `TriCpt` n'alimente pas (seuls `TriEcritures`/`TriEcritures2` les écrivent) ;
- la liste des écritures validées `Ecrit3` n'est remplie que par `ecritv`, jamais appelée :
  `Ecrit3_Click` (rappel d'une écriture) est donc inatteignable.

37 fonctions portent le même nom que dans `Tresor` (`Movt`, `QuitteDate`, `Lettrage`,
`Ecrit3_Click`…), avec des corps divergents : `Tresor` en est l'évolution maintenue.

Nature globale : **mixte** ; les règles comptables (numérotation, contrepartie, collectif, lettrage,
soldes) sont dispersées dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | FCalc | 27 |
| `Tab` | var | Private |  | String | 28 |
| `n` | var | Private |  | Integer | 29 |
| `Cnt` | var | Private |  | String | 30 |
| `soldec` | var | Private |  | Float | 31 |
| `montantdb` | var | Private |  | Float | 32 |
| `montantcd` | var | Private |  | Float | 33 |
| `Montantsel` | var | Private |  | Float | 34 |
| `Totalcd` | var | Private |  | Float | 35 |
| `Totaldb` | var | Private |  | Float | 36 |
| `Modif` | var | Private |  | String | 37 |
| `Vld` | var | Private |  | Boolean | 38 |
| `Prov` | var | Private |  | Boolean | 39 |
| `numCpt` | var | Private |  | String | 40 |
| `numlotT` | var | Private |  | String | 41 |
| `Gntva` | var | Private |  | Boolean | 42 |
| `num` | var | Private |  | Integer | 43 |
| `ecriture` | var | Private |  | String | 44 |
| `numecrit` | var | Private |  | String | 45 |
| `numlot` | var | Private |  | String | 46 |
| `TT` | var | Private |  | Float | 47 |
| `TD` | var | Private |  | String | 48 |
| `TC` | var | Private |  | String | 49 |
| `iLet` | var | Private |  | Integer | 50 |
| `ye2` | var | Private |  | Integer | 51 |
| `dte2` | var | Private |  | String | 52 |
| `dte3` | var | Private |  | String | 53 |
| `numlet` | var | Private |  | String | 54 |
| `nvlle` | var | Private |  | Integer | 55 |
| `Lettrable` | var | Private |  | Integer | 56 |
| `b` | var | Private |  | Integer | 57 |
| `son` | var | Private |  | Integer | 58 |
| `Prg` | var | Private |  | String | 59 |
| `Cpt_tr` | var | Private |  | String | 60 |
<!-- /AUTO:declarations -->

Les 33 membres (l. 28-61) sont déclarés sans mot-clé de portée (donc `Private`) et absents du
tableau généré : état de saisie (`numecrit`, `numcpt`, `numlot`, `numlotT`, `num`, `nvlle`, `cnt`,
`Modif`, `b`, `iLet`, `Lettrable`), cumuls (`montantdb`, `montantcd`, `Totaldb`, `Totalcd`,
`soldec`, `TT`, `TD`, `TC`), `ye2`/`dte3` (bornes de `QuitteDate`), `Cpt_tr` (compte de trésorerie), `hForm As FCalc`,
`son = Start.Son`, et des membres inutilisés ou seulement écrits (`Vld`, `Prov`, `Gntva`,
`ecriture`, `dte2` (masqué par une locale de `QuitteDate`), `numlet` (argument SQL inutilisé),
`Prg`, `n`, `Montantsel`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 62-71 | Public | 1 | 8 | 0 | méthode spéciale |
| `form_open` | 73-93 | Public | 1 | 19 | 0 | handler GUI |
| `Cmpt_GotFocus` | 98-112 | Public | 3 | 13 | 0 | handler GUI |
| `Cleanchamps` | 114-124 | Public | 1 | 9 | 0 | portée réductible ? |
| `Movt` | 126-185 | Public | 9 | 57 | 0 | portée réductible ? |
| `compte` | 187-202 | Public | 3 | 13 | 0 | portée réductible ? |
| `compteTiersman` | 204-224 | Public | 4 | 18 | 0 | portée réductible ? |
| `Ecritures` | 226-236 | Public | 2 | 8 | 0 | portée réductible ? |
| `Majnum` | 241-246 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lettrage` | 248-302 | Public | 3 | 51 | 0 | portée réductible ? |
| `EcritL_Click` | 304-322 | Public | 5 | 17 | 0 | handler GUI |
| `ecritv` | 324-367 | Public | 5 | 41 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 369-482 | Public | 44 | 99 | 0 | handler GUI |
| `Btn_KeyPress` | 484-495 | Public | 5 | 9 | 0 | handler GUI |
| `Btn_Click` | 497-530 | Public | 10 | 22 | 0 | handler GUI |
| `CV_keypress` | 532-540 | Public | 3 | 7 | 0 | handler GUI |
| `CV_click` | 542-554 | Public | 3 | 11 | 0 | handler GUI |
| `Journal_GotFocus` | 556-560 | Public | 1 | 3 | 0 | portée réductible ? |
| `Datej_GotFocus` | 562-574 | Public | 4 | 11 | 0 | portée réductible ? |
| `Datej_LF` | 576-586 | Public | 2 | 9 | 0 | portée réductible ? |
| `Numcompte_GotFocus` | 588-592 | Public | 1 | 3 | 0 | portée réductible ? |
| `numcompte_LF` | 594-607 | Public | 3 | 12 | 0 | portée réductible ? |
| `Montant_LF` | 609-627 | Public | 3 | 16 | 0 | portée réductible ? |
| `numdoc_LF` | 629-646 | Public | 5 | 15 | 0 | portée réductible ? |
| `QuitteDate` | 648-706 | Public | 10 | 56 | 0 | portée réductible ? |
| `Button1_Click` | 708-721 | Public | 6 | 12 | 0 | portée réductible ? |
| `ToggleButton4_Click` | 723-789 | Public | 10 | 64 | 0 | portée réductible ? |
| `Button2_Click` | 791-878 | Public | 9 | 85 | 0 | portée réductible ? |
| `Controle` | 880-910 | Public | 4 | 27 | 0 | portée réductible ? |
| `ToggleButton6_Click` | 912-918 | Public | 2 | 5 | 0 | portée réductible ? |
| `ToggleButton8_Click` | 920-931 | Public | 2 | 10 | 0 | handler GUI |
| `Ecrit1_Activate` | 933-962 | Public | 4 | 28 | 0 | handler GUI |
| `Ecrit1_Keypress` | 964-993 | Public | 7 | 26 | 0 | handler GUI |
| `DelEcr` | 995-1020 | Public | 5 | 23 | 0 | portée réductible ? |
| `Ecrit3_Click` | 1025-1152 | Public | 24 | 123 | 0 | handler GUI |
| `Ecrit3_Activate` | 1154-1158 | Public | 1 | 3 | 0 | handler GUI |
| `Lettre_Click` | 1160-1172 | Public | 3 | 11 | 0 | portée réductible ? |
| `Quit_Click` | 1174-1188 | Public | 1 | 13 | 0 | portée réductible ? |
| `Selct_Click` | 1190-1212 | Public | 5 | 21 | 0 | portée réductible ? |
| `Necrit_Click` | 1214-1219 | Public | 1 | 4 | 0 | portée réductible ? |
| `Clear` | 1221-1240 | Public | 1 | 18 | 0 | portée réductible ? |
| `Suppr_Click` | 1242-1248 | Public | 1 | 5 | 0 | portée réductible ? |
| `DelMvt` | 1250-1264 | Public | 3 | 12 | 0 | portée réductible ? |
| `Calc_solde` | 1266-1291 | Public | 3 | 23 | 0 | portée réductible ? |
| `Button3_Click` | 1293-1297 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et navigation (GUI)

- **`_new()`** [spéciale] [GUI] : `Utils.Observers`, `Music.Load`, centrage, `nvlle = 1`,
  `cnt = 1`, `Prg = "3"`.
- **`form_open()`** [handler] [GUI] : configure `Ecrit1` avec **6 colonnes** (0 à 5), solde à
  `0,00`, focus sur `CV`.
- **`Cmpt_GotFocus()`** [handler du groupe `Cmpt`] [GUI] : couleur d'édition ; sur `Numcompte`
  (Tag 4) pré-remplit le libellé « Règlement par <mode> » ou exige un mode de règlement.
- **`Cmpt_KeyPress()`** [handler, CC 44] [mixte] : enchaînement des champs par Tag (2 date, 3, 4
  compte, 5 montant, 6 n° document, 7, 8 libellé) ; F1 aide ; F2 : Tag 1 → `Journaux()` (appel de
  la **classe** `Journaux` comme fonction, sans `_call` : erreur si atteint ; aucun contrôle n'a le
  Tag 1, branche morte), Tag 4 → `ToggleButton8_Click` ; F5 sur le montant → calculatrice `FCalc`.
- **`Btn_Click()`** [handler du groupe `Btn`] [GUI] : aiguillage par Tag vers `Necrit_Click` (Tag 1,
  aucun bouton : inatteignable), `Suppr_Click` (2), `Lettre_Click` (3, aucun bouton), 
  `ToggleButton4_Click` (4), `Button3_Click` (5), `Selct_Click` (6), `Quit_Click` (7),
  `Button2_Click` (8), `Button1_Click` (9).
- **`Btn_KeyPress()`** [handler] [GUI] : sur `ToggleButton4` (Tag 4), **toute** touche déclenche
  `ToggleButton4_Click` (le `Stop Event` seul est conditionné à Entrée/Tab).
- **`CV_keypress()` / `CV_click()`** [handlers] [GUI] : changement de mode de règlement →
  `Datej_GotFocus` + `Datej_LF` (avec confirmation si des lignes sont saisies).
- **`Journal_GotFocus()`** [réductible] [GUI] : **code mort** (aucun contrôle `Journal`).
- **`Numcompte_GotFocus()`** [réductible] [GUI] : **handler inactif** — `Numcompte` appartient au
  groupe `Cmpt`, Gambas lève `Cmpt_GotFocus` et jamais celui-ci (son rôle est repris par
  `Cmpt_GotFocus`, Tag 4).
- **`ToggleButton6_Click()`** [réductible] [GUI] : **code mort** (aucun contrôle `ToggleButton6`).
- **`Datej_GotFocus()`** [réductible, pseudo-handler] [GUI] : date du jour si nouvelle écriture ;
  `Catch` vide.
- **`Datej_LF()`, `numcompte_LF()`, `Montant_LF()`, `numdoc_LF()`** [réductibles] [mixte] :
  validations « à la sortie du champ » (`QuitteDate`, `compteTiersman`, format du montant via
  `Utils.Cpoint`, doublon de n° de document dans `Fiches_Mvt` : la question posée n'a aucun effet,
  les deux réponses continuent).
- **`Button1_Click()`** [pseudo-handler du groupe `Btn`] [GUI] : quitter (confirmation si saisie en
  cours). **`Button3_Click()`** : `Doc.Open("Saisiesreglements")`.
- **`Cleanchamps()`, `Clear()`, `Necrit_Click()`, `Quit_Click()`** [réductibles] [GUI] : remise à
  zéro des champs et de l'état ; `Necrit_Click` n'est atteignable que par le Tag 1 inexistant.

### Numérotation et contrôle de date

- **`QuitteDate()`** [réductible] [mixte] (l. 648-706) : lit `Fiches_Parametres` (`dtepc`,
  `dteclec1`, `dteclec`), normalise la date saisie (`Utils.CDate_calc`, `Cdate_aff`), refuse une date
  antérieure à la période en cours ou postérieure à la fin d'exercice (comparaisons de chaînes
  `yyyymm`), puis pour une nouvelle écriture : `Ecritures("numecriture")` + 1 → `numecrit`,
  `Majnum`. Numérotation **sans verrou** (deux postes peuvent obtenir le même numéro).
- **`Ecritures(numecr)`** [réductible] [calcul] : `SELECT <numecr> FROM Fiches_Parametres` (nom de
  colonne concaténé) → `num`.
- **`Majnum(numecr)`** [réductible] [calcul] : `UPDATE Fiches_Parametres SET <numecr> = numecrit`.

### Saisie des lignes (SQL)

- **`ToggleButton4_Click()`** [pseudo-handler] [mixte] (l. 723-789) : contrôles de saisie, puis
  `Movt`, ajout de la ligne dans `Ecrit1`. ⚠️ `Ecrit1.Item[6] = NumlotT` alors que la grille n'a
  que 6 colonnes (0 à 5) : erreur d'indice probable, interceptée par le `Catch` qui affiche
  « Il semblerait que cette écriture a déjà été saisie » (à confirmer).
- **`Movt()`** [réductible] [calcul + lecture de contrôles] (l. 126-185) : journal selon `CV`
  (`Fiches_Parametres.jrnal2`/`jrnal3`), compte de trésorerie `Fiches_Journaux.cde_banque` ;
  `UPDATE` ou `INSERT` de la ligne client dans `Fiches_Mvt` (provisoire, `tresorerie = 1`,
  `lettree` = 1 si le montant égale la sélection de lettrage) ; `INSERT` de la contrepartie
  (`Cpt_tr`, libellé « <mode> <intitulé> ») ; ligne de collectif (`coll_cc` du compte) insérée ou
  cumulée avec le journal **en dur `50`**.
- **`compte()`** [réductible] [mixte] : `TriCpt(Client, Avec_Solde, Me)` puis lecture de
  `Comptabilite.Bsel`/`sCmpt` (jamais alimentés par `TriCpt`, voir vue d'ensemble).
- **`compteTiersman()`** [réductible] [mixte] : `SELECT * FROM Fiches_Comptes WHERE compte_cc = &1
  AND coll <> 1` ; affiche intitulé et solde ; ouvre le lettrage pour un `411…`.
- **`Ecrit1_Activate()` / `Ecrit1_Keypress()`** [handlers] [mixte] : reprise (Entrée) ou
  suppression (Suppr) d'une ligne saisie : mise à jour des cumuls, `DelEcr`, retrait de la ligne.
  `Ecrit1_Activate` teste `Val(Current[4])` (le libellé) au lieu du montant (colonne 3).
- **`DelEcr()`** [réductible] [calcul] (l. 995-1020) : `DELETE FROM Fiches_Mvt WHERE numero AND
  compte AND numlot = Ecrit1.Item[6]` (colonne inexistante) pour le compte puis pour son
  collectif, avec `Calc_solde` ; la contrepartie de trésorerie n'est pas supprimée.
- **`Suppr_Click()` / `DelMvt()`** [réductibles] [calcul] : recalcule le solde de chaque compte de
  l'écriture **avant** de la supprimer (`DELETE FROM Fiches_Mvt WHERE numero = &1`) : les soldes
  restent ceux d'avant suppression (les lignes provisoires ne comptent pas, effet nul en pratique
  sauf pour une écriture déjà validée).

### Validation, lettrage et soldes

- **`Button2_Click()`** [pseudo-handler] [mixte] (l. 791-878) : pour chaque ligne de `Ecrit1` :
  `UPDATE Fiches_Mvt SET validee = 1, provisoire = 0 …` pour le client, la trésorerie et le
  collectif ; solde du compte et du collectif mis à jour par incrément (Float brut, sans
  `PointBase`) puis **recalculé** par `Calc_solde(numcpt)` ; `Controle` puis, si lettrable,
  `UPDATE … SET lettree = 1 WHERE numlot = &4`. Le solde du compte de trésorerie n'est jamais mis à
  jour. Les variables `Montand`/`Montanc` sont calculées puis remises à zéro (code mort).
- **`Controle()`** [réductible] [calcul] : somme débit − crédit des lignes validées du lot (cumul
  dans des chaînes via `Utils.cpoint`) ; `Lettrable = 1` si nulle.
- **`Lettrage()`** [réductible] [mixte] : affiche `EcritL` (8 colonnes) avec les écritures non
  lettrées du compte (`SELECT * FROM Fiches_Mvt WHERE compte = &1 AND lettree = 0`).
- **`EcritL_Click()`** [handler, `replay_dynamic` : doit rester `Public`] [mixte] : cumule la
  sélection (`TT`) et mémorise le lot `numlotT`.
- **`Selct_Click()`** [pseudo-handler] [mixte] : pour chaque ligne sélectionnée,
  `UPDATE Fiches_Mvt SET numlot = numlotT WHERE compte AND numero` ; reporte le total dans
  `Montant`.
- **`Lettre_Click()`** [réductible] [GUI] : bascule l'affichage du lettrage.
- **`ToggleButton8_Click()`** [handler] [GUI] : recherche de compte (`compte`).
- **`ecritv()`** [réductible] [mixte] : **code mort** (jamais appelé) ; remplirait `Ecrit3` avec
  les écritures de trésorerie validées non clôturées (`51…`, `53…`).
- **`Ecrit3_Click()`** [handler, CC 24, `replay_dynamic`] [mixte] (l. 1025-1152) : rappel d'une
  écriture validée pour modification : la repasse en provisoire, la délettre, recalcule les soldes,
  recharge `Ecrit1` en écrivant `Item[6]` à `Item[9]` (hors des 6 colonnes). La condition l. 1065
  `left(compte,2) <> 51 OR left(compte,2) <> 53` est toujours vraie. Inatteignable (`Ecrit3`
  jamais rempli). **`Ecrit3_Activate()`** : masque `Ecrit3`.
- **`Calc_solde(Nmcompte)`** [réductible] [calcul] (l. 1266-1291) : identique à
  `Visreglements.Calc_solde` (solde = Σ débit − crédit des écritures validées, `Cbase.Table`).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.Cpoint`, `Utils.CDate_calc`,
  `Utils.Cdate_aff`, `Utils.Cdate_Dbase`, `Utils.PointBase`, `Cbase.Table` (`TabMvt`,
  `TabComptes` dans `Calc_solde` seulement).
- `Comptabilite.Bsel`, `Comptabilite.sCmpt` (lus, jamais écrits par le flux de cet écran).
- `Start.Son`, `Start.Musique`, `FCalc.Resultat`, `TriCpt`, `Doc`, classe `Journaux`.
- Tables (en dur) : `Fiches_Mvt` (INSERT/UPDATE/DELETE), `Fiches_Comptes` (solde),
  `Fiches_Parametres` (lecture, `UPDATE numecriture`), `Fiches_Journaux` (lecture).

## Propositions d'amélioration

### Réécriture / refactorisation

- Recommandation : **supprimer** le couple `.class` + `.form` (TRESORFAC-A01), la fonctionnalité
  étant couverte par `Tresor`. Aucun rework de fond n'est proposé sur un écran inatteignable.
- Si la suppression est refusée : retirer le code mort (`ecritv`, `Journal_GotFocus`,
  `Numcompte_GotFocus`, `ToggleButton6_Click`, branche Tag 1 de `Cmpt_KeyPress` et de `Btn_Click`,
  `Necrit_Click`, membres inutilisés) et corriger l'en-tête.

### Commonalisation avec d'autres fichiers

- 37 fonctions homonymes avec [`Tresor`](../../../Compta/Tresor.class/architecture.md) ; les
  commonalisations proposées dans le lot Compta (`Maj_Solde`, `ProchainNumeroEcriture` via
  `DB_Connection.LockIncrement`, `Cbase.TableMvt`) s'appliqueraient ici si le fichier était gardé.
- `Calc_solde` = [`Visreglements.Calc_solde`](../Visreglements.class/architecture.md) =
  corps de [`Csolde.Solde_caisse`](../../../Utils/Csolde.module/architecture.md).

### Réduction de portée

- Les fonctions `scope_reducible` de `deps.py` sont confirmées par grep (aucun appelant externe).
  Les pseudo-handlers des groupes `Btn`/`Cmpt` (`Button1_Click`, `Button2_Click`, `Button3_Click`,
  `ToggleButton4_Click`, `Suppr_Click`, `Selct_Click`, `Quit_Click`, `Datej_GotFocus`) ne sont pas
  levés par Gambas et pourraient passer `Private` ; les vrais handlers (`Cmpt_*`, `Btn_*`, `CV_*`,
  `Ecrit1_*`, `EcritL_Click`, `Ecrit3_*`, `ToggleButton8_Click`, `form_open`) restent `Public`.

### Séparation traitement / GUI

- Sans objet si le fichier est supprimé ; sinon suivre le découpage proposé pour `Tresor`.

### Requêtes signalées par `sql_params` (après le lot Gestion-2)

- l. 159 : marqueur `&7` absent de l'`UPDATE` (signal `sql_params`) : voir TRESORFAC-A05.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Numérotation des écritures dans `Fiches_Parametres.numecriture` sans verrou : une séquence
  dédiée (table compteur avec `AUTO_INCREMENT` ou verrou applicatif) éviterait les doublons
  (remarque commune à `Tresor`/`Saisecrit`).
