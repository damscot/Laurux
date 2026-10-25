# EmailingCarte — Architecture

> Source : `.src/Gestion/Mails/EmailingCarte.class`

## Vue d'ensemble

`EmailingCarte` est l'écran d'**envoi groupé de courriels aux porteurs de cartes de fidélité**
(`Fiches_Carte`, via `Cbase.Table("TabCarte")`). Il est ouvert par `Fmenu.Menu240_Click`
(`EmailingCarte.ShowModal()`, auto-instance, sans paramètre).

C'est une copie simplifiée d'[`Emailing`](../Emailing.class/architecture.md) (2010) : pas de mode
SMS, pas de filtre par type ni par statut. Sélection des destinataires :
- **plage de codes de carte** `Client1`…`Client2` (`000001`…`999999` par défaut), grilles
  `Colcli`/`Colcli2` ;
- **ou plage de codes postaux** `Cp1`…`Cp2` (`CheckCp` remplace le panneau des codes par celui des
  codes postaux ; ici la plage **est** appliquée dans le SQL) ;
- **ordre** : `RadioButton1` (code) ou `RadioButton3` (code postal) ;
- **mode liste** (`Liste`) : saisie code par code dans la table de travail `Cli_Mailing`
  (la même que celle d'`Emailing`).

`Button2` envoie le message (sujet `TextBox1`, texte `sText`, pièce jointe `TextBox2`) à chaque
porteur par `EnvMail.Envoi`.

Nature globale : **mixte**, logique SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `TypeM` | var | Private |  | String | 27 |
| `FileN` | var | Private |  | String | 28 |
| `Tab2` | var | Private |  | String | 29 |
| `rCli` | var | Private |  | Result | 30 |
| `rCli2` | var | Private |  | Result | 31 |
| `son` | var | Private |  | Integer | 32 |
| `CoulZns` | var | Private |  | Integer | 33 |
| `CoulZnaf` | var | Private |  | Integer | 34 |
| `CoulFoc` | var | Private |  | Integer | 35 |
| `Clitable` | var | Private |  | New String[3] | 36 |
| `Sens` | var | Private |  | String | 37 |
| `Tri` | var | Private |  | String | 38 |
| `Piece` | var | Private |  | Boolean | 39 |
| `Adr_Mail` | var | Private |  | String | 40 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-69 | Public | 2 | 24 | 0 | méthode spéciale |
| `Form_Open` | 71-78 | Public | 6 | 6 | 0 | handler GUI |
| `CheckCp_Click` | 80-93 | Public | 3 | 12 | 0 | handler GUI |
| `Tris` | 97-107 | Public | 1 | 9 | 0 | portée réductible ? |
| `Tris2` | 109-119 | Public | 1 | 9 | 0 | portée réductible ? |
| `Colcli_Data` | 121-131 | Public | 3 | 8 | 0 | handler GUI |
| `Colcli2_Data` | 133-143 | Public | 3 | 8 | 0 | handler GUI |
| `Colcli_ColumnClick` | 145-154 | Public | 1 | 7 | 0 | handler GUI |
| `Colcli2_ColumnClick` | 156-165 | Public | 1 | 7 | 0 | handler GUI |
| `colinit` | 167-185 | Public | 4 | 17 | 0 | portée réductible ? |
| `AffClients` | 190-197 | Public | 1 | 6 | 0 | portée réductible ? |
| `AffClients2` | 202-209 | Public | 1 | 6 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 214-229 | Public | 2 | 13 | 0 | handler GUI |
| `ColCli_Click` | 234-247 | Public | 2 | 12 | 0 | handler GUI |
| `Cli_Man` | 252-279 | Public | 6 | 25 | 0 | portée réductible ? |
| `ColCli_KeyPress` | 284-305 | Public | 7 | 18 | 0 | handler GUI |
| `ToggleButton2_Click` | 310-325 | Public | 2 | 13 | 0 | handler GUI |
| `ColCli2_KeyPress` | 330-351 | Public | 7 | 18 | 0 | handler GUI |
| `ColCli2_Click` | 356-362 | Public | 1 | 5 | 0 | handler GUI |
| `Btn_Click` | 364-379 | Public | 4 | 10 | 0 | handler GUI |
| `Btn_KeyPress` | 381-388 | Public | 2 | 6 | 0 | handler GUI |
| `liste_Click` | 390-423 | Public | 2 | 30 | 0 | handler GUI |
| `ChkInput` | 425-433 | Public | 7 | 7 | 0 | portée réductible ? |
| `Etiq_KeyPress` | 435-505 | Public | 21 | 57 | 0 | handler GUI |
| `Button2_Click` | 507-585 | Public | 25 | 76 | 0 | portée réductible ? |
| `btnopen_Click` | 587-603 | Public | 4 | 15 | 0 | handler GUI |
| `OBS_GotFocus` | 605-615 | Public | 6 | 9 | 0 | handler GUI |
| `OBS_LostFocus` | 617-625 | Public | 4 | 7 | 0 | handler GUI |
| `SetObservers` | 627-639 | Public | 4 | 10 | 0 | portée réductible ? |
| `Button1_Click` | 641-645 | Public | 1 | 3 | 0 | handler GUI |
| `bstatut_Click` | 647-655 | Public | 2 | 7 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire] [nature : GUI]. Musique, couleurs (`Utils.FColr` ;
  `CoulZnaf` calculé mais inutilisé), **deux** appels à `Utils.Observers(Me)` (l. 55 et 67),
  `SetObservers(Me, Me)`, masque le panneau CP, valeurs par défaut des plages.
