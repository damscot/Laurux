# Attribution — Architecture

> Source : `.src/Gestion/Lcr/Attribution.class`

## Vue d'ensemble

Écran **« Attribution banques »** (menu Gestion › LCR, `Fmenu.MenuAbq_Click`), deuxième étape de la
chaîne LCR (voir [`Lcr`](../Lcr.class/architecture.md)) : il affecte une banque de remise
(`Fiches_Lcr.banque`, code 1 à 9 de [`Banque`](../Banque.class/architecture.md)) aux LCR non
écartées qui ne sont pas encore dans un bordereau.

- Radios `N` (non attribuées, défaut) / `A` (attribuées, éventuellement filtrées par la banque `BQ`).
- Grille virtuelle `ColLcr` (`Utils.Base` + `ColLcr_Data`, 9 colonnes dont `lind`), tri par les
  en-têtes, recherche par échéance en tapant dans l'en-tête `DAE`.
- Totaux `Nb2` (nombre) et `Mt2` (montant) calculés par `Total()` en parcourant la grille.
- Fiche (onglet) : modification de la LCR, y compris sa banque (`BQ2`), suppression.
- **Attribution en masse** (`Button10`) : la banque choisie dans `BQ` est écrite sur toutes les LCR
  non attribuées, non écartées, hors bordereau.
- Impression de la liste (PDF `~/Lcr.pdf`, `CLcr.Level1A/Level2A`).

L'écran n'appelle **pas** `Utils.Observers(Me)` : il n'est pas rejouable en l'état.

Nature : écran **mixte**. Aucune écriture comptable, aucun fichier bancaire.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 28 |
| `sel` | var | Private |  | String | 29 |
| `Lcrtable` | var | Private |  | New String[9] | 30 |
| `B` | var | Private |  | Integer | 31 |
| `son` | var | Private |  | Integer | 32 |
| `sKey` | var | Private |  | String | 33 |
| `CoulZns` | var | Private |  | Integer | 34 |
| `CoulZnaf` | var | Private |  | Integer | 35 |
| `Coulfc` | var | Private |  | Integer | 36 |
| `Coulfond` | var | Private |  | New String[] | 37 |
| `Dte1` | var | Private |  | Integer | 38 |
| `Type` | var | Private |  | String | 39 |
| `Bsel` | var | Public |  | Boolean | 40 |
| `Bval` | var | Public |  | String | 41 |
| `sCmpt` | var | Public |  | String | 42 |
| `sdesg` | var | Public |  | String | 43 |
| `PosY` | var | Private |  | Integer | 44 |
| `rBq` | var | Private |  | Result | 45 |
| `Nb` | var | Public |  | Integer | 46 |
| `sDate` | var | Public |  | Boolean | 47 |
| `iLind` | var | Public |  | Integer | 48 |
| `Enrg` | var | Private |  | Integer | 49 |
| `pdf` | var | Private |  | CLcr | 50 |
| `der` | var | Private |  | Result | 51 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 53-82 | Public | 3 | 27 | 0 | méthode spéciale |
| `Form_Open` | 84-106 | Public | 7 | 20 | 0 | handler GUI |
| `Entete` | 108-120 | Public | 1 | 11 | 0 | portée réductible ? |
| `CO_GotFocus` | 122-131 | Public | 1 | 8 | 0 | handler GUI |
| `Co_LostFocus` | 133-137 | Public | 1 | 3 | 0 | handler GUI |
| `Inte_GotFocus` | 139-148 | Public | 1 | 8 | 0 | handler GUI |
| `Inte_LostFocus` | 150-154 | Public | 1 | 3 | 0 | handler GUI |
| `DA_GotFocus` | 156-165 | Public | 1 | 8 | 0 | handler GUI |
| `DA_LostFocus` | 167-171 | Public | 1 | 3 | 0 | handler GUI |
| `DAE_GotFocus` | 173-183 | Public | 1 | 9 | 0 | handler GUI |
| `DAE_KeyPress` | 185-204 | Public | 4 | 18 | 0 | handler GUI |
| `DAE_LostFocus` | 206-211 | Public | 1 | 4 | 0 | handler GUI |
| `NUM_GotFocus` | 213-222 | Public | 1 | 8 | 0 | handler GUI |
| `NUM_LostFocus` | 224-228 | Public | 1 | 3 | 0 | handler GUI |
| `MNT_GotFocus` | 230-239 | Public | 1 | 8 | 0 | handler GUI |
| `MNT_LostFocus` | 241-245 | Public | 1 | 3 | 0 | handler GUI |
| `ACC_LostFocus` | 247-251 | Public | 1 | 3 | 0 | handler GUI |
| `ACC_GotFocus` | 253-262 | Public | 1 | 8 | 0 | handler GUI |
| `BAQ_LostFocus` | 264-268 | Public | 1 | 3 | 0 | handler GUI |
| `BAQ_GotFocus` | 270-279 | Public | 1 | 8 | 0 | handler GUI |
| `ColLcr_Data` | 281-322 | Public | 11 | 40 | 0 | handler GUI |
| `Tris` | 324-338 | Public | 1 | 13 | 0 | portée réductible ? |
| `Deb` | 340-351 | Public | 2 | 9 | 0 | portée réductible ? |
| `Deb2` | 353-370 | Public | 4 | 16 | 0 | portée réductible ? |
| `Deb3` | 372-379 | Public | 3 | 6 | 0 | portée réductible ? |
| `Deb4` | 381-388 | Public | 3 | 6 | 0 | portée réductible ? |
| `Total` | 390-424 | Public | 8 | 31 | 0 | portée réductible ? |
| `N_click` | 426-431 | Public | 1 | 4 | 0 | handler GUI |
| `A_click` | 433-438 | Public | 1 | 4 | 0 | handler GUI |
| `BQ_Click` | 440-446 | Public | 1 | 5 | 0 | handler GUI |
| `Refresh` | 448-452 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 454-458 | Public | 1 | 3 | 0 | handler GUI |
| `ColLcr_Click` | 460-469 | Public | 3 | 8 | 0 | handler GUI |
| `CleanChamps` | 471-482 | Public | 1 | 10 | 0 | portée réductible ? |
| `Maj_Zones` | 484-506 | Public | 4 | 20 | 0 | portée réductible ? |
| `Button10_Click` | 511-541 | Public | 7 | 28 | 0 | handler GUI |
| `Button3_Click` | 546-555 | Public | 2 | 7 | 0 | handler GUI |
| `Button2_Click` | 560-573 | Public | 3 | 12 | 0 | handler GUI |
| `Button1_Click` | 578-582 | Public | 1 | 3 | 0 | handler GUI |
| `Button5_Click` | 584-588 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button7_Click` | 590-594 | Public | 1 | 3 | 0 | handler GUI |
| `compte` | 599-611 | Public | 2 | 10 | 0 | portée réductible ? |
| `compteman` | 616-623 | Public | 2 | 5 | 0 | portée réductible ? |
| `Cmpt_keypress` | 625-632 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_Lostfocus` | 634-644 | Public | 3 | 8 | 0 | handler GUI |
| `Imp_Lcr` | 646-705 | Public | 19 | 57 | 0 | portée réductible ? |
| `Button9_Click` | 707-715 | Public | 6 | 7 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte] : couleurs, fond, musique, regex
  et types des zones, `Chainage`, `Entete()`, puis `SELECT * FROM Fiches_Lcr` pour renseigner
  `Nb = rBq.count` — **jamais utilisé** (lecture complète de la table pour rien).
