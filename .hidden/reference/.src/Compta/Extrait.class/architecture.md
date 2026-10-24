# Extrait — Architecture

> Source : `.src/Compta/Extrait.class`

## Vue d'ensemble

Écran de **consultation des extraits de compte** (grand livre d'un compte) : choix du type de
compte (client, fournisseur, gestion, bilan), navigation entre comptes, choix de la période
(exercice courant `E0`, exercice « de bilan » `E1`, exercices N-1 à N-5 `N1`…`N5`), filtre
lettrées / non lettrées / toutes, tris par colonne, affichage centralisé (cumul mensuel) pour
les comptes `cent_cc`, impression PDF, accès à la modification d'une écriture (`Saisecrit` ou
`Tresor`), au lettrage (F4), à la GED (clic droit).

Appelants (tous `New Extrait(code, intitulé, type, org)` + `ShowModal`) : `Fmenu.Menu16_Click`
(sans compte), `Saisecrit` et `Tresor` (F8 sur un compte saisi), `FClient` (`Org = "S"`,
type `C`). Avec `Org = "S"`, l'écran se positionne sur le compte reçu.

La lecture des écritures est déléguée à `Listextcpt` (`$lstex.resext`), qui parcourt
`Fiches_Mvt`…`Fiches_Mvt5` selon la période et ajoute une ligne « Report a nouveau ». Les
totaux « hors période » (`dbHP`, `CdHP`, `SdHP`), « période » (`dbP`, `CdP`, `SdP`) et
généraux sont calculés pendant le remplissage de la grille.

Le mode centralisé utilise une **table physique de travail `Ctrln`** (`DROP`/`CREATE` à chaque
affichage, `ENGINE = MYISAM` en dur).

