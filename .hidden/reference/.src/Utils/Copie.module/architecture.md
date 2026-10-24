# Copie — Architecture

> Source : `.src/Utils/Copie.module`

## Vue d'ensemble

Module de **copie d'un PDF généré** dans un sous-répertoire du dossier personnel
(`~/Impressions/<type>.pdf`). Le chemin de la dernière copie est conservé dans deux globales
(`spiece`, `schemin`), relues ailleurs pour un envoi FTP.

Nature : **système** (shell), avec un `Message.Error`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `spiece` | var | Public | oui | String | 3 |
| `schemin` | var | Public | oui | String | 4 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Dupli` | 6-22 | Public | 5 | 15 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Dupli(Fichier, chemin, ty, Dtef)`** [portée : nécessaire] [nature : mixte]. Si
  `User.Home & chemin` n'existe pas : `Try Mkdir` (non récursif) et `Message.Error` en cas d'échec
  (le message cite toujours « Impressions »), **sans copier le fichier**. Sinon : `Shell "cp " &
  Fichier & " ~/<chemin>/<ty>.pdf" Wait`, puis `spiece` = chemin de la copie, `schemin` = répertoire,
  et `Wait 0.5`. Le paramètre `Dtef` n'est pas utilisé ; `Try spiece = ""` et `Shell "cd …"` sont
  sans effet utile. Appelant : `Edbr.module:226` (`"/Impressions"`, `"BonReception-<fournisseur>"`).
  ⚠️ Premier appel sur un poste neuf : le répertoire est créé mais la copie n'est pas faite
  (COPIE-A01). Chemins non quotés (espaces).

## État global utilisé

- **Déclaré** : `spiece` (lu par `FacturefmA.class:554,560` pour `FTPClient1.Put`), `schemin`
  (jamais lu hors du module).
- **Lu** : `User.Home`.

⚠️ `FacturefmA.EnvoiFTP` envoie `Copie.spiece` sans appeler `Dupli` : il transmet donc la
**dernière copie faite par n'importe quel écran** (aujourd'hui un bon de réception d'`Edbr`), ou une
chaîne vide en début de session. Comportement à confirmer avec l'utilisateur (COPIE-A02).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Dupli` renvoie le chemin de la copie (fonction) au lieu d'écrire `spiece`/`schemin` ; garder les
  globales tant que `FacturefmA` les lit.
- `Copy` Gambas au lieu de `Shell "cp"` (pas de problème d'espaces), suppression de `Shell "cd"`,
  `Try spiece = ""`, `Wait 0.5` (à confirmer : l'attente compense peut-être un `Shell` asynchrone
  disparu).

### Commonalisation avec d'autres fichiers

- [Caisse.Dupli](../../Caisse/Caisse.class/architecture.md) (`Caisse.class:6950`) fait la même chose
  pour les tickets (`~/HistoTickets-<user>/aaaa/mm/`), avec `Mkdir` en cascade : une fonction commune
  `Copie.Archive(fichier, repertoire, nom)` servirait aux deux.
- Création de répertoires : [Utils.Mkdir_p](../Utils.module/architecture.md).

### Réduction de portée

- `schemin` n'est lu nulle part hors du module : `Private` (ou supprimé). `spiece` reste Public.
- ⚠️ Plusieurs écrans ont un contrôle nommé `Copie` (`FClient`, `FFournisseur`, `Prefs`) : `Copie.Value`
  y désigne la case à cocher, pas ce module. Ne pas les confondre lors des greps.

### Séparation traitement / GUI

- Le `Message.Error` peut remonter à l'appelant via un booléen de retour ; la copie reste pure.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (pas d'accès à la base) ; la GED (`Docs_Ged`, `LGed`) est l'endroit naturel pour archiver
  ces PDF.
