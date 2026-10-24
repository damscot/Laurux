# ComMail — Architecture

> Source : `.src/Gestion/Tables/ComMail.class`

## Vue d'ensemble

Écran de la **table des textes prédéfinis pour les courriels** (`Fiches_ComMail` : `numcom`
char(2) clé primaire, `intitule` mediumtext). Il a **deux modes**, selon l'argument obligatoire
`Org` du constructeur :
- **gestion** (`New Commail("")`, `Fmenu.Menu326_Click`, `Fmenu.class:2459`) : création,
  modification, suppression ;
- **choix** (`New Commail("F")`, `FClient.class:2372`, `ObjFacB.class:841` et `:856`) : le bouton
  Enregistrer devient « Choisir » ; il recopie le texte dans `Variables.sTexte` et ferme la
  fenêtre. `FClient` et `ObjFacB` utilisent ensuite ce texte comme corps du courriel.

Copie de [Comment](../Comment.class/architecture.md) (similarité 0,89) avec le nom de table en dur
(`Fiches_ComMail`, aucune clé `Cbase`), l'argument `Org` et le mode « Choisir ». En-tête erroné
(« Comment.class »).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `stexte` | var | Public |  | String | 27 |
| `sOrg` | var | Private |  | String | 28 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 30-44 | Public | 1 | 13 | 0 | méthode spéciale |
| `Form_Open` | 46-65 | Public | 7 | 17 | 0 | handler GUI |
| `Maj_Zones` | 67-77 | Public | 1 | 8 | 0 | portée réductible ? |
| `CleanChamps` | 79-84 | Public | 1 | 4 | 0 | portée réductible ? |
| `Refresh` | 86-91 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 93-116 | Public | 7 | 18 | 0 | handler GUI |
| `Btn_KeyPress` | 118-127 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 129-147 | Public | 5 | 12 | 0 | handler GUI |
| `Lib_GotFocus` | 157-161 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 163-173 | Public | 3 | 9 | 0 | portée réductible ? |
| `Button2_Click` | 175-203 | Public | 4 | 25 | 0 | portée réductible ? |
| `Button3_Click` | 205-209 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 211-215 | Public | 1 | 3 | 0 | portée réductible ? |
| `colcol_Click` | 217-221 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New(Org As String)`** [portée : nécessaire] [nature : GUI] : mémorise `Org` dans `sOrg`,
  centre, `Utils.Observers`, colonnes (code 60, intitulé 560), focus code.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_ComMail order by numcom`,
  affiche la première ligne de chaque texte ; si `sOrg` n'est pas `Null` (en Gambas, `""` est
  `Null`), libellé du bouton 2 = « Choisir ».
- **`Maj_Zones()`** [portée : réductible] [nature : mixte] : relit le texte de
  `Colcol.Current[0]` sans test `Available`.
- **`CleanChamps()`**, **`Refresh()`** [portée : réductible] [nature : GUI].
- **`Lib_KeyPress()`** [handler du groupe `Lib`] : Entrée/Tab sur le code → texte ; `Case 2`
  inatteignable (`Intitule` hors groupe) ; F1 → aide.
- **`Lib_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : toute touche sur le bouton 2 (tag 3) déclenche
  `Button2_Click` (enregistrement ou choix).
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 aide, 2 supprimer, 3 enregistrer/choisir, 4 ferme.
- **`Button1_Click()`** [portée : réductible] [nature : mixte] — suppression, sans son ni test de
  sélection : `DELETE FROM Fiches_ComMail WHERE numcom = &1` avec **`colcol.Current[0]`**
  (ligne 167). Pseudo-handler (bouton groupé).
- **`Button2_Click()`** [portée : réductible] [nature : mixte] — si le bouton n'est pas « Choisir » :
  `Utils.ReplaceLb`, `SELECT`, `INSERT` ou `Update … SET numcom = &1, intitule = &2 WHERE numcom = &1`,
  puis repositionnement ; `sKey = Colcol.Current.Key` (ligne 190) lève une erreur si aucun élément
  n'est sélectionné. En mode « Choisir » : `Variables.sTexte = intitule.text` (texte brut, sans
  `ReplaceLb`) puis fermeture. Le mode est déduit du **libellé du bouton** (`Button2.Text`).
- **`Button3_Click()`** [handler inactif] : `Me.Close()`, jamais levé (`Button3` est groupé dans
  `Btn`) : **code mort** (`handlers_inactifs`).
- **`Button4_Click()`** [portée : réductible] : `Doc.Open("Commentaires")` (page d'aide de Comment).
- **`colcol_Click()`** [handler] : `Maj_Zones` ; rejoué par `ReplayObserver` (`replay_dynamic`) :
  **reste `Public`**.

Variable **`stexte`** (`Public`, ligne 27) : jamais lue ni écrite (le texte choisi passe par
`Variables.sTexte`) : code mort.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.SetEditColor`, `Utils.ReplaceLb`.
- **`Variables.sTexte`** (écrit en mode choix ; lu par `FClient:2389` et `ObjFacB:662`, `:876`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Mode explicite : un booléen privé `$bChoix` positionné dans `_New` au lieu du test sur
  `Button2.Text` (même comportement).
- `Update … SET intitule = &2 WHERE numcom = &1` (SQL modifié, dump identique).
- Ajouter une clé `Cbase` (`TabComMail`) : changement de `Cbase.module`, hors schéma.

### Commonalisation avec d'autres fichiers

- Module partagé avec [Comment](../Comment.class/architecture.md) (voir sa section), puis socle
  « table code/libellé » de [Centrales](../Centrales.class/architecture.md).
- Le texte associé aux courriels par défaut est géré par [Tmail](../Tmail.class/architecture.md)
  (`Fiches_TxtMail`), lu par `ObjFacB` quand `Variables.sTexte` est vide.

### Réduction de portée

`Maj_Zones`, `CleanChamps`, `Refresh`, `Button1_Click`, `Button2_Click`, `Button4_Click` →
`Private` ; suppression de `stexte` et de `Button3_Click` (code mort). Le constructeur et
`colcol_Click` restent `Public`.

### Séparation traitement / GUI

`EnregistreTexte(sCode, sTexte)`, `SupprimeTexte(sCode)`, `LitTexte(sCode)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Fusion avec `Fiches_Commentaires` (même structure) via une colonne de type.