Nature globale : **mixte** ; l'essentiel est dans `affichage` (CC 31) et `_New` (CC 31).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Ncode` | var | Private |  | Integer | 28 |
| `TT` | var | Private |  | Float | 29 |
| `TD` | var | Private |  | String | 30 |
| `TC` | var | Private |  | String | 31 |
| `DebHP` | var | Private |  | Float | 32 |
| `CredHP` | var | Private |  | Float | 33 |
| `TotSldHP` | var | Private |  | Float | 34 |
| `DebP` | var | Private |  | Float | 35 |
| `CredP` | var | Private |  | Float | 36 |
| `TotSldP` | var | Private |  | Float | 37 |
| `montantd` | var | Private |  | Float | 38 |
| `montantc` | var | Private |  | Float | 39 |
| `Mnt` | var | Private |  | Float | 40 |
| `Mnt1` | var | Private |  | Float | 41 |
| `dte` | var | Private |  | New LDate | 42 |
| `dte1` | var | Private |  | New LDate | 43 |
| `dte2` | var | Private |  | New LDate | 44 |
| `Txt` | var | Private |  | String | 45 |
| `Tab0` | var | Private |  | String | 46 |
| `Tab1` | var | Private |  | String | 47 |
| `Tab2` | var | Private |  | String | 48 |
| `type` | var | Private |  | String | 49 |
| `rrResult` | var | Private |  | Result | 50 |
| `Cresult` | var | Private |  | Result | 51 |
| `Compt` | var | Private |  | String | 52 |
| `Centr` | var | Private |  | Boolean | 53 |
| `jour` | var | Private |  | New LDate | 54 |
| `$journal` | var | Private |  | String | 55 |
| `Datj` | var | Private |  | LDate | 56 |
| `intitule` | var | Private |  | String | 57 |
| `son` | var | Private |  | Integer | 58 |
| `b` | var | Private |  | Integer | 59 |
| `Cloturee` | var | Private |  | Integer | 60 |
| `num` | var | Private |  | Integer | 61 |
| `Tri` | var | Private |  | String | 62 |
| `$Code` | var | Private |  | String | 63 |
| `$Intitule` | var | Private |  | String | 64 |
| `$type` | var | Private |  | String | 65 |
| `$Org` | var | Private |  | String | 66 |
| `sJournal` | var | Private |  | String | 67 |
| `sNumero` | var | Private |  | String | 68 |
| `bTri` | var | Private |  | Boolean | 69 |
| `sTri` | var | Private |  | String | 70 |
| `Bsel` | var | Public |  | Boolean | 71 |
| `Bval` | var | Public |  | String | 72 |
| `sCmpt` | var | Public |  | String | 73 |
| `sDesg` | var | Public |  | String | 74 |
| `$lstex` | var | Private |  | Listextcpt | 75 |
| `$rpt` | var | Private |  | Report | 76 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 81-216 | Public | 31 | 119 | 0 | méthode spéciale |
| `Ex1` | 221-248 | Public | 3 | 22 | 0 | portée réductible ? |
| `Exo` | 253-273 | Public | 2 | 15 | 0 | portée réductible ? |
| `nmoins_click` | 279-294 | Public | 1 | 12 | 0 | handler GUI |
| `Button7_Click` | 296-311 | Public | 2 | 11 | 0 | handler GUI |
| `cmpt_keypress` | 316-343 | Public | 6 | 22 | 0 | handler GUI |
| `cpt_LostFocus` | 345-357 | Public | 4 | 11 | 0 | handler GUI |
| `Cmpt_GotFocus` | 362-368 | Public | 1 | 5 | 0 | handler GUI |
| `cpt_LF` | 370-405 | Public | 30 | 34 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 407-412 | Public | 1 | 4 | 0 | handler GUI |
| `dteN1_LostFocus` | 414-419 | Public | 1 | 4 | 0 | handler GUI |
| `Compdate` | 421-435 | Public | 4 | 12 | 0 | portée réductible ? |
| `compdate2` | 437-451 | Public | 4 | 12 | 0 | portée réductible ? |
| `compteman` | 456-484 | Public | 4 | 26 | 0 | portée réductible ? |
| `clear` | 489-512 | Public | 1 | 22 | 0 | portée réductible ? |
| `affichage` | 517-674 | Public | 31 | 144 | 0 | portée réductible ? |
| `ctrlchange` | 676-692 | Private | 2 | 11 | 0 |  |
| `aff` | 698-722 | Public | 5 | 22 | 0 | portée réductible ? |
| `Centralisation` | 727-750 | Public | 2 | 21 | 0 | portée réductible ? |
| `finmois` | 755-766 | Public | 2 | 9 | 0 | portée réductible ? |
| `detail_Click` | 771-780 | Public | 2 | 7 | 0 | handler GUI |
| `Toutes_Click` | 785-793 | Public | 2 | 6 | 0 | handler GUI |
| `Enl_Click` | 798-806 | Public | 2 | 6 | 0 | handler GUI |
| `El_Click` | 811-819 | Public | 2 | 6 | 0 | handler GUI |
| `Bclient_Click` | 824-836 | Public | 2 | 10 | 0 | handler GUI |
| `Bfournisseur_Click` | 841-853 | Public | 1 | 10 | 0 | handler GUI |
| `Bgestion_Click` | 858-870 | Public | 1 | 10 | 0 | handler GUI |
| `Bbilan_Click` | 875-887 | Public | 1 | 10 | 0 | handler GUI |
| `E0_Click` | 892-897 | Public | 1 | 3 | 0 | handler GUI |
| `E1_Click` | 902-906 | Public | 1 | 3 | 0 | handler GUI |
| `Button4_Click` | 911-919 | Public | 1 | 6 | 0 | handler GUI |
| `Button1_Click` | 925-938 | Public | 2 | 11 | 0 | handler GUI |
| `Button2_Click` | 943-955 | Public | 2 | 10 | 0 | handler GUI |
| `Button3_Click` | 961-969 | Public | 1 | 6 | 0 | handler GUI |
| `Form_KeyPress` | 971-984 | Public | 3 | 12 | 0 | handler GUI |
| `Raz` | 990-1000 | Public | 1 | 9 | 0 | portée réductible ? |
| `Tdate_MouseDown` | 1002-1013 | Public | 2 | 10 | 0 | handler GUI |
| `Tlibelle_MouseDown` | 1015-1026 | Public | 2 | 10 | 0 | handler GUI |
| `Tdoc_MouseDown` | 1028-1039 | Public | 2 | 10 | 0 | handler GUI |
| `Tnumero_MouseDown` | 1041-1052 | Public | 2 | 10 | 0 | handler GUI |
| `Tdebit_MouseDown` | 1054-1065 | Public | 2 | 10 | 0 | handler GUI |
| `Tcredit_MouseDown` | 1067-1078 | Public | 2 | 10 | 0 | handler GUI |
| `Tjournal_MouseDown` | 1080-1091 | Public | 2 | 10 | 0 | handler GUI |
| `Tlettree_MouseDown` | 1093-1104 | Public | 2 | 10 | 0 | handler GUI |
| `Colcli_MouseUp` | 1106-1128 | Public | 8 | 19 | 0 | handler GUI |
| `Colcli_KeyPress` | 1130-1136 | Public | 3 | 5 | 0 | handler GUI |
| `Colcli_Activate` | 1138-1199 | Public | 21 | 59 | 0 | handler GUI |
| `Necrit_Click` | 1204-1231 | Public | 7 | 24 | 0 | handler GUI |
| `Appel_Saisie` | 1233-1240 | Public | 2 | 5 | 0 | portée réductible ? |
| `Appel_Tresor` | 1242-1249 | Public | 2 | 5 | 0 | portée réductible ? |
| `Button5_Click` | 1254-1258 | Public | 1 | 3 | 0 | handler GUI |
| `Button6_Click` | 1263-1269 | Public | 1 | 5 | 0 | handler GUI |
| `butedit_Click` | 1273-1434 | Public | 10 | 144 | 0 | handler GUI |
| `ajoulign` | 1436-1484 | Private | 2 | 41 | 0 |  |
| `ajouadr` | 1487-1521 | Private | 1 | 25 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et périodes