- **`Form_Open()`** [événement] [nature : mixte] : tri par date, `Tris`, `Deb2`, puis remplit `BQ`
  et `BQ2` (ligne vide + « code - nom » de `Fiches_Banques`).
- **`Entete()`** [portée : réductible] [GUI] : titres des en-têtes, `sel = ""`. L'en-tête `ACC`
  (colonne `acceptee`) est intitulé « Type ».

### Liste, tri, totaux

- **`CO/Inte/DA/NUM/MNT/ACC/BAQ_GotFocus`** [événements] : `sel = ""`, `sDate = False`, colonne de
  tri, `Tris`, `Deb2`. **`DAE_GotFocus`** : `sDate = True`, tri par échéance, en-tête vidé.
  **`*_LostFocus`** : `Utils.ObsLstf` (`DAE` remet son titre).
- **`DAE_KeyPress()`** [événement] [nature : mixte] : accumule les chiffres tapés dans `sel` ; à 4
  caractères (`jjmm`) → motif `%-mm-jj` puis `Deb4()` ; à 8 caractères → motif `aa-mm-jj`… mais
  `sel` a déjà été transformé à 4 caractères (7 caractères + 1 frappe = 8) : le second motif est
  construit sur une chaîne déjà transformée (résultat à confirmer en phase 2). Retour arrière :
  remise à zéro.
- **`ColLcr_Data(Row, Column)`** [événement] [nature : mixte] : lit `Utils.rs1` ; colonne banque :
  **une requête `Fiches_Banques` par cellule affichée** pour ajouter le nom (« 1 - Banque ») ;
  `0` → vide ; acceptée `1` → `X`.
