# Preparation — Architecture

> Source : `.src/Gestion/Lcr/Preparation.class`

## Vue d'ensemble

Écran **« Préparation des bordereaux »** (menu Gestion › LCR, `Fmenu.Menuprep_Click`), troisième
étape de la chaîne LCR (voir [`Lcr`](../Lcr.class/architecture.md)) : à partir des LCR attribuées à
une banque (`Fiches_Lcr.banque <> 0`, non écartées, `bordereau = 0`), l'utilisateur fixe le **code
entrée** (type de remise, voir [`EntreeItem`](../EntreeItem.module/architecture.md)) et **génère un
bordereau** : ligne dans `Fiches_Bordereaux` (banque, code entrée, date de remise, référence, date
de valeur, échéances, total, `etat = 0`) et numéro de bordereau écrit dans `Fiches_Lcr.bordereau`.
Le bordereau est ensuite édité et transformé en fichier bancaire par
[`Bordrx`](../Bordrx.class/architecture.md).

- Filtres : banque `BQ`, code entrée `Entree` ; tri par en-têtes ; recherche par échéance (`DAE`).
- Grille virtuelle `ColLcr` (10 colonnes ; la 10ᵉ sert de marque de sélection par clic droit).
- Fiche (onglet) : modification d'une LCR (banque `BQ2`, code entrée `Entree2`) ou du code entrée de
  toutes les lignes marquées.
- Panneau `Panel1` : saisie des paramètres du bordereau puis génération (`Button12`).
- Impression de la liste (`~/Lcr.pdf`).

L'écran appelle `Utils.Observers(Me)` (rejouable), mais la grille `ColLcr` n'a pas de
`ColLcr_Click` (`replay_missing`) : la sélection passe par `ColLcr_MouseUp`.