- **`_New(scode, sintitule, stype, Org)`** (CC 31) [portée : nécessaire] [nature : mixte].
  Chaînage de saisie et observateurs `cmpt` sur `dteN0`, `dten1`, `cpt` ; largeurs des 10
  colonnes lues dans `/Soc<XX>/Col/LcolE` (`col0:80;col1:90;…`, `Select` sur 10 cas) ou valeurs
  par défaut ; en-têtes calés sur les colonnes ; `Ex1` (appelé deux fois si la date du jour est
  après la fin de période) ou `Exo` ; `E0` coché ; si `Org = "S"`, sélection du type et du compte
  reçus (`B*_Click`, `compteman`). `Tab0`, `$Intitule` sont affectés mais jamais lus.
- **`Ex1()`** [portée : réductible] [nature : mixte]. Période = lendemain de `dteclec` → fin du
  mois courant (exercice en cours non encore clôturé) ; si la date du jour est avant le début,
  bascule sur `Exo`. Charge la liste des comptes du type (`rrResult`).
- **`Exo()`** [portée : réductible] [nature : mixte]. Période = exercice se terminant à
  `dteclec` (12 mois) ; recharge `rrResult`.
- **`nmoins_click()`** [handler du groupe `nmoins`, `N1`…`N5`] [nature : mixte]. Période de
  l'exercice archivé dont la fin est `Fiches_Parametres.<Tag>` (`dteclec1`…`dteclec5`). Champ
  nul (exercice inexistant) → erreur `DateAdd` (à confirmer).
- **`E0_Click()`** / **`E1_Click()`** [handlers] [nature : GUI]. `Ex1` / `Exo`.
- **`dteN0_LostFocus()`** / **`dteN1_LostFocus()`** [handlers] [nature : GUI]. Normalisation de
  la saisie par `LDate.L`.