- **`Tris()`** [portée : réductible] [GUI] : 9 colonnes.
- **`Deb()`** [portée : réductible] [nature : mixte] : liste utilisée par l'attribution :
  `banque = 0 and ecartee <> 1 and bordereau = 0 order by lind, 1`, avec le filtre `like "%sel%"`
  sur la colonne de tri si `sDate`. `Enrg = 0`, n'appelle pas `Total`.
- **`Deb2()`** [portée : réductible] [nature : mixte] : `N` → `banque = 0 and ecartee = 0 and
  bordereau = 0` ; `A` sans banque → `banque <> 0 and ecartee <> 1 and bordereau = 0` et
  `Enrg = Count(*)` avec un filtre **supplémentaire** `acceptee <> 1` (incohérent avec la liste) ;
  `A` avec banque → `banque = <code>` et `Enrg = Count(*)` (requête de comptage avec `order by`).
  Puis `Total()`.
- **`Deb3()`** : variante descendante, **sans appelant** (`unused`) → code mort.
- **`Deb4()`** [portée : réductible] [nature : mixte] : recherche par échéance ; la condition
  `… and ecartee <> 1 or banque = 0 and … like …` mélange `And`/`Or` sans parenthèses : la première
  partie ne porte pas le filtre `like`. `Enrg = 0`.
