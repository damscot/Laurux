# EdNlettrees — Architecture

> Source : `.src/Compta/Impressions/EdNlettrees.class`

## Vue d'ensemble

`EdNlettrees` est l'écran **« Impression des écritures non lettrées »** (menu Compta,
`Fmenu.Menu103_Click` et `Fmenu.Menu106_Click` → `EdNlettrees.Show`, libellé de menu « Ecritures
non lettrées »). Pour une plage de comptes clients (`411…`), fournisseurs (`401…`) ou de bilan,
lettrables, éventuellement restreinte à des types de clients (`TypeClient1`, `TreeView` de
`Fiches_Typec`), il imprime les écritures **non lettrées** entre deux dates, compte par compte,
avec solde progressif, total par compte et total général. PDF `~/tmp/Enlettrees.pdf` (`Ccompta`),
ouvert par `Visualiseur.Prog`.

Les écritures sont obtenues par la classe [`Listextcpt`](../../Utils/Listextcpt.class/architecture.md)
(option `"n"` : `lettree = False` et journal d'à-nouveaux exclu, `provisoire = False`), qui sait
lire les tables `Fiches_Mvt` à `Fiches_Mvt5` selon les exercices couverts par les dates : c'est la
seule édition du lot qui gère plusieurs exercices.

Le fichier contient en outre six méthodes `Draw` héritées (`Level0`…`Level5`), jamais appelées,
et les variables de l'ancienne version (`EdImpayes`, dont il est le successeur : même en-tête,
même nom de PDF, même aide `Nlettrees`).

Nature globale : **mixte** ; `Button1_Click` (CC 17) concentre requêtes, cumuls et rendu.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TotDeb` | var | Private |  | Float | 27 |
| `TotCred` | var | Private |  | Float | 28 |
| `TotSld` | var | Private |  | Float | 29 |
| `Slddeb` | var | Private |  | Float | 30 |
| `Sldcred` | var | Private |  | Float | 31 |
| `Sldtot` | var | Private |  | Float | 32 |
| `debit` | var | Private |  | Float | 33 |
| `credit` | var | Private |  | Float | 34 |
| `solde` | var | Private |  | Float | 35 |
| `montantd` | var | Private |  | Float | 36 |
| `montantc` | var | Private |  | Float | 37 |
| `dte` | var | Private |  | String | 38 |
| `dte1` | var | Private |  | String | 39 |
| `dte2` | var | Private |  | String | 40 |
| `Filename` | var | Private |  | String | 41 |
| `type` | var | Private |  | String | 42 |
| `Tab0` | var | Private |  | String | 43 |
| `jour` | var | Private |  | String | 44 |
| `Centr` | var | Private |  | String | 45 |
| `Datj` | var | Private |  | String | 46 |
| `libelle` | var | Private |  | String | 47 |
| `Compt` | var | Private |  | String | 48 |
| `rResult` | var | Private |  | Result | 49 |
| `rrResult` | var | Private |  | Result | 50 |
| `Tab` | var | Private |  | String | 51 |
| `Tab2` | var | Private |  | String | 52 |
| `son` | var | Private |  | Integer | 53 |
| `PosY` | var | Private |  | Integer | 54 |
| `pdf` | var | Private |  | Ccompta | 55 |
| `Bsel` | var | Public |  | Boolean | 57 |
| `Bval` | var | Public |  | String | 58 |
<!-- /AUTO:declarations -->

Variables utiles : `type` (`"C"`, `"F"`, `"B"`), `Compt`, `Centr` (compte centralisateur),
`TotDeb`/`TotCred`/`TotSld`, `Slddeb`/`Sldcred`/`Sldtot`, `debit`/`credit`/`solde`, `dte`
(date affichée), `PosY`, `pdf`, `rResult`/`rrResult`, `son`, `Filename`, `Bsel`/`Bval`
(**publics, écrits par `TriCpt` via `Object.SetProperty`**).
Inutiles : `dte1`, `dte2`, `Tab0`, `Tab`/`Tab2` (noms en dur réaffectés), `montantd`, `montantc`,
`libelle`, `Datj` et `jour` (seulement écrits dans la branche « centralisateur »).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 63-75 | Public | 1 | 11 | 0 | méthode spéciale |
| `Ex1` | 80-93 | Public | 1 | 12 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 98-154 | Public | 12 | 44 | 0 | handler GUI |
| `Btn_Click` | 159-175 | Public | 4 | 9 | 0 | handler GUI |
| `cpt_GotFocus` | 180-184 | Public | 1 | 3 | 0 | portée réductible ? |
| `cpt_LostFocus` | 186-190 | Public | 1 | 3 | 0 | portée réductible ? |
| `cpt2_GotFocus` | 192-196 | Public | 1 | 3 | 0 | portée réductible ? |
| `cpt2_LostFocus` | 198-202 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN0_GotFocus` | 204-209 | Public | 1 | 4 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 211-223 | Public | 3 | 11 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 225-229 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 231-243 | Public | 3 | 11 | 0 | portée réductible ? |
| `Raz` | 248-258 | Public | 1 | 9 | 0 | portée réductible ? |
| `Bclient_Click` | 263-272 | Public | 1 | 8 | 0 | handler GUI |
| `Bfournisseur_Click` | 277-286 | Public | 1 | 8 | 0 | handler GUI |
| `Bbilan_Click` | 291-300 | Public | 1 | 8 | 0 | handler GUI |
| `E0_Click` | 305-310 | Public | 1 | 4 | 0 | portée réductible ? |
| `ToggleButton3_Click` | 315-326 | Public | 2 | 9 | 0 | handler GUI |
| `ToggleButton2_Click` | 331-342 | Public | 2 | 9 | 0 | handler GUI |
| `Button1_Click` | 347-487 | Public | 17 | 138 | 0 | portée réductible ? |
| `Level0` | 490-499 | Public | 1 | 8 | 0 | portée réductible ? |
| `Level1` | 502-527 | Public | 1 | 24 | 0 | portée réductible ? |
| `level2` | 530-546 | Public | 1 | 15 | 0 | portée réductible ? |
| `Level3` | 549-557 | Public | 1 | 7 | 0 | portée réductible ? |
| `Level4` | 560-574 | Public | 1 | 13 | 0 | portée réductible ? |
| `Level5` | 577-591 | Public | 1 | 13 | 0 | portée réductible ? |
| `Button3_Click` | 596-600 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie

