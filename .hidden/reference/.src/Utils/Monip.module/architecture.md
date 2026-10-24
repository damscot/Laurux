# Monip — Architecture

> Source : `.src/Utils/Monip.module`

## Vue d'ensemble

Module d'une fonction qui affiche dans une fenêtre construite à la volée l'**adresse IP publique**
(obtenue par `curl ifconfig.me`) et le nom d'hôte. Appelé depuis le menu principal
([Fmenu](../../Communs/Fmenu.class/architecture.md), l. 2098).

Nature : **mixte** (shell + GUI).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Monip` | 3-35 | Public | 3 | 30 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Monip()`** [portée : nécessaire] [nature : mixte]. Crée une `Form` 500×150 (`Border.Etched`,
  non redimensionnable) avec un `Label` centré, exécute `Shell "cd " & User.Home` (sans effet :
  sous-shell asynchrone), puis `Shell "curl ifconfig.me > monip" Wait` qui écrit le fichier
  **dans le répertoire courant du processus**, et relit `User.Home & "/monip"`. Succès : affiche
  « Mon adresse WAN IP est : … » et « Mon nom d'hôte est : `System.Host` ». Échec de lecture :
  `Message.Warning` (curl absent). ⚠️ Si le répertoire courant n'est pas `$HOME`, le fichier lu
  est absent ou périmé (MONIP-A01). Le fichier `monip` n'est jamais supprimé. La variable locale
  `$hform` porte un préfixe `$` réservé aux membres privés. Partie extractible : la fonction
  « obtenir l'IP publique » (`Shell "curl -s ifconfig.me" To s`).

## État global utilisé

- `User.Home`, `System.Host`. Service externe `ifconfig.me` (accès réseau).

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer le fichier temporaire par `Shell "curl -s ifconfig.me" Wait To Wanip` ; supprimer le
  `Shell "cd"` inutile.

### Commonalisation avec d'autres fichiers

- La détection d'outil absent pourrait utiliser [CheckProg.Chk](../CheckProg.module/architecture.md).

### Réduction de portée

- Sans objet (fonction unique, appelée par `Fmenu`).

### Séparation traitement / GUI

- `IpPublique() As String` (shell, pur) + `Monip()` (fenêtre).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
