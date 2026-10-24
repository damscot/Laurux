# FAbout — Architecture

> Source : `.src/Communs/FAbout.class` (+ `FAbout.form`)

## Vue d'ensemble

`FAbout` est la fenêtre **« A propos de Laurux »** (menu « ? > Concernant Laurux »,
[`Fmenu.Menu23`](../Fmenu.class/architecture.md), auto-instance `Fabout.Show`). Elle affiche le nom
et la version de l'application, le SHA1 court et la branche de compilation (`Start.version_sha1`,
`Start.version_branch`, lus par `Start.Main` dans `sha1.txt`/`branch.txt`), et un panneau défilant
de remerciements (`Lic`) encadré de deux dégradés.

Nature globale : **GUI**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 3-27 | Public | 3 | 20 | 0 | méthode spéciale |
| `Button1_Click` | 30-34 | Public | 1 | 3 | 0 | handler GUI |
| `Temps_Timer` | 36-44 | Public | 2 | 6 | 0 | handler GUI |
| `Button2_Click` | 46-60 | Public | 2 | 12 | 0 | handler GUI |
| `Grad1_MouseDown` | 62-64 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [spéciale] [GUI]. Observateurs de replay, centrage ; `Version.Text = Application.Name
  & " v" & Application.Version` ; `Versionsha1.Text = Left$(version_sha1, 7) & " (branche: …)"` ;
  dessine deux images de dégradé blanc (opacité croissante pour `Grad1`, décroissante pour `Grad2`)
  par deux boucles identiques au sens près.
- **`Button1_Click()`** [handler] [GUI]. Ferme.
- **`Button2_Click()`** [handler] [GUI]. « Remerciements » : `Temps.Delay = 30` puis bascule la
  visibilité de `Lic`, `Grad1`, `Grad2`.
- **`Temps_Timer()`** [handler] [GUI]. Fait défiler `Lic` d'un pixel ; revient en haut en fin de
  défilement. Le `.form` déclare `Temps` **actif avec `Delay = 0`** : le minuteur tourne dès
  l'ouverture, avant tout clic, même si `Lic` est masqué (FABOUT-A01, à confirmer).
- **`Grad1_MouseDown()`** [handler] [GUI]. **Vide**. Nom de handler conservé (règle du PLAN) ; sans
  effet.

## État global utilisé

- `Start.version_sha1`, `Start.version_branch`, `Application.Name`, `Application.Version`.
- `Utils.Observers`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Les deux boucles de dégradé → helper privé `Degrade(hImage, bInverse) As Picture`.

### Commonalisation avec d'autres fichiers

- Le libellé « version (sha1, branche) » pourrait venir d'une fonction `Start.VersionComplete()`
  si d'autres écrans l'affichent (aucun autre usage trouvé par grep : à reconsidérer en phase 3).

### Réduction de portée

- Rien (fonction spéciale et handlers).

### Séparation traitement / GUI

- Sans objet (aucun traitement).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
