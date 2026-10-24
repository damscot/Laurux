# LibelFac — Architecture

> Source : `.src/Gestion/Tables/LibelFac.class`

## Vue d'ensemble

Écran d'édition du **texte de bas de facture** (`Fiches_LibelFac` : `mind` bigint
auto-incrémenté, `txtfac` varchar(250) ; une ligne `"\n"` dans `Laurux01.sql`). Ouvert par
`Fmenu.class:1320` (`LibelFac.Show`). Le texte est lu par `ObjFac.class:221` (première ligne) et
la table est verrouillée par `Facturergbl` et `Moulinage`.

Variante minimale du squelette « texte unique » de [Tleg](../Tleg.class/architecture.md) : une
`TextArea` `Txtbfac`, trois boutons du groupe `Btn` (tag 1 aide **désactivée**, 2 enregistrer,
3 quitter). Nom de table en dur (`Tab = "Fiches_LibelFac"`) alors que la clé
`Cbase.Table("TabLibelFac")` existe.

Nature : **GUI** avec SQL dans les handlers.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 28-35 | Public | 1 | 5 | 0 | méthode spéciale |
| `Form_Open` | 37-46 | Public | 2 | 7 | 0 | handler GUI |
| `Btn_Click` | 48-64 | Public | 4 | 9 | 0 | handler GUI |
| `Button2_Click` | 66-82 | Public | 3 | 14 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire] [nature : GUI] : `Utils.Observers`, `Music.Load` (aucun
  `Music.Play` dans le fichier : chargement inutile), centre.
- **`Form_Open()`** [handler] [nature : mixte] : `SELECT * FROM Fiches_LibelFac` ; affiche `txtfac`
  de la première ligne.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 1 sans effet (appel d'aide commenté), 2
  `Button2_Click`, 3 fermeture.
- **`Button2_Click()`** [portée : réductible] [nature : mixte] : `Utils.ReplaceLb` ; si le texte
  n'est pas vide, `SELECT *` puis `INSERT (txtfac)` si la table est vide, sinon
  `UPdate … SET txtfac = &1` **sans `WHERE`** (toutes les lignes reçoivent le texte, ce qui
  maintient la cohérence avec la lecture de la première ligne). Aucun retour visuel ni fermeture.
  Un texte de plus de 250 caractères est tronqué ou refusé selon le mode SQL (à confirmer).
  Pseudo-handler (`Button2` est groupé dans `Btn`).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.ReplaceLb`, `Start.Musique`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Cbase.Table("TabLibelFac")` au lieu du nom en dur ; supprimer `Music.Load` et la branche tag 1
  vide (comportement identique).

### Commonalisation avec d'autres fichiers

- Fonctions « texte unique » communes avec [Tleg](../Tleg.class/architecture.md) et
  [Tmail](../Tmail.class/architecture.md) ; le paramètre « nom du champ » couvre `txtfac`.

### Réduction de portée

`Button2_Click` → `Private` (appelé seulement par `Btn_Click`).

### Séparation traitement / GUI

`EnregistreLibelFac(sTexte)` sans contrôle.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `txtfac` varchar(250) : passer en `text` (la `TextArea` n'a pas de limite).
- Regrouper les textes uniques (voir Tleg).
