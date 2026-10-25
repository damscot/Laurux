# Sms — Architecture

> Source : `.src/Gestion/SMS/Sms.class`

## Vue d'ensemble

`Sms` est l'écran de **gestion des textes SMS prédéfinis** : table `Fiches_Sms` (`Cbase.Table("TabSms")`,
colonnes `numcom char(2)` clé primaire et `intitule text`, créée par `LauruxMaj.Maj341`). Les
textes sont ensuite choisis dans [`Gsm`](../Gsm.class/architecture.md) pour un envoi unitaire.

Ouvert par `Fmenu.Menu315_Click` (« Textes SMS », `Sms.Show()`, auto-instance ; menu masqué si
`/Soc<XX>/Sms = 0`).

C'est une copie de [`ComMail`](../../Tables/ComMail.class/architecture.md) (textes de courriel,
`Fiches_ComMail`, même structure) sans le mode « choix », elle-même dérivée de
[`Comment`](../../Tables/Comment.class/architecture.md) : l'en-tête indique encore
« Comment.class — Gestion des commentaires utilisés en facturation ». Différences avec ComMail :
`Cbase.Table("TabSms")` au lieu du nom en dur, `Catch` dans `Form_Open` (« La table des textes SMS
n'existe pas… » puis fermeture), aide `Doc.Open("Sms")`.

Nature : **mixte** (SQL dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 29-42 | Public | 1 | 12 | 0 | méthode spéciale |
| `Form_Open` | 44-68 | Public | 8 | 22 | 0 | handler GUI |
| `Maj_Zones` | 70-80 | Public | 1 | 8 | 0 | portée réductible ? |
| `CleanChamps` | 82-87 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 89-94 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 96-119 | Public | 7 | 18 | 0 | handler GUI |
| `Btn_KeyPress` | 121-130 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 132-150 | Public | 5 | 12 | 0 | handler GUI |
| `Lib_GotFocus` | 152-156 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 158-168 | Public | 3 | 9 | 0 | portée réductible ? |
| `Button2_Click` | 170-192 | Public | 3 | 20 | 0 | portée réductible ? |
| `Button3_Click` | 194-198 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 200-204 | Public | 1 | 3 | 0 | portée réductible ? |
| `colcol_Click` | 206-210 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [GUI] : centre, `Utils.Observers(Me)`, colonnes de `Colcol`
  (« code » / « Intitulé »), focus sur `numcom`.
- **`Form_Open`** [GUI, mixte] : `SELECT * FROM Fiches_Sms order by numcom` ; ajoute chaque code
  et la **première ligne** de l'intitulé (`Split(…, "\n")` + `Break`). `Catch` : son, message
  « La table des textes SMS n'existe pas... », fermeture. Rappelé par `Refresh`.
- **`Maj_Zones`** [portée : réductible] [mixte] : relit `Fiches_Sms` pour `Colcol.Current[0]` et
  remplit `numcom`/`intitule` **sans test `Available`** (SMS-A02).
- **`CleanChamps`** [portée : réductible] [GUI] : vide les deux champs.
- **`Refresh`** [portée : réductible] [GUI] : `Colcol.Clear` + `Form_Open()`.
- **`Lib_KeyPress`** [GUI] : groupe `Lib` = `Numcom` seul (tag 1) ; Entrée/Tab → focus sur
  `intitule` ; la branche `Case 2` (`Utils.ReplaceLb` puis focus `Button2`) est **inatteignable**
  (`Intitule` n'est pas dans le groupe) ; F1 → aide.
- **`Lib_GotFocus`** [GUI] : `Utils.SetEditColor(Me, Last)`.
- **`Btn_Click`** [GUI] : groupe `Btn` — tag 1 (`Button4`) aide, tag 2 (`Button1`) suppression,
  tag 3 (`Button2`) enregistrement, tag 4 (`Button3`) fermeture.
- **`Btn_KeyPress`** [GUI] : **toute touche** sur un bouton de tag 3 (`Button2`) enregistre
  (SMS-A03).
- **`Button1_Click`** [portée : réductible : bouton groupé] [mixte] : si `numcom` est rempli,
  confirmation puis `DELETE FROM Fiches_Sms WHERE numcom = &1` avec **`colcol.Current[0]`** (la
  ligne sélectionnée, pas le code saisi ; erreur si aucune sélection), `Refresh`, `CleanChamps`.
- **`Button2_Click`** [portée : réductible : bouton groupé] [mixte] : `Utils.ReplaceLb` sur
  l'intitulé ; si le code n'existe pas, `INSERT` ; sinon `Update … SET numcom = &1, intitule = &2
  WHERE numcom = &1` (réaffectation inutile de la clé) puis `sKey = Colcol.Current.Key` (erreur
  `Null` si aucune ligne n'est sélectionnée, après l'UPDATE déjà exécuté, SMS-A02) ; `Refresh`,
  `CleanChamps`, repositionnement sur `sKey`.
- **`Button3_Click`** [portée : réductible] — **handler inactif** (`Button3` est dans le groupe
  `Btn` : seul `Btn_Click` est levé, tag 4 → `Me.Close`) : code mort.
- **`Button4_Click`** [portée : réductible : bouton groupé] [GUI] : aide `Doc.Open("Sms")`.
- **`colcol_Click`** [GUI, rejeu dynamique] : `Maj_Zones()`.

## État global utilisé

- `Start.Son` (initialiseur), `Utils.db`, `Utils.Observers`, `Utils.ReplaceLb`,
  `Utils.SetEditColor`, `Cbase.Table("TabSms")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Update … SET intitule = &2 WHERE numcom = &1` (sans réaffecter la clé : SQL modifié, dump
  identique), comme proposé pour ComMail (COMMAIL-003).
- Corriger l'en-tête (« Comment.class » → Sms, textes SMS).

### Commonalisation avec d'autres fichiers

- [`ComMail`](../../Tables/ComMail.class/architecture.md) et
  [`Comment`](../../Tables/Comment.class/architecture.md) : même écran sur une table code/texte.
  Le module partagé proposé par COMMENT-005 / COMMAIL-004 (`Charger`, `Lire`, `Enregistrer`,
  `Supprimer`) doit prendre la table en paramètre pour servir aussi à `Fiches_Sms`.
- [`Gsm`](../Gsm.class/architecture.md) relit `Fiches_Sms` (`ToggleButton4_Click`,
  `Colcol_Click`) avec le même idiome de première ligne : même helper de lecture.

### Réduction de portée

- `Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button4_Click` →
  `Private` (aucun appelant externe ; les trois boutons sont groupés, leurs `_Click` ne sont
  jamais levés par Gambas). `colcol_Click` reste `Public` (rejeu).

### Séparation traitement / GUI

- `EnregistreTexte(code, texte)`, `SupprimeTexte(code)`, `LitTexte(code) As String` sans
  contrôles (ou via le module partagé).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Sms` et `Fiches_ComMail` ont la même structure (`numcom char(2)`, `intitule`) : une
  table unique de textes typés (`type` = mail/sms/commentaire) supprimerait la duplication.
- `numcom char(2)` limite à 100 textes numériques ; aucune contrainte de longueur SMS (160).
