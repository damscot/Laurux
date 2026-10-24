# Renech — Architecture

> Source : `.src/Compta/Utils/Renech.class`

## Vue d'ensemble

Classe statique (pas de `.form`) de **réimport des dates d'échéance** des écritures de tiers.
Elle relit le fichier `~/Dtech.txt` (lignes `numdoc;compte;date;`) et met à jour `dateech` des
écritures correspondantes de `Fiches_Mvt`. Elle forme une paire avec
[`RecupDech`](../RecupDech.class/architecture.md), qui exporte ces dates dans **`~/tmp/Dtech.txt`**
(chemin différent : le fichier doit être déplacé à la main entre les deux scripts). Lancée par
`Prgm` (`Renech`, `Prgm.class:84`) sans confirmation ni transaction (PRGM-A02).

Nature : **traitement (fichier + SQL)**, message de fin.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hfile` | var | Private | oui | File | 3 |
<!-- /AUTO:declarations -->

`hfile` est une variable **statique de classe** : le fichier n'est jamais fermé (`Close` absent).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 5-21 | Public Static | 3 | 14 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (Static, CC 3) [portée : nécessaire — `Prgm.class:84`] [nature : traitement +
  message] :
  - `Open User.Home & "/Dtech.txt" For Read` sans `Try` : fichier absent → erreur d'exécution ;
  - pour chaque ligne : `Split(";")`, `numdoc = [0]`, `code = [1]`, date convertie par
    `Right$(d, 4) & Left$(d, 2) & Mid$(d, 4, 2)`, soit `aaaammjj` **si** le champ est au format
    `mm/jj/aaaa` (format de conversion d'une `Date` Gambas en chaîne sans heure, tel qu'écrit par
    `RecupDech` — à confirmer ; une heure non nulle donnerait une date invalide) ; une ligne vide
    ou incomplète provoque une erreur d'indice ;
  - `Update <Cbase.Table("TabMvt")> SET dateech = &1 WHERE compte = &2 AND numdoc = &3` (toutes les
    lignes du document pour ce compte) ;
  - `Message.Info("TRAITEMENT TERMINÉ")` (non extrait pour l'i18n). Le fichier reste ouvert.
  - Sous SQLite, `dateech` reçoit la chaîne `aaaammjj` au lieu du format date habituel (à
    confirmer).

## État global utilisé

- `User.Home` ; `Utils.db` ; `Cbase.Table("TabMvt")` (`Fiches_Mvt`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Dim hFile As File` local + `Close`, `Try` sur l'ouverture avec message, saut des lignes
  incomplètes (ces deux derniers points changent le comportement : anomalie A01).
- Conversion de date par `LDate` (parse du format écrit par `RecupDech`) plutôt que par découpage.

### Commonalisation avec d'autres fichiers

- Le couple `RecupDech`/`Renech` est un export/import CSV ad hoc ; le socle d'import/export
  (`ImpExp`, voir notes transverses) pourrait l'absorber s'il est conservé.

### Réduction de portée

- Sans objet.

### Séparation traitement / GUI

- Le seul élément d'IHM est le message final.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