- **`Compdate()`** / **`compdate2()`** [portée : réductible, **code mort**]. Aucun appelant ;
  affichent `Txt`, jamais affecté.

### Choix du compte et navigation

- **`Bclient_Click`**, **`Bfournisseur_Click`**, **`Bgestion_Click`**, **`Bbilan_Click`**
  [handlers] [nature : mixte]. Corps identiques au type près : remise à blanc, `type`,
  `SELECT * FROM Fiches_Comptes WHERE type_cc = &1 order by cast(compte_cc AS char)`, puis
  `Button4_Click` (premier compte). Seul `Bclient_Click` conditionne ce dernier appel à `$Org`
  vide.
- **`Button4_Click`** (premier), **`Button1_Click`** (précédent), **`Button2_Click`** (suivant),
  **`Button3_Click`** (dernier) [handlers] [nature : GUI]. Positionnent `Compt` (`"0"`…`"4"`)
  puis `affichage`.
- **`Button7_Click()`** [handler] [nature : GUI]. Liste de choix `TriCpt` (avec solde) ; le
  retour se fait par `Object.SetProperty(Me, "Bsel"/"Bval")` dans `TriCpt`.
- **`cmpt_keypress()`** [handler du groupe `cmpt`] [nature : GUI]. F1 aide, F2 liste des
  comptes, F4 lettrage (`New Lettrage(cpt, type)`).
- **`Cmpt_GotFocus()`** [handler] [nature : GUI]. `Utils.SetEditColor`.
- **`cpt_LostFocus()`** [handler] [nature : mixte]. `cpt_LF` puis `compteman` ; en cas d'erreur
  (`b <> 0`), retour au premier compte.
- **`cpt_LF()`** (CC 30) [portée : réductible] [nature : GUI]. Contrôle de période (fin avant
  début → retour à `Exo`) et du préfixe du compte selon le type (411, 401, 6/7, 1-5/8/9). Les
  conditions répètent `Bxxx.Value And` à chaque terme.
- **`compteman()`** [portée : réductible] [nature : mixte]. `SELECT compte_cc, intitule_cc,
  cent_cc FROM Fiches_Comptes WHERE compte_cc like '<cpt>%' and type_cc = &2` : **valeur saisie
  concaténée** (et `&1` passé mais inutilisé). Positionne `Centr`, `Ctrl` et coche `detail`
  (`If Cmpts Then` : un `Result` est toujours vrai) puis `affichage`.

### Affichage

- **`clear()`** [portée : réductible] [nature : GUI]. Remise à zéro des totaux et libellés.
- **`Raz()`** [portée : réductible] [nature : GUI]. Vide la grille et les cumuls ;
  `CdP.Text = "" = 0` affecte le résultat d'une comparaison (anomalie inoffensive, écrasée par
  `affichage`).
- **`affichage()`** (CC 31) [portée : réductible] [nature : mixte]. Positionne le compte courant
  dans `rrResult` selon `Compt` (sans test `Available` pour `"0"` et `"4"`), choisit le filtre de
  lettrage (`n`/`o`/`t`) et instancie `Listextcpt`. En mode détaillé, ajoute chaque écriture de
  la période (date, libellé, pièce, débit, crédit, solde progressif, numéro, journal, lettrage
  `*`, trésorerie `T`) et cumule les totaux ; les écritures antérieures vont dans les totaux
  hors période. En mode centralisé (`Ctrl` coché et `detail` décoché) : `DROP`/`CREATE TABLE
  Ctrln … ENGINE = MYISAM`, puis `Centralisation` + `aff` **pour chaque écriture**. Variables
  locales inutilisées : `presult`, `jour`, `ged`.
- **`ctrlchange()`** [portée : Private] [nature : GUI]. `Centr = cent_cc` ; si non centralisé,
  décoche `Ctrl` et `detail` (sous `Object.Lock`).
- **`Centralisation()`** [portée : réductible] [nature : mixte]. Cumule le débit/crédit du mois
  dans `Ctrln` (`SELECT` puis `Update` ou `INSERT`), date = dernier jour du mois (`finmois`).
  `intitule` (membre jamais affecté) est inséré vide.
