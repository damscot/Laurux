# RenMvt — Architecture

> Source : `.src/Compta/Utils/RenMvt.module`

## Vue d'ensemble

Module de **scripts de maintenance ponctuels** sur les écritures, lancé par le dispatcher
`Prgm` (nom saisi `RenMvt`, `Prgm.class:82`) **sans confirmation ni transaction** (anomalie
PRGM-A02). Deux procédures :

- `Run` : déplace les écritures du journal `80` de `Fiches_Mvt` vers `Fiches_Mvt1` (exercice N-1)
  en retirant le premier chiffre de leur numéro ;
- `Ren` : renumérote toutes les écritures de `Fiches_Mvt` et remet à zéro clôture et numéro
  définitif. **Aucun appelant** (code mort).

Ce sont des scripts de reprise historique, écrits pour une situation de données précise : leur
exécution sur une base courante est destructrice.

Nature : **traitement SQL** (messages de fin seulement).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Run` | 3-26 | Public | 3 | 21 | 1 |  |
| `Ren` | 28-77 | Public | 4 | 27 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Run()`** (CC 3) [portée : nécessaire — `Prgm.class:82`] [nature : traitement + message] :
  1. `SELECT * FROM Fiches_Mvt WHERE jour = '80' ORDER BY dte, numero` ; **pas de test
     `Available`** : sur une base sans journal 80, la lecture de `rResult!numero` provoque une
     erreur d'exécution (anomalie A02).
  2. Pour chaque ligne : `nm = Val(numero sans son premier chiffre)` (ex. 51234 → 1234) ;
     `SELECT * FROM Fiches_Mvt1 WHERE numero = <nm> AND compte = <compte>` (`Print r2.Count` sur la
     sortie standard).
  3. Si absente de `Fiches_Mvt1` : `INSERT INTO Fiches_Mvt1` de 17 colonnes (`jour`, `numero = nm`,
     `compte`, `intitule`, `dte`, `numdoc`, `numlot`, `libelle`, `montantd`, `montantc`, `validee`,
     `provisoire`, `tresorerie`, `lettree`, `cloturee`, `pointee`, `numcol`) ; les colonnes
     `numerodef`, `collectif`, `datee`, `dateech`, `nrlv`, `dteval`, `relance`, `export` et
     **`control`** (clé SHA-1 d'inaltérabilité) ne sont pas copiées.
  4. puis `DELETE FROM Fiches_Mvt WHERE numero = <nm> AND compte = <compte>` : ⚠️ supprime
     l'écriture de numéro **tronqué** `nm`, et non l'écriture `numero` qui vient d'être copiée
     (anomalie A01 : l'écriture copiée reste en double, une autre écriture est supprimée si elle
     existe).
  5. `Message.Warning("Traitement terminé")` (chaîne non extraite pour l'i18n).
- **`Ren()`** (CC 4) [portée : réductible — **aucun appelant** (grep)] [nature : traitement] :
  `UPdate Fiches_Parametres SET numecriture2 = 0` ; renumérotation séquentielle par `(dte,
  numero)` de toutes les écritures de `Fiches_Mvt` avec `cloturee = 0`, `numerodef = 0` ;
  `numecriture = <dernier>`, `numecriture1 = 0` ; `SELECT` inutile ligne 74 ; `UPdate Fiches_Mvt SET
  cloturee = 0, numerodef = 0` global. Variable `Tab` commentée, bloc de renumérotation des
  écritures clôturées commenté. Destructeur pour la traçabilité (clés `control` non recalculées).

## État global utilisé

- `Utils.db` ; tables en dur `Fiches_Mvt`, `Fiches_Mvt1`, `Fiches_Parametres` (sans
  `Cbase.Table`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune réécriture utile : scripts ponctuels à retirer (anomalies A01 à A03).

### Commonalisation avec d'autres fichiers

- Le déplacement d'écritures entre exercices existe proprement dans la clôture annuelle
  (`FClotureAn`, `Compta/Clotures/`) ; aucun partage à faire avec un script à retirer.

### Réduction de portée

- `Ren` : supprimer (code mort) plutôt que passer en `Private`.

### Séparation traitement / GUI

- Sans objet (seul le message final est de l'IHM).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
