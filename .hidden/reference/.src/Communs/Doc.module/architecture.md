# Doc — Architecture

> Source : `.src/Communs/Doc.module`

## Vue d'ensemble

`Doc` est le module d'**aide en ligne** : `Doc.Open(Rubrique)` ouvre la page HTML locale
`Application.Path/<Module>/<Rubrique>.html` (dossier `Ecrans` par défaut) avec `xdg-open`, ou, si
elle n'existe pas, la documentation générale du site
(`https://www.laurux.fr/drupal/documentation`).

C'est l'un des modules les plus appelés : **162 appels dans 155 fichiers** (boutons « Aide » des
écrans, menu « ? > Aide Html » de `Fmenu`), avec 111 rubriques distinctes. Aucun appelant ne
passe le second paramètre `Module`. Le dépôt ne contient **pas** de dossier `Ecrans` : en pratique,
toutes les rubriques ouvrent la page générale du site (DOC-A01).

Nature globale : **calcul + lancement d'un programme externe** (pas d'interface propre).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `wwwpath` | var | Private | oui | String | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Open` | 6-15 | Public | 2 | 7 | 149 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Open(Rubrique As String, Optional Module As String = "Ecrans")`** [portée : nécessaire, 155
  fichiers] [nature : mixte (exécution externe)]. Teste `Exist(Application.Path & "/" & Module &
  "/" & Rubrique & ".html")` ; si vrai, `Exec ["xdg-open", chemin]`, sinon `Exec ["xdg-open",
  wwwpath]`. `Exec` sans `Wait` (non bloquant), sans gestion d'erreur (`xdg-open` absent → erreur
  d'exécution, à confirmer). Le `If` est écrit sans `Then` (forme admise par Gambas).

## État global utilisé

- `Application.Path` ; constante privée `wwwpath`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `wwwpath` en `Private Const`.
- Calculer le chemin une seule fois (variable locale).

### Commonalisation avec d'autres fichiers

- `Fmenu.Menu64_Click` (`Exec ["xdg-open", "http://www.laurux.fr"]`), `LGed`, `FClientcarte`
  appellent aussi `xdg-open` directement (`DEPENDANCES.md`) : une procédure `Doc.OuvreUrl(sUrl)`
  centraliserait l'appel du navigateur.

### Réduction de portée

- `Open` est nécessaire. Le paramètre `Module` n'est utilisé par aucun appelant : il peut être
  conservé (API stable) ou retiré sans modifier d'appelant.

### Séparation traitement / GUI

- Fonction pure `CheminAide(Rubrique, Module) As String` (chemin local ou URL) testable en gb.test ;
  `Open` ne fait plus que l'`Exec`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