Nature : écran **mixte** ; aucune écriture comptable.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 28 |
| `tab` | var | Private |  | String | 29 |
| `rs1` | var | Private |  | Result | 30 |
| `sel` | var | Private |  | String | 31 |
| `txt` | var | Private |  | String | 32 |
| `Lcrtable` | var | Private |  | New String[10] | 33 |
| `B` | var | Private |  | Integer | 34 |
| `rResult` | var | Private |  | Result | 35 |
| `son` | var | Private |  | Integer | 36 |
| `sKey` | var | Private |  | String | 37 |
| `Dbl` | var | Private |  | String | 38 |
| `CoulB` | var | Private |  | Integer | 39 |
| `CoulF` | var | Private |  | Integer | 40 |
| `Fnt` | var | Private |  | String | 41 |
| `CoulZns` | var | Private |  | Integer | 42 |
| `CoulZnaf` | var | Private |  | Integer | 43 |
| `Coulfc` | var | Private |  | Integer | 44 |
| `Coulfond` | var | Private |  | New String[] | 45 |
| `nv` | var | Private |  | Boolean | 46 |
| `Dte1` | var | Private |  | Integer | 47 |
| `Type` | var | Private |  | String | 48 |
| `Bsel` | var | Public |  | Boolean | 49 |
| `Bval` | var | Public |  | String | 50 |
| `sCmpt` | var | Public |  | String | 51 |
| `sdesg` | var | Public |  | String | 52 |
| `PosX` | var | Private |  | Integer | 53 |
| `PosY` | var | Private |  | Integer | 54 |
| `rBq` | var | Private |  | Result | 55 |
| `Nb` | var | Public |  | Integer | 56 |
| `sDate` | var | Public |  | Boolean | 57 |
| `iLind` | var | Public |  | Integer | 58 |
| `ControleCombobox` | var | Public |  | Boolean | 59 |
| `Enrg` | var | Private |  | Integer | 60 |
| `der` | var | Private |  | Result | 61 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 63-95 | Public | 4 | 27 | 0 | méthode spéciale |
| `Form_Open` | 97-119 | Public | 7 | 21 | 0 | handler GUI |
| `Entete` | 121-134 | Public | 1 | 11 | 0 | portée réductible ? |
| `CO_GotFocus` | 136-145 | Public | 1 | 8 | 0 | handler GUI |
| `Co_LostFocus` | 147-151 | Public | 1 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 153-162 | Public | 1 | 8 | 0 | handler GUI |
| `Inte_LostFocus` | 164-168 | Public | 1 | 3 | 0 | handler GUI |
| `DA_GotFocus` | 170-179 | Public | 1 | 8 | 0 | handler GUI |
| `DA_LostFocus` | 181-185 | Public | 1 | 3 | 0 | handler GUI |
| `DAE_GotFocus` | 187-197 | Public | 1 | 9 | 0 | handler GUI |
| `DAE_KeyPress` | 199-218 | Public | 4 | 18 | 0 | handler GUI |
| `DAE_LostFocus` | 220-225 | Public | 1 | 4 | 0 | handler GUI |
| `NUM_GotFocus` | 227-236 | Public | 1 | 8 | 0 | handler GUI |
| `NUM_LostFocus` | 238-242 | Public | 1 | 3 | 0 | handler GUI |
| `MNT_GotFocus` | 244-253 | Public | 1 | 8 | 0 | handler GUI |
| `MNT_LostFocus` | 255-259 | Public | 1 | 3 | 0 | handler GUI |
| `ACC_LostFocus` | 261-265 | Public | 1 | 3 | 0 | handler GUI |
| `ACC_GotFocus` | 267-276 | Public | 1 | 8 | 0 | handler GUI |
| `BAQ_LostFocus` | 278-282 | Public | 1 | 3 | 0 | handler GUI |
| `BAQ_GotFocus` | 284-293 | Public | 1 | 8 | 0 | handler GUI |
| `ColLcr_Data` | 295-328 | Public | 9 | 33 | 0 | handler GUI |
| `Tris` | 330-347 | Public | 1 | 15 | 0 | portée réductible ? |
| `Deb` | 349-369 | Public | 3 | 19 | 0 | portée réductible ? |
| `Deb2` | 371-385 | Public | 2 | 13 | 0 | portée réductible ? |
| `Deb3` | 387-405 | Public | 2 | 16 | 0 | portée réductible ? |
| `Deb4` | 407-415 | Public | 1 | 7 | 0 | portée réductible ? |
| `Total` | 417-451 | Public | 9 | 32 | 0 | portée réductible ? |
| `N_click` | 453-458 | Public | 1 | 4 | 0 | portée réductible ? |
| `A_click` | 460-465 | Public | 1 | 4 | 0 | portée réductible ? |
| `BQ_Click` | 467-473 | Public | 1 | 5 | 0 | handler GUI |
| `Entree_click` | 475-493 | Public | 4 | 17 | 0 | handler GUI |
| `Refresh` | 495-499 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 501-505 | Public | 1 | 3 | 0 | handler GUI |
| `ColLcr_MouseUp` | 507-524 | Public | 5 | 16 | 0 | handler GUI |
| `CleanChamps` | 526-541 | Public | 1 | 14 | 0 | portée réductible ? |
| `Maj_Zones` | 543-571 | Public | 6 | 26 | 0 | portée réductible ? |
| `Button10_Click` | 576-595 | Public | 3 | 17 | 0 | handler GUI |
| `Button12_Click` | 601-656 | Public | 14 | 51 | 0 | handler GUI |
| `Button2_Click` | 661-672 | Public | 1 | 9 | 0 | handler GUI |
| `Button3_Click` | 677-695 | Public | 5 | 17 | 0 | handler GUI |
| `Button1_Click` | 700-704 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 706-710 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button7_Click` | 712-716 | Public | 1 | 3 | 0 | handler GUI |
| `compte` | 721-733 | Public | 2 | 10 | 0 | portée réductible ? |
| `compteman` | 738-745 | Public | 2 | 5 | 0 | portée réductible ? |
| `Cmpt_keypress` | 747-754 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 756-765 | Public | 3 | 8 | 0 | handler GUI |
| `Imp_Lcr` | 767-837 | Public | 16 | 68 | 0 | portée réductible ? |
| `Button9_Click` | 839-843 | Public | 1 | 3 | 0 | handler GUI |
| `CheckBox1_Click` | 845-853 | Public | 2 | 7 | 0 | handler GUI |
| `Button11_Click` | 855-862 | Public | 1 | 6 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte] : couleurs, `Utils.Observers(Me)`,
  fond lu par **`Settings[...]`** (fichier de configuration par défaut de l'application, et non
  `Start.LocalSettings` : ignoré si Laurux est lancé avec `-c`), musique, deux `Chainage` successifs
  affectés à la même variable `ch` (le premier n'est plus référencé : son maintien actif est à
  confirmer), types date, `Entete`, puis `SELECT * FROM Fiches_Lcr` pour `Nb` (jamais lu).
- **`Form_Open()`** [événement] [nature : mixte] : tri par date, `Tris`, `Deb2`, `Total` (deux fois,
  `Deb2` l'appelant déjà), puis remplit `BQ`/`BQ2` avec les banques de `Fiches_Banques`.
- **`Entete()`** [portée : réductible] [GUI] : titres (l'en-tête `ACC` affiche « Entrée »).

### Liste, tri, recherche, totaux

- **`CO/Inte/DA/NUM/MNT/ACC/BAQ_GotFocus`**, **`DAE_GotFocus`**, **`*_LostFocus`**,
  **`DAE_KeyPress`** [événements] : identiques à [`Attribution`](../Attribution.class/architecture.md)
  (même défaut de transformation du motif à la 8ᵉ frappe) ; le tri par montant utilise
  `CAST(montant As DECIMAL(12, 2))` (non portable SQLite : `CAST … AS DECIMAL` est accepté par
  SQLite avec une affinité numérique, à confirmer).
- **`ColLcr_Data(Row, Column)`** [événement] : comme `Attribution` (une requête `Fiches_Banques` par
  cellule de la colonne banque) ; colonne 7 = `codeentree`.
- **`Tris()`** [portée : réductible] : 10 colonnes, la 9ᵉ (`lind`) à 1 pixel.
- **`Deb()`** [portée : réductible] [nature : mixte] : sélection par banque (`Left$(BQ.Text)`, 1
  caractère) et code entrée (`0` si vide) avec `bordereau = 0` ; `Enrg = Count(*)` ; `Total`.
  Sans banque : toutes les LCR hors bordereau (y compris non attribuées et écartées).
- **`Deb2()`** [portée : réductible] : `banque <> 0 and ecartee <> 1 and bordereau = 0` (ou banque
  choisie), `Enrg = Count(*)`, `Total`.
- **`Deb3()`** [portée : réductible] [nature : mixte] : liste servant à la génération : banque,
  `bordereau = 0`, code entrée `Entree3` et, si `CheckBox1`, échéances `Ech1`…`Ech2`
  **concaténées sans guillemets** (`datech >= 2026-10-25`) → filtre faux. Ne filtre **pas**
  `ecartee` : des LCR écartées peuvent entrer dans le bordereau.
- **`Deb4()`** [portée : réductible] : recherche par échéance, `And`/`Or` sans parenthèses.
- **`Total()`** [portée : réductible] (CC 9) : parcourt la grille (`Try ColLcr.MoveTo`) jusqu'à
  `Enrg` lignes, cumule la colonne montant (`Utils.cpoint`) → `Nb2`, `Mt2`. Correct tant que `Enrg`
  est le nombre de lignes de la grille (cas de `Deb`, `Deb2`, `Deb3`) ; dans `Deb4`, la requête de
  comptage partage le défaut `And`/`Or`.
- **`BQ_Click()`** [événement] : `CleanChamps`, `Entete`, `Deb`.
- **`Entree_click()`** [événement] : exige une banque (message, remise à vide via
  `ControleCombobox` pour éviter la réentrance) puis `Deb`.
- **`N_click()`, `A_click()`** : aucun contrôle `N`/`A` dans `Preparation.form` (`unused`) → code
  mort (copie d'`Attribution`).
- **`Refresh()`** [portée : réductible] : `form_Open()`.

### Fiche et marquage

- **`ColLcr_MouseUp()`** [événement] [nature : GUI] : clic gauche → `CleanChamps` + `Maj_Zones` ;
  clic droit → bascule la colonne 9 entre `"False"` et `"*"`. La cellule est vide au départ :
  le premier clic droit écrit `"False"` (aucune marque), il faut un second clic pour marquer
  (comportement à confirmer : grille virtuelle alimentée par `_Data`).
- **`CleanChamps()`** [portée : réductible] : vide la fiche sous `ControleCombobox = False`.
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : `select * from Fiches_Lcr where lind =
  &1` ; `Entree2` = `EntreeItem.item(code entrée)` ; `iLind`.
- **`Button3_Click()`** [événement] [nature : mixte] : boucle `For x = 0 To Enrg` (une ligne au-delà
  de la dernière) ; pour chaque ligne marquée `"*"`, `UPdate Fiches_Lcr SET codeentree = <Entree2>`
  et démarquage ; si aucune ligne marquée, `UPdate` complet de la fiche (`code`, `nom`, dates,
  `montant`, `ecartee`, `banque`, `codeentree`) pour `iLind` (0 si aucune fiche → rien).
- **`Button2_Click()`** [événement] [nature : mixte] : `DELETE FROM Fiches_Lcr WHERE lind = …`
  **sans confirmation** (contrairement aux autres écrans) ; sans sélection, erreur non interceptée.
- **`Button7_Click()`** → **`compte()`** : `Button7` invisible → inatteignables ; **`compteman()`**
  (intitulé client, `Cbase.Table("TabComptes")`) appelé par `Cmpt_Lostfocus`.
- **`Cmpt_keypress()`**, **`Cmpt_Lostfocus()`** [événements du groupe `Cmpt`] : F1 → aide, Tag 1 →
  `compteman`.
- **`Button5_Click()`** : aucun contrôle `Button5` (`unused`) → code mort.
- **`Button1_Click()`** (aide), **`Button4_Click()`** (fermeture), **`CheckBox1_Click()`** (bascule
  `Panel2`, dates d'échéance), **`Button11_Click()`** (annule et ferme `Panel1`).

### Génération du bordereau

- **`Button10_Click()`** [événement] [nature : mixte] : référence de remise de la banque
  (`banques_ref`), `Entree3` = `Entree`, dates du jour (`Format$(Now, "dd.mm.yyy")` : `yyy` donne
  l'année sur 4 chiffres, vérifié), puis affiche `Panel1` si une banque est choisie. `ikey`, `b`
  inutilisés.
- **`Button12_Click()`** [événement] [nature : mixte] (CC 14) : si `Entree3` est renseigné :
  `Deb3()` ; `LOCK TABLES Fiches_Lcr, Fiches_Banques, Fiches_Bordereaux, <TabComptes> WRITE` ;
  numéro = dernier `lind` de `Fiches_Bordereaux` + 1 (1 si vide) ; boucle `MoveTo`/`$lind` (arrêt sur
  `lind` répété ou erreur) : pour chaque LCR, `UPdate Fiches_Lcr SET codeentree, bordereau` (sous
  `Try`, erreurs ignorées) et cumul du montant ; si au moins une LCR :
  `Insert into Fiches_Bordereaux (banque, codeentree, dateremise, refremise, datevaleur, ech1, ech2,
  bordereau, tot, etat) value (…)` avec **`banque = BQ.Text` et `codeentree = Entree3.Text`
  complets** (« 1 - Banque X », « 1- Escompte ») dans des colonnes `int(1)` : en MariaDB strict
  l'`INSERT` échoue **après** la mise à jour des LCR (aucune transaction) → LCR rattachées à un
  bordereau inexistant ; en mode non strict, troncature à `1` avec avertissement (cas de
  production à confirmer). `value` refusé par SQLite. `UNLOCK TABLES`, message avec le numéro.
  `Catch` : message, `UNLOCK`, fermeture du panneau. Variables `rLcr` réutilisée, `Bq3`, `codeentree`
  sans effet.

### Impression

- **`Button9_Click()`** → **`Imp_Lcr()`** [portée : réductible] [nature : mixte] (CC 16) : toutes les
  LCR `banque <> 0` (ou de la banque choisie), **y compris** écartées et déjà en bordereau, PDF
  `~/Lcr.pdf` (`CLcr` : `Entete`, `Level1A`, `Level2A`, `Lines`), pas d'en-tête de colonnes après un
  saut de page. `Filename = "~/Lcr.ps"` puis écrasé ; nombreuses locales inutilisées.

## État global utilisé

- `Settings` (défaut gb.settings) au lieu de `Start.LocalSettings` pour `Coul_fen` ;
  `Start.LocalSettings` (`/Coul/*`), `Start.Societe`, `Start.Son`, `Start.Musique`.
- `Utils.Base`/`Utils.rs1`, `Utils.db`, `Utils.convBool`, `Utils.cpoint`, `Utils.Cdate_Aff`,
  `Utils.Coulfd`, `Utils.FColr`, `Utils.Observers`, `Utils.ObsLstf`, `Cbase.Table` (`TabCli`,
  `TabComptes`), `EntreeItem`, `LDate`, `TextReg`, `Chainage`, `TriCpt`, `CLcr`, `Visualiseur`, `Doc`.
- Tables : `Fiches_Lcr`, `Fiches_Banques`, `Fiches_Bordereaux` (en dur), `Fiches_Cli`,
  `Fiches_Comptes`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button12_Click` : boucle `For` sur les lignes de la grille ou un `UPdate … WHERE` équivalent à
  `Deb3` (SQL modifié, dump identique), après décision sur PREPARATION-A01/A02.
- Supprimer le double `Total()` de `Form_Open` (SQL identique, `Total` ne fait pas de SQL).
- `ColLcr_Data` : cache des noms de banques et `Lcrtable` initialisé une fois.

### Commonalisation avec d'autres fichiers

- Copie d'[`Attribution`](../Attribution.class/architecture.md) : en-têtes, `DAE_KeyPress`, `Deb4`,
  `Total`, `ColLcr_Data`, `Maj_Zones`, `compteman`, `Imp_Lcr`, liste des banques → fonctions communes
  (module LCR de phase 3) appelées par les handlers inchangés.
- Boucle `MoveTo`/`$lind` partagée avec `Attribution.Button10_Click`.
- Comparaison avec les bordereaux de remise de chèques de la Compta
  ([`BordereauxC`](../../../Compta/Impressions/BordereauxC.class/architecture.md)) : même notion de
  bordereau (sélection, numérotation, impression) mais tables (`Fiches_BordereauxC`), cycle de vie
  (comptabilisation dans `Fiches_Mvt` côté chèques, fichier bancaire côté LCR) et numérotation
  différents : seule la numérotation « dernier + 1 » sous verrou pourrait être commune
  (`DB_Connection.LockIncrement`). Gain faible ; à décider en phase 3.

### Réduction de portée

- `Entete`, `Tris`, `Deb`, `Deb2`, `Deb3`, `Deb4`, `Total`, `Refresh`, `CleanChamps`, `Maj_Zones`,
  `compteman`, `Imp_Lcr` → `Private` ; `Nb`, `sDate`, `iLind`, `ControleCombobox` → `Private`
  (aucun usage externe, `grep -rn "Preparation\." .src`). `sCmpt`, `sdesg` : à supprimer.
  `Bsel`/`Bval` restent `Public` (`TriCpt`).

### Séparation traitement / GUI

- Extraire `GenereBordereau(banque, entree, dateremise, ref, datevaleur, ech1, ech2, linds[]) As
  Integer` de `Button12_Click`, `MajCodeEntree(linds[], code)` de `Button3_Click`, et les requêtes de
  `Deb*`/`Imp_Lcr`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Numéro de bordereau dérivé de l'`AUTO_INCREMENT` (`lind`) plutôt que « dernier + 1 » ; clé
  étrangère `Fiches_Lcr.bordereau` → `Fiches_Bordereaux`.
- `Fiches_Lcr.bordereau`/`banque` en `INT`, `montant` en `DECIMAL(12,2)` (le tri `CAST` deviendrait
  inutile).
