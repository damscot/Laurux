# Impression — Architecture

> Source : `.src/Utils/Impression.module`

## Vue d'ensemble

Envoi d'un PDF à l'imprimante par la commande système (`lpr` par défaut) : tickets de caisse
(`Ticket`) et factures (`Facture`), avec affichage préalable optionnel du PDF via
[Visualiseur](../Visualiseur.module/architecture.md). Les réglages viennent de `Start.LocalSettings`.

Nature : **système** (shell).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Ticket` | 3-24 | Public | 4 | 17 | 1 |  |
| `Facture` | 27-57 | Public | 7 | 27 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Ticket(Fic As String, nb As Integer) As String`** [portée : nécessaire] [nature : système].
  `Shell "cd " & User.Home` (sans effet) ; si `/Soc<XX>/caisse/TKpdf`, ouvre le PDF ; commande =
  `/Soc<XX>/caisse/CmdImp` ou `lpr` ; puis `Shell <cmd> [-P <Cimp>] -# <nb> <Fic> Wait`
  (imprimante `/Soc<XX>/caisse/Cimp`). Ne renvoie rien malgré `As String`, `$Exec` est une variable
  locale à préfixe `$`. Appelant : `Caisse:5285,5287`.
- **`Facture(Fic As String, nb As Integer, Optional Imprimante = "") As String`** [portée :
  nécessaire] [nature : système]. Lit des clés **globales** (sans `/Soc<XX>/caisse/`) : `/FACpdf`
  (aperçu), `/CmdImp` (commande, défaut `lpr`), `/choiximp2`, `/Cimp`. Si `/choiximp2` : construit la
  commande **sans l'exécuter** (le `Wait` est commenté et aucun `Shell` n'est lancé) ; sinon lance
  `nb` fois `<cmd> [-P <imprimante>] <Fic>` (imprimante passée en paramètre, sinon `/Cimp`).
  Appelants : `Caisse:6750,6752`, `Facturergbl:974`, `EdPrep:306`, `ObjFacB:678-778` (8 appels).
  ⚠️ L'écran `Caisse/Preferences` enregistre ces réglages sous `/Soc<XX>/caisse/FACpdf`,
  `…/choiximp2`, `…/CmdImp`, `…/Cimp` : **aucun code n'écrit les clés globales lues ici**, qui ne
  peuvent venir que d'une édition manuelle de `Laurux.conf` ou d'une ancienne version
  (IMPRESSION-A01, à confirmer).

### Fonction appelée mais inexistante

- `Bordrx.class:383` appelle **`Impression.Prog_Editeur(…)`**, qui n'existe pas dans ce module (elle
  existe dans `Gestion/Impressions/Editeur.module`) ; la même ligne utilise `Start.Soc`, qui n'existe
  pas non plus (`Start.Societe`). Erreur à l'exécution (« symbole inconnu ») lors de l'impression
  d'un bordereau de LCR non visualisé (`org <> "1"`). Voir IMPRESSION-A03 (correction dans `Bordrx`).

## État global utilisé

- `Start.LocalSettings` : `/Soc<XX>/caisse/TKpdf`, `CmdImp`, `Cimp` (tickets) ; `/FACpdf`, `/CmdImp`,
  `/choiximp2`, `/Cimp` (factures, clés globales). `Start.Societe`, `User.Home`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Shell "cd …"` (asynchrone, sans effet), déclarer les deux fonctions en `Sub`, renommer
  `$Exec` en `sCmd`.
- `Facture` : supprimer la construction inutile de commande dans la branche `/choiximp2` (aucun
  effet aujourd'hui) — sans changer le fait que rien n'est imprimé.

### Commonalisation avec d'autres fichiers

- `Ticket` et `Facture` construisent la même commande (`<cmd> -P <imprimante> … <fichier>`) : helper
  privé `CommandeImpression(cmd, imprimante, fichier)`.
- [Visualiseur.Prog](../Visualiseur.module/architecture.md) et `Editeur.Prog_Editeur` : même schéma
  « commande configurée + fichier ».
- Les réglages caisse sont relus à chaque appel ; [Caisse](../../Caisse/Caisse.class/architecture.md)
  les lit aussi dans ses `Preferences`.

### Réduction de portée

- Sans objet (deux fonctions appelées de l'extérieur).

### Séparation traitement / GUI

- Le choix de la commande (pur, testable) peut être séparé du `Shell`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base).
