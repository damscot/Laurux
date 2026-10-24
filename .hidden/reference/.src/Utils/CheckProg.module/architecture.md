# CheckProg — Architecture

> Source : `.src/Utils/CheckProg.module`

## Vue d'ensemble

Module d'une fonction qui teste la présence d'un programme dans le `PATH` (`which`). Son seul
appelant, `Editeur.Prog_Email`, n'est lui-même appelé nulle part : le module est **mort de fait**.

Nature : **système** (shell + fichier temporaire).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Chk` | 3-18 | Public | 2 | 13 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Chk(sProg As String) As Boolean`** [portée : nécessaire tant que `Editeur.Prog_Email` existe]
  [nature : système]. `Shell "which " & sProg & " > ~/temp_prog" Wait`, relit et supprime le fichier,
  renvoie `True` si la sortie n'est pas vide. Effets de bord : fichier `~/temp_prog` créé puis
  supprimé (collision possible entre deux instances de Laurux). `sProg` est passé au shell sans
  échappement. La variable `bProg` est déclarée `String` (nom trompeur).

## État global utilisé

- `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Shell "which " & sProg Wait To sOut` ou `System.Find(sProg)` (à confirmer selon la version
  minimale de Gambas) : plus de fichier temporaire, même résultat.

### Commonalisation avec d'autres fichiers

- La même vérification serait utile à [Monip](../Monip.module/architecture.md) (`curl`), à
  [Syntheses](../Syntheses.module/architecture.md) (`pico2wave`) et à
  [Editeur](../../Gestion/Impressions/Editeur.module/architecture.md) (choix de l'éditeur).

### Réduction de portée

- Appelant unique `Editeur.Prog_Email`, lui-même sans appelant : si l'utilisateur confirme la
  suppression de `Prog_Email` (rework d'`Editeur`), `CheckProg` devient entièrement mort.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