- **`aff()`** [portée : réductible] [nature : mixte]. Vide la grille (si centralisé non
  détaillé) et la remplit avec toutes les lignes de `Ctrln` ; `DebP`/`CredP` sont **écrasés**
  par la dernière ligne au lieu d'être cumulés (voir EXTRAIT-A01).
- **`finmois(Jrs)`** [portée : réductible] [nature : calcul]. Dernier jour du mois (doublon de
  `LDate.FinMois`).
- **`detail_Click`**, **`Toutes_Click`**, **`Enl_Click`**, **`El_Click`** [handlers]
  [nature : GUI]. Réaffichage.
- **`Tdate_MouseDown`**, **`Tlibelle_MouseDown`**, **`Tdoc_MouseDown`**, **`Tnumero_MouseDown`**,
  **`Tdebit_MouseDown`**, **`Tcredit_MouseDown`**, **`Tjournal_MouseDown`**,
  **`Tlettree_MouseDown`** [handlers] [nature : GUI]. Huit corps identiques au champ près :
  `sTri = "<champ> asc|desc"`, réaffichage, inversion de `btri`.

### Actions sur une écriture

- **`Colcli_MouseUp()`** [handler] [nature : mixte]. Clic droit : recherche GED
  (`LGed.Search`) sur le compte (clients/fournisseurs) ou le numéro d'écriture (gestion/bilan).
- **`Colcli_KeyPress()`** [handler] [nature : GUI]. Entrée → `Colcli_Activate`.
- **`Colcli_Activate()`** (CC 21) [handler] [nature : mixte]. Si l'écran n'a pas été ouvert avec
  `Org` et que la période est `E0`/`E1` et non centralisée : lit l'écriture
  (`$lstex.litleres(num)`, **résultat écrasé** à la ligne suivante), `SELECT * FROM Fiches_Mvt
  where numero = &1` ; refuse si clôturée, puis si sa ligne `51*` est pointée ; sinon affiche le
  bouton « Modifier » (`Necrit`).
- **`Necrit_Click()`** [handler] [nature : GUI]. Si la fenêtre d'impression `Journaux` n'est pas
  visible (référence à l'auto-instance d'un **autre** formulaire), ouvre `Saisecrit` ou `Tresor`
  selon la colonne trésorerie, puis réaffiche ; sinon `Message.Delete` (dialogue de suppression
  utilisé pour une information).
- **`Form_KeyPress()`** [handler] [nature : GUI]. F11 nouvelle saisie (`Appel_Saisie`), F12
  trésorerie (`Appel_Tresor`), puis réaffichage.
- **`Appel_Saisie()`** / **`Appel_Tresor()`** [portée : réductible] [nature : GUI].
  `New Saisecrit("")` / `New Tresor("")` en modal.

### Impression et sortie

- **`butedit_Click()`** [handler] [nature : mixte]. Rapport `gb.report` vers
  `~/tmp/Extrait.pdf` : en-tête société (`SELECT * FROM Fiches_Societes`, première ligne, sans
  filtre de société), adresse du tiers (`Fiches_Cli where cli_code = <compte>` ou `Fiches_Four
  where fo_code = <compte>`, **sans test `Available`**), puis toutes les lignes de
  `$lstex.resext` (y compris le report à nouveau), totaux, `Visualiseur.Prog`.
- **`ajoulign(sld, resext)`** [Private] [nature : GUI]. Une ligne du rapport ; ne fait rien si la
  grille est vide.
- **`ajouadr(vb1, rs, nom, adr1, adr2, ville)`** [Private] [nature : GUI]. Bloc d'adresse et
  période.