- **`Total()`** [portée : réductible] [nature : mixte] (CC 8) : parcourt la grille par
  `ColLcr.MoveTo(ikey, 0)` et **s'arrête dès que `ikey = Enrg`**. `Enrg` valant 0 en mode `N`, après
  `Deb4` et `Deb`, les totaux affichés sont **toujours 0** dans ces cas ; en mode `A` sans banque,
  `Enrg` (filtre `acceptee <> 1`) peut être inférieur au nombre de lignes → total partiel.
  `If Not Error` teste l'état d'un `Try` antérieur (le `MoveTo` n'est pas sous `Try`). `Break`
  suivi d'un `Enrg = 0` inatteignable ; `Dim Nb` local masque le membre `Public Nb`.
- **`N_click()`, `A_click()`** [événements des radios `N`/`A`] : `Entete`, `Deb2`.
- **`BQ_Click()`** [événement] : recopie la banque dans `BQ2`, `Entete`, `Deb2`.
- **`Refresh()`** [portée : réductible] : `form_Open()`.

### Fiche

- **`ColLcr_Click()`** [événement, `replay_dynamic` : doit rester `Public`] : `CleanChamps`,
  `Maj_Zones` ; `Catch` → focus.
- **`CleanChamps()`** [portée : réductible] [GUI].
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : `select * from Fiches_Lcr where lind
  = &1`, remplit la fiche, `BQ2` depuis la colonne banque, `iLind`.
- **`Button3_Click()`** [événement] [nature : mixte] : `UPdate Fiches_Lcr SET code, nom, date,
  datech, montant, ecartee, banque = Left$(BQ2.Text, 1) or "0" where lind = iLind`. Sans fiche
  sélectionnée, `iLind = 0` → aucune ligne modifiée, aucun message.
- **`Button2_Click()`** [événement] [nature : mixte] : confirmation, `DELETE FROM Fiches_Lcr WHERE
  lind = &1` ; sans sélection, erreur non interceptée.
- **`Button7_Click()`** → **`compte()`** → **`compteman()`** : recherche de compte client par
  `TriCpt` ; `Button7` est **invisible** (`Visible = False` dans le `.form`, jamais rendu visible) :
  chaîne inatteignable, sauf `compteman` appelé aussi par `Cmpt_Lostfocus`.
- **`Cmpt_keypress()`** (F1 → aide), **`Cmpt_Lostfocus()`** (Tag 1 → `compteman`) [événements du
  groupe `Cmpt`].
- **`Button5_Click()`** : aucun contrôle `Button5` dans `Attribution.form` (`unused`) → code mort.
- **`Button1_Click()`** (`Doc.Open("LCR")`), **`Button4_Click()`** (fermeture).

### Attribution en masse

- **`Button10_Click()`** [événement] [nature : mixte] : exige une banque dans `BQ` ; confirmation ;
  `Deb()` (liste des LCR attribuables, filtrée par échéance si `sDate`), `LOCK TABLES Fiches_Lcr
  WRITE, Fiches_Banques WRITE` (neutralisé sous SQLite), puis boucle `Repeat` :
  `ColLcr.MoveTo(ikey, 0)`, arrêt quand le `lind` de la ligne courante est égal au précédent (la
  fin repose sur le fait que `MoveTo` au-delà de la dernière ligne laisse la ligne courante
  inchangée — à confirmer en phase 2), sinon `UPdate Fiches_Lcr SET banque = <code> where lind =
  …`. `b` n'est jamais modifié. `UNLOCK TABLES`, `Refresh`. Grille vide : `ColLcr[-1, 8]` → `Catch`
  (message d'erreur, `UNLOCK`). Une requête par LCR, sans transaction.

### Impression

- **`Button9_Click()`** [événement] : libellé `Type` selon `N`/`A`/`BQ`, message, `Imp_Lcr()`.
- **`Imp_Lcr()`** [portée : réductible] [nature : mixte] (CC 19, max) : sélection propre
  (`banque = 0`, `banque <> 0` ou `banque = <code>`, **sans** les filtres `ecartee`/`bordereau` de la
  grille), PDF `~/Lcr.pdf` (`CLcr` : `Entete(Type)`, `Level1A`, `Level2A`, `Lines`, `BasPage`), saut
  de page à 268 mm avec en-tête. `PosY += 4` seulement si le client existe ; sinon l'adresse de la
  LCR précédente sert au calcul. `Posx` inutilisé.

## État global utilisé

- `Start.LocalSettings` (`/Coul/*`, `/Soc<XX>/Coul_fen`), `Start.Societe`, `Start.Son`,
  `Start.Musique`.
- `Utils.Base`/`Utils.rs1`, `Utils.db`, `Utils.convBool`, `Utils.cpoint`, `Utils.Coulfd`,
  `Utils.FColr`, `Utils.ObsLstf`, `Cbase.Table` (`TabCli`, `TabComptes`), `LDate`, `TextReg`,
  `Chainage`, `TriCpt`, `CLcr`, `Visualiseur.Prog`, `Doc.Open`.
- Tables : `Fiches_Lcr`, `Fiches_Banques` (en dur), `Fiches_Cli`, `Fiches_Comptes` (via `Cbase`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Total()` : calculer nombre et montant par une requête `SELECT COUNT(*), SUM(…)` alignée sur la
  requête de la grille (change les valeurs affichées → anomalie ATTRIBUTION-A01) ; à comportement
  constant, seule la suppression du code inatteignable est possible.
- `Button10_Click` : boucle `For i = 0 To ColLcr.Rows.Count - 1` au lieu de la détection du `lind`
  répété (même SQL, même résultat si `MoveTo` se comporte comme supposé — à vérifier en phase 2), ou
  un seul `UPdate … WHERE banque = 0 AND ecartee <> 1 AND bordereau = 0` (SQL modifié, dump
  identique hors filtre `sDate`).
- `ColLcr_Data` : mettre en cache les noms de banques (une requête au lieu d'une par cellule ;
  SQL modifié, affichage identique).

### Commonalisation avec d'autres fichiers

- Copie quasi conforme de [`Preparation`](../Preparation.class/architecture.md) (en-têtes, `Total`,
  `Deb4`, `DAE_KeyPress`, `ColLcr_Data`, `Maj_Zones`, `compte`, `compteman`, `Imp_Lcr`) et de
  [`Lcr`](../Lcr.class/architecture.md) : fonctions communes à placer dans un module LCR (phase 3),
  les handlers restant dans chaque écran.
- Liste « code - nom » des banques (`Form_Open`) : commune avec `Glcr`, `Preparation`.
- Attribution en masse : même boucle `MoveTo`/`$lind` que `Preparation.Button12_Click`.

### Réduction de portée

- `Entete`, `Tris`, `Deb`, `Deb2`, `Deb4`, `Total`, `Refresh`, `CleanChamps`, `Maj_Zones`, `compte`,
  `compteman`, `Imp_Lcr` → `Private` ; `Nb`, `sDate`, `iLind` → `Private` (aucun usage externe,
  vérifié par `grep -rn "Attribution\." .src`).
- `sCmpt`, `sdesg` : jamais utilisés → suppression. `Bsel`, `Bval` restent `Public` (`TriCpt`).

### Séparation traitement / GUI

- Extraire `AttribueBanque(banque, linds[])`, `MajLcr(…)`, `SupprimeLcr(lind)` et les requêtes de
  `Deb*`/`Imp_Lcr` en fonctions sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index sur `Fiches_Lcr (banque, bordereau, ecartee)` pour les listes ; `banque`/`bordereau` en
  `INT`.
- Vue ou jointure `Fiches_Lcr` ⨝ `Fiches_Banques` pour l'affichage du nom de banque.
