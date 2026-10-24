# RecupDech — Architecture

> Source : `.src/Compta/Utils/RecupDech.class` · Formulaire : `.src/Compta/Utils/RecupDech.form`

## Vue d'ensemble

**Export des dates d'échéance** des écritures de tiers (comptes 401* et 411* non collectifs avec
`dateech` renseignée) dans `~/tmp/Dtech.txt`, au format `numdoc;compte;date;`. Pendant de
[`Renech`](../Renech.class/architecture.md), qui relit `~/Dtech.txt`. Lancé par `Prgm`
(`RecupDech`, `Prgm.class:83`) via la méthode **statique** `run`.

Le `.form` associé (« Récupération date echéance », boutons Lancer/Quitter) n'est **jamais
affiché** : aucun `RecupDech.Show`/`ShowModal`/`New RecupDech` (grep) ; `Button1` (Lancer) n'a
même pas de handler. Le formulaire et `Button2_Click` sont du code mort ; leur suppression est une
anomalie (couple `.form` intouchable sans validation).

Nature : **traitement (SQL + fichier)**, message de fin.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hfil` | var | Private | oui | File | 3 |
<!-- /AUTO:declarations -->

`hfil` est une variable statique de classe (fermée en fin de `run`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `run` | 5-20 | Public Static | 4 | 13 | 1 |  |
| `Button2_Click` | 22-26 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`run()`** (Static, CC 4) [portée : nécessaire — `Prgm.class:83`] [nature : traitement +
  message] :
  - `Open User.Home & "/tmp/Dtech.txt" For Write Create` (sans `Try` : répertoire `~/tmp` absent →
    erreur d'exécution) ;
  - `SELECT * FROM <Cbase.Table("TabMvt")> WHERE left(compte,3) = '401' AND collectif IS NULL AND
    dateech IS NOT NULL OR left(compte,3) = '411' AND … ORDER BY numero` (priorité `AND` > `OR`
    correcte ; `left()` traduit pour SQLite par `DB_Connection`) ;
  - `Print rResult.count` sur la sortie standard (trace de débogage) ;
  - une ligne `numdoc;compte;dateech;` par écriture (date convertie en chaîne par `&` : format
    Gambas non localisé `mm/jj/aaaa`, avec l'heure si elle n'est pas nulle — à confirmer) ;
  - `Close`, `Message.Info("Traitement terminé !")`.
- **`Button2_Click()`** [handler, GUI] : ferme le formulaire — jamais atteint (formulaire jamais
  affiché).

## État global utilisé

- `User.Home` ; `Utils.db` ; `Cbase.Table("TabMvt")`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Dim hFil As File` local ; supprimer le `Print` de débogage (sortie standard seulement).
- Format de date explicite (`Format$(dateech, "mm/dd/yyyy")`) pour ne plus dépendre de la
  conversion implicite ; même texte pour les dates sans heure (à vérifier par T01).

### Commonalisation avec d'autres fichiers

- Voir [`Renech`](../Renech.class/architecture.md) : paire export/import à fusionner dans un même
  module (constante de chemin partagée) ou à retirer ensemble.

### Réduction de portée

- Sans objet (`run` est appelée par `Prgm` ; les handlers restent `Public`).

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