- **`_New()`** [portée : nécessaire (constructeur)] [nature : GUI]. Observateurs, musique,
  centrage, `E0_click()` (qui appelle `Ex1`), `Bclient_Click()`, puis `ex1()` **une seconde fois**
  (deux lectures de `Fiches_Parametres`), focus sur la date de début.
- **`Ex1()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (nom en
  dur, sans `Available`) ; `dteN0` = 1er jour du mois suivant `dteclec1` (`Utils.Calc_mois`, soit
  le début de l'exercice en cours), `dteN1` = aujourd'hui.
- **`E0_Click()`** [portée : réductible — aucun contrôle `E0` dans le `.form`] [nature : GUI].
  `Tab0 = "Fiches_Mvt"` (inutile) puis `Ex1()`.
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI].
  Entrée/Tab enchaîne `DteN0` (tag 1) → `Dten1` (2) → `Cpt` (3) → `Cpt2` (4) → `DteN0`, en
  appelant explicitement les fonctions `*_LostFocus`/`*_GotFocus` ; F1 aide ; F2 sur `Cpt`/`Cpt2`
  ouvre la sélection de compte.
- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`/`btn`)] [nature : GUI]. Tag 2
  imprimer, 3 fermer (tag 1 vide).
- **`cpt_GotFocus`, `cpt_LostFocus`, `cpt2_GotFocus`, `cpt2_LostFocus`, `dteN0_GotFocus`,
  `dteN1_GotFocus`** [portée : nécessaire (noms de handlers)] [nature : GUI]. Couleur de fond
  (vert `&HAAFF7F&` / `Color.TextBackground`). Les contrôles sont dans le groupe `Cmpt` : ces
  fonctions ne s'exécutent que par appel explicite.
- **`dteN0_LostFocus()`, `dteN1_LostFocus()`** [portée : nécessaire (noms de handlers)] [nature :
  GUI]. Normalisation `Cdate_calc` → `Cdate_aff`, repli sur aujourd'hui si `"00.00.0:00"` ;
  `Catch` : refocalise. Appelées seulement par `Cmpt_KeyPress` (Entrée/Tab), pas sur clic ailleurs.
- **`Bclient_Click()`, `Bfournisseur_Click()`, `Bbilan_Click()`** [portée : nécessaire
  (handlers)] [nature : GUI]. Plage par défaut (`41100001`–`41199999`, `40100001`–`40199999`,
  `1010000`–`9999999`), `type`, visibilité de `TypeClient1` (clients seulement).
- **`ToggleButton3_Click()`, `ToggleButton2_Click()`** [portée : nécessaire (handlers)]
  [nature : GUI]. `New TriCpt(Type, TriCpt.Avec_Solde, Me).Showmodal()` ; `TriCpt` renseigne
  `Bsel`/`Bval` du formulaire appelant ; la valeur choisie va dans `Cpt` ou `Cpt2`.
- **`Raz()`** [portée : réductible] [nature : calcul]. Remise à zéro (`solde` deux fois).
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Nlettrees")`.

### Impression

