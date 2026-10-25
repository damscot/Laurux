# MyStyle — Architecture

> Source : `.src/Caisse/MyStyle.class`

## Vue d'ensemble

`MyStyle` est une classe utilitaire **`Create Static`** de dessin : elle fournit les constantes
d'état d'un bouton (`Normal` 0, `Disabled` 1, `HasFocus` 2, `Hovered` 4, `Active` 8) et
`DrawButton`, qui peint un bouton arrondi en dégradé avec l'API `Paint`. Son **seul utilisateur**
est [`ImageButton.View_Draw`](../ImageButton.class/architecture.md) (`ImageButton.class:94-98`).

Nature : **GUI** (dessin), sans état ni SQL.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Normal` | const | Public |  |  | 4 |
| `Disabled` | const | Public |  |  | 5 |
| `HasFocus` | const | Public |  |  | 6 |
| `Hovered` | const | Public |  |  | 7 |
| `Active` | const | Public |  |  | 8 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `DrawButton` | 10-47 | Public | 5 | 32 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`DrawButton(X, Y, Width, Height, Pressed, Flag, iColor = &HC6C6C6)`** [portée : nécessaire]
  [nature : GUI] (CC 5). Doit être appelée dans un contexte `Paint` actif (événement `Draw`).
  Dérive de `iColor` quatre teintes de même teinte/saturation (valeurs 127, 191, 198, 223, 255),
  réduit le rectangle de 2 pixels, trace un contour en dégradé (ordre inversé si `Pressed`), un
  liseré clair, puis remplit en dégradé. Si `Flag = 2` ou `Flag = 6` (focus, avec ou sans survol),
  ajoute un cadre de focus en `Color.SelectedBackground` éclairci, positionné en (2, 2) **sans
  tenir compte de `X`/`Y`** (toujours 0 chez l'appelant).
  ⚠️ Les états `Disabled` (1) et `Hovered` seul (4) ne modifient pas le rendu ; un bouton
  désactivé ayant le focus (`Flag` 3 ou 7) perd son cadre (MYSTYLE-A01).
- Constantes `Normal` et `Active` : jamais utilisées (`grep "MyStyle\.\(Normal\|Active\)"` vide).

## État global utilisé

- `Paint` (contexte de dessin courant), `Color.HSV`, `Color[…]`, `Color.Lighter`,
  `Color.SelectedBackground`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les constantes inutilisées `Normal` et `Active` et la ligne commentée
  (`Paint.AntiAlias`).
- `Dim iWidth, iHeight As Integer` et `Dim C1, C2, C3, C4 As Integer` : déclarations multiples
  correctes, à conserver.

### Commonalisation avec d'autres fichiers

- Classe à un seul utilisateur : intégrer `DrawButton` et les constantes dans
  [`ImageButton`](../ImageButton.class/architecture.md) (méthode et constantes privées), puis
  supprimer `MyStyle.class` (sans `.form` : rework, pas anomalie).

### Réduction de portée

- `DrawButton` reste `Public` tant que la classe existe (appel externe par `ImageButton`).

### Séparation traitement / GUI

- Le calcul des teintes (`Color.HSV`) pourrait être isolé en fonction pure, gain marginal.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès à la base.
