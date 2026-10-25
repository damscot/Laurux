# MajEqu — Architecture

> Source : `.src/Gestion/Stock/Tarifs/MajEqu.module`

## Vue d'ensemble

`MajEqu` maintient la **table des codes équivalents** `Fiches_Cequ` (`Cbase.Table("TabCequ")`,
clé primaire `(codep, codequ)`). Deux articles équivalents (même produit chez deux fournisseurs,
ancien et nouveau code…) doivent être reliés deux à deux, **dans les deux sens**, à tous les
membres de leur groupe : la table est la fermeture transitive et symétrique de la relation
« est équivalent à ». `Fiches_Art.art_cequ` mémorise en plus le dernier code équivalent saisi.

Le module ne contient que deux procédures sans état : `Maj` (ajout d'une équivalence) et `Recup`
(reconstruction de la symétrie sur toute la table). Les doublons sont évités par la clé
primaire : chaque `INSERT` est encadré par `Try`, l'erreur de doublon est ignorée.

Nature globale : **traitement** (SQL uniquement), sans GUI ni état global, sauf l'export vers le
« serveur » (`Serveur.Pass`) conditionné par `Variables.Sprix/Sexport/SMajArt`.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Maj` | 3-43 | Public | 24 | 36 | 2 |  |
| `Recup` | 45-58 | Public | 5 | 11 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Maj(code, cequ)`** (CC 24) [portée : nécessaire, `Articles.class:933, 3917, 3937`,
  `Impart.class:670, 1290`] [nature : calcul].
  1. Lignes 7-10 : `INSERT` (sous `Try`) des liens `(cequ, code)`, `(code, code)`,
     `(cequ, cequ)`, `(code, cequ)` ; puis `UPDATE Fiches_Art SET art_cequ = cequ WHERE art_code = code`
     (sous `Try`).
  2. Lignes 13-21 : pour chaque ligne `(code, X)`, pour chaque ligne `(X, Y)` : `INSERT` de
     `(Y, code)` (écrit `(codequ, codep) VALUES (code, Y)`), de `(X, code)` et de
     `(Y, requ2!codep)` = `(Y, code)` (doublon de la première insertion).
  3. Lignes 22-30 : texte **identique** au bloc 2, en partant des lignes `(cequ, X)` : insère
     `(Y, code)`, `(X, code)` et `(Y, cequ)`.
  4. Lignes 32-40 : pour chaque ligne `(X, cequ)`, pour chaque ligne `(cequ, Y)` : `INSERT` de
     `(code, cequ)`, `(X, Y)` et `(Y, X)` (tous les voisins de `cequ` reliés deux à deux).
  5. Ligne 41 : export `Serveur.Pass("EQ", "M", code, cequ)` si les trois drapeaux
     `Variables.Sprix`, `Sexport`, `SMajArt` sont vrais.
  Coût : O(n²) requêtes par groupe (une requête `SELECT` par voisin, trois `INSERT` par couple).
  ⚠️ Les `Repeat` sur `requ2` ne testent pas `Available` : le premier `SELECT` renvoie toujours au
  moins la ligne `(code, code)` insérée à la ligne 8, sauf si cet `INSERT` a échoué pour une autre
  cause qu'un doublon. Les `Repeat` internes sur `requ` vides ne plantent pas : la lecture
  `requ!codequ` est dans l'instruction `Try … Exec(…)`, l'erreur est donc avalée.
  ⚠️ Avec `/dbase/backtrace` actif, `DB_Connection.Exec` affiche un `Message.Error` **avant** de
  propager l'erreur : chaque doublon ignoré par `Try` ouvre alors une boîte d'erreur
  (MAJEQU-A02, à confirmer par replay).
  La fermeture transitive en une passe est à vérifier sur des chaînes (A-B, C-D puis B-C) :
  MAJEQU-T02 fige le résultat actuel.
- **`Recup()`** [portée : nécessaire, `Prgm.class:102`, menu « Maj équivalents »] [nature : calcul].
  Pour chaque ligne `(P, Q)` de la table (ordre `codep`), pour chaque `(Q, R)` : `INSERT (P, R)` et
  `(R, P)`. Complète la symétrie et un niveau de transitivité. ⚠️ Table vide : `requ2!codequ`
  (ligne 51) est lu hors `Try` sur un résultat non disponible → erreur non interceptée
  (MAJEQU-A01).

## État global utilisé

- `Utils.db` (`Exec`), `Cbase.Table("TabCequ")`, `Cbase.Table("TabArt")`.
- `Variables.Sprix`, `Variables.Sexport`, `Variables.SMajArt` ; `Serveur.Pass`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Procédure privée `Lien(sCodep, sCodequ)` = `Try Utils.db.Exec("INSERT INTO … (codep, codequ)
  VALUES (&1, &2)", …)` pour les 17 `INSERT` (les 4 écrits `(codequ, codep)` sont réordonnés :
  SQL modifié, dump identique).
- Procédure privée `PropageDepuis(sDepart, sCode)` pour les blocs 2 et 3 de `Maj`, identiques
  (CC 24 → ≤ 10).

### Commonalisation avec d'autres fichiers

- Garde d'export `Variables.Sprix And Variables.Sexport And Variables.SMajArt` → `Serveur.Actif`
  proposé par SERVEUR-008 ([`Serveur`](../../../../Serveur.module/architecture.md)).
- [`Impart`](../Impart.class/architecture.md) appelle `Maj(Cequ, art_code)` avec les arguments
  **inversés** à la ligne 1290 (anomalie IMPART-A04, côté appelant).

### Réduction de portée

- Aucune : les deux procédures ont des appelants externes.

### Séparation traitement / GUI

- Sans objet (aucun accès GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer la table de couples `Fiches_Cequ` (n² lignes par groupe) par un **identifiant de
  groupe** d'équivalence (`art_groupequ`) : l'ajout d'une équivalence devient la fusion de deux
  groupes en un seul `UPDATE`, sans fermeture transitive à recalculer.
- `INSERT IGNORE` (MySQL) / `INSERT OR IGNORE` (SQLite) éviterait les erreurs de doublon
  attrapées par `Try` (nécessite une traduction dans `DB_Connection`).