- **`Form_Open`** [GUI] : si `/Smtp`, `Port` ou `/Adrmail` est vide, `Message.Error` puis
  fermeture (`Port` sans `/` équivaut à `/Port`, vérifié).
- **`CheckCp_Click`** [GUI] : bascule entre le panneau des codes (`Panel1`) et celui des codes
  postaux (`Panel2`), affiche `RadioButton3`.

### Grilles de recherche

- **`Tris`**, **`Tris2`** [portée : réductible] [GUI] : colonnes « Code / Nom » (deux copies).
- **`Colcli_Data`**, **`Colcli2_Data`** [GUI] : affichage virtuel depuis `Utils.rs1` (colonnes
  `code`, `nom`).
- **`Colcli_ColumnClick`**, **`Colcli2_ColumnClick`** → **`colinit`** [portée : réductible] :
  inverse le sens, retrie par `code` ou `nom` ; ⚠️ appelle `AffClients` pour les deux grilles
  (même défaut qu'Emailing : pour `Colcli2`, c'est `colcli` qui est reconfigurée et reçoit le
  focus, EMAILINGCARTE-A05).
- **`AffClients`**, **`AffClients2`** [portée : réductible] [mixte] :
  `Utils.Base(col, "select * from " & Cbase.Table("TabCarte") & " order by <tri> <sens>")`.
- **`ToggleButton1_Click`**, **`ToggleButton2_Click`** [GUI] : ouvrent/ferment les grilles.
- **`ColCli_Click`** [GUI, rejeu dynamique] : code → `Client1` ; en mode liste, `Cli_Man`.
- **`ColCli2_Click`** [GUI, rejeu dynamique] : code → `Client2` (sans déplacement du focus).
- **`ColCli_KeyPress`**, **`ColCli2_KeyPress`** [GUI] : F1, Entrée, Échap/F2.

### Saisie et navigation

- **`Cli_Man`** [portée : réductible] [mixte] : vérifie le code dans `Fiches_Carte` ; en mode
  liste, `INSERT INTO Cli_Mailing (code)` (doublon → « Ce client a déjà été saisi ! »).
- **`liste_Click`** [mixte] : `DROP TABLE IF EXISTS Cli_Mailing`, puis en mode liste
  `CREATE TABLE Cli_Mailing (code Char(15) NOT NULL, PRIMARY KEY (code))` + `Engine()`. Table de
  travail partagée avec `Emailing` et entre postes (EMAILINGCARTE-A04).
- **`ChkInput`** [portée : réductible] [GUI] : filtre numérique appelé pour les tags 7/8, qu'aucun
  contrôle ne porte : **jamais effectif**.
- **`Etiq_KeyPress`** [GUI] (CC 21) : navigation `Client1` (tag 1), `Client2` (2), `Cp1` (5) ;
  F2 ouvre les grilles ; F1 aide. `Case 4` (aucun contrôle de tag 4 : pas de champ type dans ce
  formulaire), `Case 8` et `Case 7/8` sont inatteignables ; `Cp2` (tag 6) non traité.
- **`btnopen_Click`** [mixte] : choix du fichier, `FileN`, `TypeM = EnvMail.Extension(FileN)`,
  `TextBox2 = chemin complet` ; extension non reconnue → `Catch` « Impossible d'ouvrir ».
- **`Btn_Click`** / **`Btn_KeyPress`** [GUI] : groupe `Btn` (`Button2` tag 2, `Button3` tag 3) ;
  toute touche sur `Button2` lance l'envoi (EMAILINGCARTE-A03).
