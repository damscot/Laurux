# Tleg — Architecture

> Source : `.src/Gestion/Tables/Tleg.class`

## Vue d'ensemble

Écran d'édition du **texte légal « Réserve de propriété »** imprimé sur les factures
(`Fiches_Tleg` : `lind` int auto-incrémenté clé primaire, `intitule` mediumtext ; une seule ligne
attendue). Ouvert par `Fmenu.class:1841` (`Tleg.Show()`). Le texte est lu par `ObjFac.class:215`
et `Facturergbl.class:580` (première ligne, sans `WHERE`) ; la table est verrouillée par
`Moulinage`, `ValidBR` et `Facturergbl`.

Squelette « texte unique » partagé à 91 % avec [Tmail](../Tmail.class/architecture.md) (texte des
courriels) et proche de [LibelFac](../LibelFac.class/architecture.md) (pied de facture). Contrôles :
une `TextArea` `Intitule` **sans groupe** et trois boutons du groupe `Btn` (tags 1 aide,
3 enregistrer, 4 quitter). En-tête erroné (« Comment.class », dont l'écran est une copie).

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-33 | Public | 1 | 4 | 0 | méthode spéciale |
| `Form_Open` | 35-42 | Public | 2 | 5 | 0 | handler GUI |
| `CleanChamps` | 44-48 | Public | 1 | 3 | 0 | portée réductible ? |
| `Refresh` | 50-55 | Public | 1 | 4 | 0 | portée réductible ? |
| `Lib_KeyPress` | 57-73 | Public | 6 | 13 | 0 | portée réductible ? |
| `Btn_KeyPress` | 75-84 | Public | 2 | 6 | 0 | handler GUI |
| `Btn_Click` | 86-101 | Public | 4 | 10 | 0 | handler GUI |
| `Lib_GotFocus` | 103-107 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button2_Click` | 109-124 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button3_Click` | 126-130 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 132-136 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : centre, `Utils.Observers`.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM <TabTleg>` sans `WHERE` ni tri ;
  affiche le texte de la **première ligne renvoyée**.
- **`CleanChamps()`** [portée : réductible] : vide le texte ; **jamais appelée** (code mort, `unused`).
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide puis `Form_Open`.
- **`Lib_KeyPress()`** et **`Lib_GotFocus()`** : handlers d'un groupe `Lib` **absent** du `.form`
  (aucun contrôle n'y appartient) : jamais levés, **code mort** (`unused`).
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : toute touche sur Enregistrer (tag 3) enregistre.
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 aide, 3 enregistrer, 4 fermeture.
- **`Button2_Click()`** [portée : réductible] [nature : mixte] — enregistrement : `Utils.ReplaceLb`
  (`"` → `''`, `&` → `et`) ; si le texte n'est pas vide, `SELECT … WHERE lind = &1` (1), puis
  `INSERT (intitule)` ou `Update … SET intitule = &2 WHERE lind = &1`, puis `Refresh`. Un texte
  vide n'est jamais enregistré (impossible d'effacer la mention). Si la ligne existante n'a pas
  `lind = 1` (table vidée puis recréée, ou base importée), chaque enregistrement **insère une
  nouvelle ligne** alors que l'écran et les lecteurs continuent d'afficher la première (anomalie
  A01, à confirmer sur les bases réelles). Pseudo-handler (bouton groupé).
- **`Button3_Click()`** [handler inactif] : `Me.Close()`, jamais levé (`Button3` est dans le groupe
  `Btn`) : **code mort** (`handlers_inactifs`).
- **`Button4_Click()`** [portée : réductible] : `Doc.Open("Commentaires")` (page d'aide de Comment).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ReplaceLb`, `Cbase.Table("TabTleg")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `CleanChamps`, `Lib_KeyPress`, `Lib_GotFocus`, `Button3_Click`.
- Lecture et écriture sur la même ligne (lecture `ORDER BY lind LIMIT 1` et écriture sur ce `lind`) :
  changement de comportement dans le cas A01, donc anomalie.

### Commonalisation avec d'autres fichiers

- [Tmail](../Tmail.class/architecture.md) : 61 lignes communes sur 67 ; [LibelFac](../LibelFac.class/architecture.md)
  suit le même principe (texte unique, table différente). Proposition : fonctions communes
  `LitTexteUnique(sTable, sChamp) As String` et `EcritTexteUnique(sTable, sChamp, sTexte)` (module
  du socle « tables de paramétrage » proposé dans [Centrales](../Centrales.class/architecture.md)),
  réutilisables par les lecteurs `ObjFac:215`, `ObjFac:221`, `Facturergbl:580`, `ObjFacB:663`.

### Réduction de portée

`Refresh`, `Button2_Click`, `Button4_Click` → `Private` (appels internes) ; `CleanChamps`,
`Lib_KeyPress`, `Lib_GotFocus`, `Button3_Click` supprimés.

### Séparation traitement / GUI

`EnregistreTleg(sTexte)` sans contrôle, appelée par `Button2_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Regrouper les textes uniques (`Fiches_Tleg`, `Fiches_TxtMail`, `Fiches_LibelFac`) dans
  `Fiches_Parametres` ou une table clé/valeur, avec une clé fixe.
