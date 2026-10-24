# Enrgcp — Architecture

> Source : `.src/Utils/Enrgcp.module`

## Vue d'ensemble

Enregistre un couple **code postal / bureau distributeur** dans la table des codes postaux s'il n'y
figure pas encore. Appelé après la saisie d'une adresse de client, de fournisseur, de client carte
ou de facture.

Nature : **traitement SQL**.

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Ecp` | 4-13 | Public | 3 | 7 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Ecp(cpostal As String, burdist As String)`** [portée : nécessaire] [nature : calcul/SQL]. Si
  `cpostal <> ""` : `SELECT * FROM Cbase.Table("TabCpostaux") WHERE cp = &1 AND burdist = &2` ; si
  aucun résultat, `INSERT INTO … (cp, burdist) VALUES (&1, &2)`. SQL paramétré, conforme aux règles.
  Un `burdist` vide est inséré tel quel. Sous SQLite, `DB_Connection` ajoute `COLLATE NOCASE` au
  `WHERE` : la détection de doublon y est insensible à la casse, pas sous MySQL (dépend de la
  collation de `Fiches_Cpostaux`, `utf8mb4_unicode_ci` donc aussi insensible : à confirmer).
  Appelants : `FClient:1454,1476`, `FFournisseur:1383,1406`, `FClientcarte:586,598`,
  `Facture:1717`.

## État global utilisé

- `Utils.db`, `Cbase.Table`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `SELECT 1 … LIMIT 1` au lieu de `SELECT *` (même comportement, moins de données).

### Commonalisation avec d'autres fichiers

- [Impcpostaux](../Exports-Imports/Impcpostaux.class/architecture.md) (l. 36-38) recopie exactement
  la même séquence `SELECT`/`INSERT` : il peut appeler `Enrgcp.Ecp`.

### Réduction de portée

- Sans objet (7 appels externes).

### Séparation traitement / GUI

- Déjà pur (aucun accès GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une clé unique `(cp, burdist)` sur `Fiches_Cpostaux` permettrait un `INSERT IGNORE` / `INSERT OR
  IGNORE` atomique et éliminerait les doublons créés par des saisies concurrentes.
