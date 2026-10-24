# AffRdv — Architecture

> Source : `.src/Utils/AffRdv.module`

## Vue d'ensemble

Rappel des **rendez-vous de l'agenda** : toutes les minutes, le `Timer1` du menu principal
([Fmenu](../../Communs/Fmenu.class/architecture.md), `Delay = 60000`) appelle `Calc_Timer`, qui cherche
dans `Fiches_Agenda` une action prévue à l'heure courante pour l'utilisateur système et l'annonce
(synthèse vocale + `Message.Warning`). Les rendez-vous sont saisis dans
[Agenda](../Agenda.class/architecture.md).

Nature : **mixte** (SQL + GUI).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Aff_Rdv` | 3-18 | Public | 4 | 13 | 0 | portée réductible ? |
| `Calc_Timer` | 20-26 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Aff_Rdv()`** [portée : réductible, seul appelant interne] [nature : mixte]. `SELECT * FROM
  Cbase.Table("TabAgenda") WHERE haction = &1 AND daction = &2 AND nuser = &3` avec l'heure courante
  au format `HHhMM`, la date `yyyy-mm-dd` et `User.Name`. Si une ligne a un `iaction` non nul :
  `Syntheses.Message("Il est H heure M . <action>")` puis `Message.Warning("Il est <haction> !!!
  <action>")` (modal). Seule la **première** ligne est annoncée. `Catch` vide : toute erreur (base
  indisponible…) est ignorée silencieusement. Partie extractible : la requête et la construction des
  messages.
- **`Calc_Timer(Timer1 As Timer)`** [portée : nécessaire] [nature : GUI]. Désactive le timer, appelle
  `Aff_Rdv`, le réactive : évite la réentrance pendant que le `Message.Warning` modal est affiché.
  ⚠️ Comme le timer est relancé après la fermeture du message, un rendez-vous dont le message est
  fermé dans la même minute peut être annoncé deux fois (à confirmer).

## État global utilisé

- `Utils.db`, `Cbase.Table`, `User.Name`, `Now`. Appelle `Syntheses.Message`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Remplacer le `Catch` vide par une journalisation (`Utils.Log`) sans message à l'utilisateur
  (comportement visible identique).

### Commonalisation avec d'autres fichiers

- [Agenda](../Agenda.class/architecture.md) (l. 106) émet la même requête `daction`/`haction`/`nuser` :
  une fonction `ActionAgenda(date, heure, user) As Result` partagée.

### Réduction de portée

- `Aff_Rdv` → `Private` (aucun appelant externe, vérifié par grep).

### Séparation traitement / GUI

- `ProchainRdv() As String` (SQL + texte) et l'affichage (`Syntheses`, `Message.Warning`) dans
  `Aff_Rdv`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `daction`/`haction` sont des `varchar(20)` : une colonne `datetime` unique permettrait une recherche
  par intervalle (rendez-vous manqués pendant une indisponibilité) et un index.