- **`Button5_Click()`** [handler] [nature : GUI]. `Doc.Open("Visextraits")`.
- **`Button6_Click()`** [handler] [nature : GUI]. Enregistre les largeurs `col0`…`col9` dans
  `/Soc<XX>/Col/LcolE` puis ferme (la fermeture par la croix n'enregistre pas).

## État global utilisé

- `Start.LocalSettings` (`/Soc<XX>/Col/LcolE`), `Start.Societe`, `Start.Son`, `Start.Musique`,
  `Start.R/G/B` (couleur du rapport).
- `Utils.db`, `Utils.cpoint`, `Utils.Cdate_Comp`, `Utils.Cdate_Dbase`, `Utils.SetEditColor`,
  `Utils.Observers`.
- Membres publics `Bsel`, `Bval` (écrits par `TriCpt` via `Object.SetProperty`) ; `sCmpt`,
  `sDesg` (jamais utilisés).
- Membres d'instance très nombreux (49), dont une quinzaine inutilisés (`Tab0`, `TT`, `TD`,
  `TC`, `Ncode`, `Tri`, `$Intitule`, `intitule`, `Txt`, `sCmpt`, `sDesg`…).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer le code mort : `Compdate`, `compdate2`, `Txt`, membres inutilisés, appel
  `litleres` écrasé, variables locales (EXTRAIT-002).
- Huit handlers de tri → helper privé `TriSur(sChamp)` (EXTRAIT-004) ; quatre handlers de type →
  `ChoixType(sType, bSiOrgVide)` (EXTRAIT-005).
- `_New` : boucle sur `colN` au lieu du `Select` de 10 cas (EXTRAIT-006).
- `affichage` : extraire `PositionneCompte()` (bloc `Compt`) et `AfficheTotaux()` (EXTRAIT-007).
- `cpt_LF` : table préfixes autorisés par type (EXTRAIT-008).

### Commonalisation avec d'autres fichiers

- `finmois` = `LDate.FinMois` ; calcul identique dans [`FCloture`](../Clotures/FCloture.class/architecture.md)
  (l. 145-150) ; périodes d'exercice (`Ex1`, `Exo`, `nmoins_click`) = `LDate.Exercice_Debut/Fin`,
  `Exercice_Cloture(i)` (voir [`LDate`](../../Utils/LDate.class/architecture.md)).
- Persistance des largeurs de colonnes (`/Col/LcolE`) : idiome à rapprocher des autres écrans
  qui sauvent leurs colonnes (helper `Utils.SauveColonnes(grille, clé)` / `ChargeColonnes`).
- Contrôles « écriture clôturée / pointée » de `Colcli_Activate` : mêmes règles dans
  [`Saisecrit`](../Saisecrit.class/architecture.md) et [`Tresor`](../Tresor.class/architecture.md)
  → fonction commune `EtatEcriture(numero)`.
- Lecture des écritures : déjà factorisée dans `Listextcpt` (bon modèle).

### Réduction de portée

- `Ex1`, `Exo`, `cpt_LF`, `compteman`, `clear`, `affichage`, `aff`, `Raz`, `Centralisation`,
  `finmois`, `Appel_Saisie`, `Appel_Tresor` → `Private` (aucun appelant externe, `grep`).
- `sCmpt`, `sDesg` → suppression (les `Comptabilite.sCmpt` du projet visent une autre classe).
- `Bsel`, `Bval` : **à conserver `Public`** (écrits par `TriCpt` via `Object.SetProperty`,
  invisible pour `deps.py`).

### Séparation traitement / GUI

- `CumulsExtrait(resext, dDeb, dFin) As Float[]` (totaux hors période / période) pur, testable.
- `CentraliseMois(...)` sans table physique : cumul en `Collection` (changement du SQL émis et
  disparition de `Ctrln` : voir anomalie A02).
- `EtatEcriture(numero) As Integer` pour `Colcli_Activate`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Supprimer la table de travail `Ctrln` (cumuls en mémoire ou `GROUP BY` mensuel).
- Une colonne `exercice` indexée dans une table d'écritures unique éviterait les `UNION` sur
  `Fiches_Mvt`…`Mvt5` de `Listextcpt`.
