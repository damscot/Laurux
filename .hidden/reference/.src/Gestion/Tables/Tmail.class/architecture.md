# Tmail — Architecture

> Source : `.src/Gestion/Tables/Tmail.class`

## Vue d'ensemble

Écran d'édition du **texte par défaut des courriels de facturation** (`Fiches_TxtMail` via
`Cbase.Table("TabTmail")` : `lind` auto-incrémenté, `intitule` mediumtext ; une seule ligne
attendue, absente de `Laurux01.sql`). Ouvert par `Fmenu.class:2092` (`Tmail.Show()`). Le texte
est lu par `ObjFacB.class:663` et `:877` quand aucun texte prédéfini n'a été choisi dans
[ComMail](../ComMail.class/architecture.md) (`Variables.sTexte` vide).

Copie de [Tleg](../Tleg.class/architecture.md) (61 lignes communes sur 67) : seuls changent la clé
`Cbase`, la page d'aide (`TxtMail`), l'en-tête (correct ici) et un `Try` autour du `SELECT`
d'enregistrement.

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
| `Button2_Click` | 109-124 | Public | 6 | 13 | 0 | portée réductible ? |
| `Button3_Click` | 126-130 | Public | 1 | 3 | 0 | portée réductible ? |
| `Button4_Click` | 132-136 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : centre, `Utils.Observers`.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM <TabTmail>` sans `WHERE` ; affiche
  la première ligne.
- **`CleanChamps()`** [portée : réductible] : jamais appelée (code mort, `unused`).
- **`Refresh()`** [portée : réductible] [nature : GUI] : vide puis `Form_Open`.
- **`Lib_KeyPress()`** / **`Lib_GotFocus()`** : groupe `Lib` absent du `.form`, jamais levés :
  **code mort** (`unused`).
- **`Btn_KeyPress()`** [handler du groupe `Btn`] : toute touche sur Enregistrer enregistre.
- **`Btn_Click()`** [handler du groupe `Btn`] : 1 aide, 3 enregistrer, 4 fermeture.
- **`Button2_Click()`** [portée : réductible] [nature : mixte] : `Utils.ReplaceLb` ; si texte non
  vide, `Try SELECT … WHERE lind = &1` (1) ; en cas d'erreur **ou** d'absence de ligne, `INSERT` ;
  sinon `Update … SET intitule = &2 WHERE lind = &1`. Même défaut que Tleg si la ligne existante
  n'a pas `lind = 1` (insertions invisibles). Pseudo-handler (bouton groupé).
- **`Button3_Click()`** [handler inactif] : `Me.Close()`, jamais levé (`Button3` groupé dans `Btn`) :
  **code mort** (`handlers_inactifs`).
- **`Button4_Click()`** [portée : réductible] : `Doc.Open("TxtMail")`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ReplaceLb`, `Cbase.Table("TabTmail")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `CleanChamps`, `Lib_KeyPress`, `Lib_GotFocus`, `Button3_Click` ; le `Try` du `SELECT`
  masque une erreur SQL en la transformant en `INSERT` (à garder tel quel tant que A01 n'est pas
  validée).

### Commonalisation avec d'autres fichiers

- Fonctions « texte unique » communes avec [Tleg](../Tleg.class/architecture.md) et
  [LibelFac](../LibelFac.class/architecture.md) (voir Tleg), réutilisables par `ObjFacB:663`, `:877`.

### Réduction de portée

`Refresh`, `Button2_Click`, `Button4_Click` → `Private` ; `CleanChamps`, `Lib_KeyPress`,
`Lib_GotFocus`, `Button3_Click` supprimés.

### Séparation traitement / GUI

`EnregistreTmail(sTexte)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Voir Tleg : regrouper les textes uniques dans une table clé/valeur.