- **`Button1_Click`** [GUI] : aide `Doc.Open("Emailing")`.
- **`OBS_GotFocus`**, **`OBS_LostFocus`**, **`SetObservers`** [GUI] : coloration du champ actif
  (copie d'Emailing).
- **`bstatut_Click`** [portée : réductible selon `deps.py`] [GUI] : bascule `Statut.Visible`.
  `EmailingCarte.form` ne contient **ni** contrôle `bstatut` **ni** contrôle `Statut` : le handler
  n'est jamais levé (code inactif, vestige copié d'Emailing) et `Statut` y désigne
  l'**auto-instance du formulaire** [`Statut`](../../Tables/Statut.class/architecture.md)
  (référence réelle, compilée). Conformément à la décision du lot, la fonction est
  **préservée** ; sa suppression ou son rattachement à un contrôle relève de l'anomalie
  EMAILINGCARTE-A06 (la documentation de Statut, test STATUT-T04, suppose un bouton qui n'existe
  pas).

### Envoi

- **`Button2_Click`** [portée : réductible : appelé par `Btn_Click`/`Btn_KeyPress`] [nature :
  mixte] (CC 25). Exige sujet puis texte. Sélection :
  - sans liste ni CP : `SELECT * FROM Fiches_Carte WHERE code >= &1 and code <= &2 order by code`
    (ou `order by cd_ptl, code`) ;
  - CP : `WHERE cd_ptl >= &1 and cd_ptl <= &2 order by cd_ptl, code` (ou `order by cd_ptl`) ;
  - liste : `SELECT * FROM Cli_Mailing` puis relecture de chaque carte (`Try`), sans test
    `Available` sur `rcli2` (EMAILINGCARTE-A03).
  Pour chaque porteur : `Adr_Mail = email`, `piece = True` si `TextBox2` est rempli (jamais remis
  à `False`), affichage dans `Panel4` (laissé visible en fin de mode liste), puis
  `EnvMail.Envoi(…, TextBox2.Text, TypeM, FileN)` : même défaut de chemin que dans Emailing, la
  pièce jointe est introuvable et l'envoi s'arrête au premier porteur (EMAILINGCARTE-A02).
  Pas de `Wait 1` entre les envois (contrairement à Emailing). `Catch` : `Message.Error`.

## État global utilisé

- `Start.LocalSettings` : `/Coul/Znaff`, `/Coul/Focus`, `/Coul/Znss`, `/Soc<XX>/Coul_fen`,
  `/Smtp`, `Port`, `/Adrmail`.
- `Start.Son`, `Start.Musique`, `Start.Societe`.
- `Utils.db`, `Utils.rs1` (via `Utils.Base`), `Utils.FColr`, `Utils.Observers`.
- Auto-instance du formulaire `Statut` (`bstatut_Click`, jamais levé).
- Tables : `Fiches_Carte` (`Cbase`), table de travail `Cli_Mailing`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Button2_Click` : sélection en une fonction (critères → même SQL), boucle d'envoi commune.
- Fusionner `Tris`/`Tris2`, `AffClients`/`AffClients2` (paramètre grille) ; `colinit` inchangé.
- Supprimer les blocs `With Utils` inutiles, `CoulZnaf`, les branches `Case 4/7/8`
  inatteignables.

### Commonalisation avec d'autres fichiers

- [`Emailing`](../Emailing.class/architecture.md) et
  [`Eticli`](../../Etiquettes/Eticli.class/architecture.md) : même squelette (≈ 80 % du code).
  Proposition commune (EMAILING-006) : classe de sélection de destinataires paramétrée par la
  table (`TabCli` / `TabCarte`) et le préfixe de colonnes (`cli_` / aucun).
- `SetObservers` / `OBS_*` : helper commun (16 copies dans le projet).

### Réduction de portée

- `Tris`, `Tris2`, `colinit`, `AffClients`, `AffClients2`, `Cli_Man`, `ChkInput`, `Button2_Click`,
  `SetObservers` → `Private`. `bstatut_Click` reste en l'état (voir A06). Les handlers, dont
  `ColCli_Click` et `ColCli2_Click` appelés par le rejeu, restent `Public`.

### Séparation traitement / GUI

- `SelectionCartes(critères) As Result`, `AjouteListe(code) As Boolean`, `CreeListe()` /
  `SupprimeListe()` sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Table temporaire de session à la place de `Cli_Mailing` (voir Emailing) ; `Char(15)` alors que
  `Fiches_Carte.code` est `char(13)`.
- `Fiches_Carte.email` en `varchar(40)` : trop court pour de nombreuses adresses ; aucun
  indicateur de consentement (RGPD) pour les mailings.