- **`Button1_Click()`** (CC 17) [portée : nécessaire (appelé par `Btn_Click`, nom de handler)]
  [nature : mixte].
  1. `ste = TypeClient1.where` (écrasé deux lignes plus loin), `Shell "cd …"` inutile,
     `SELECT * FROM Fiches_Societes Where cd_sc = &1` (nom en dur), `New Ccompta`, `Entete`,
     `Level0("du <DteN0> au <Dten1>", Ste)`, `Level1`.
  2. Comptes : `SELECT compte_cc, intitule_cc, cent_cc FROM Fiches_Comptes [,Fiches_Cli WHERE
     cli_code = compte_cc AND] cast(compte_cc as char) >= &1 and … <= &2 and type_cc = &4 and
     lettrable <> false [AND <TypeClient1.where>] order by cast(compte_cc AS char)` (fragment SQL
     `cli_typec IN (…)` construit par `TypeClient` avec `Subst` ; noms en dur ; un paramètre `0`
     surnuméraire).
  3. Par compte : `New Listextcpt(compt, dten0.Text, dten1.Text, "n", " dte asc").resext`. Si au
     moins une ligne : `level3` (compte), puis pour chaque ligne **dont la date est à nouveau
     testée** entre les bornes (`Cdate_Comp` / `Cdate_dbase`, redondant avec `Listextcpt`, à
     confirmer) : si le compte n'est pas centralisateur (`cent_cc <> "1"`), cumul et `level2` ;
     sinon les champs sont copiés dans des variables jamais lues (aucune ligne imprimée, total à 0,
     EDNLETTREES-A02). `level4` (total compte), cumul général.
  4. Fin : `Lines`, `level5` (total général), `BasPage` (dernière page seulement), `Output`,
     `Visualiseur.Prog`. Sans compte : son + `message(" Aucune ecriture pour cette demande")` ; le
     message n'apparaît pas si les comptes existent mais n'ont aucune écriture (PDF vide).
  Saut de page `PosY >= 280` copié 4 fois.

### Rendu `Draw` hérité (code mort)

- **`Level0`, `Level1`, `level2`, `Level3`, `Level4`, `Level5`** [portée : réductible — code mort]
  [nature : GUI]. Mêmes méthodes que dans [Echeancier](../Echeancier.class/architecture.md) ;
  aucun appel (les appels `pdf.Level…` visent `Ccompta`).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.Calc_mois`, `Utils.Cdate_calc`/`Cdate_aff`/`Cdate_Comp`/
  `Cdate_dbase`.
- `Listextcpt` (lecture multi-exercices), `TypeClient` (contrôle utilisateur, propriété `where`),
  `TriCpt` (sélection de compte, écrit `Bsel`/`Bval`).
- `Start.Son`, `Start.Musique`, `Start.Societe`.
- Noms en dur : `Fiches_Parametres`, `Fiches_Societes`, `Fiches_Comptes`, `Fiches_Cli`.
- Fichier `~/tmp/Enlettrees.pdf` (même nom que `EdNjustifiees` et `EdImpayes`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la seconde lecture de `Fiches_Parametres` dans `_New` (SQL modifié, dump identique),
  `E0_Click` (non-handler, alias d'`Ex1`) et les variables mortes.
- Une seule requête de comptes avec jointure et filtre `TypeClient` conditionnels.
- Helper `SautPage()` pour les quatre blocs `PosY >= 280`.

### Commonalisation avec d'autres fichiers

- **Socle commun des éditions comptables** (voir [FTVA](../FTVA.class/architecture.md#commonalisation-avec-dautres-fichiers)) :
  en-tête société, fichier PDF, `Termine`, saisie de date.
- **Sélection d'une plage de comptes** (radio client/fournisseur/bilan, plages par défaut,
  `TypeClient`, boutons `TriCpt` qui écrivent `Bsel`/`Bval`, chaînage Entrée de `Cmpt_KeyPress`) :
  copiée dans [EdNjustifiees](../EdNjustifiees.class/architecture.md),
  [EdImpayes](../EdImpayes.class/architecture.md) et, selon `grep -rl "TriCpt.Avec_Solde"`, 18
  fichiers. Un helper `PlageComptes(sType) As String[]` et une fonction de sélection
  `ChoisirCompte(sType, hForm) As String` réduiraient la duplication sans toucher aux `.form`.
- La requête des comptes est identique (à la colonne `solde` et au filtre `lettrable` près) à
  celle d'`EdNjustifiees` : fonction commune `Comptes_Plage(sDu, sAu, sType, sWhereTypeClient,
  bLettrables)`.

### Réduction de portée

- `Ex1`, `Raz` → `Private` ; `E0_Click` (pas de contrôle `E0`) → supprimée ou `Private` ;
  `Level0`…`Level5` supprimées. **Ne pas** réduire `Bsel`/`Bval` : écrits par `TriCpt` via
  `Object.SetProperty` (faux positif de `deps.py`).

### Séparation traitement / GUI

- `Lignes_Compte(sCompte, sDu, sAu, bCentralisateur) As Variant[]` (lignes et totaux, sans
  contrôle) ; `Button1_Click` ne fait que le rendu.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- La comparaison `cast(compte_cc as char)` empêche l'usage de l'index de clé primaire ; un
  `compte_cc` de type texte de longueur fixe simplifierait toutes les plages de comptes.
- `lettrable` est un booléen stocké en `tinyint` comparé à `false` : une contrainte `NOT NULL
  DEFAULT 1` éviterait les cas `NULL` (exclus par `<> false`).
