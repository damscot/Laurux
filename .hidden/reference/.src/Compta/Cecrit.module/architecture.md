# Cecrit — Architecture

> Source : `.src/Compta/Cecrit.module`

## Vue d'ensemble

Module d'aide à l'affichage d'une liste d'écritures comptables (`Fiches_Mvt` ou table passée en
paramètre) dans une `GridView` : remplissage d'une cellule (`Ecrit_Data`), largeur des colonnes
calée sur des `TextBox` d'en-tête (`Tris2`), et huit variantes de chargement (`Debe1`…`Debn4`)
qui diffèrent par le filtre (`provisoire`/`validee`, `tresorerie`) et le sens du tri.

**Le module entier est du code mort** : aucun fichier n'appelle `Cecrit.*` (vérifié par
`grep -rn "Cecrit" .src`). Les homonymes `Tris2()`, `Debn1()`… de
[`TriEcritures2`](../../Affichages/TriEcritures2.class/architecture.md), `Eticli`, `Emailing` et
`EmailingCarte` sont des méthodes **locales** de ces classes, pas des appels à ce module.

Nature globale : **GUI** (remplissage de grille) avec SQL concaténé.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Cotable` | var | Private | oui | New String[8] | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Ecrit_Data` | 5-31 | Public | 8 | 25 | 0 | portée réductible ? |
| `Tris2` | 33-47 | Public | 1 | 13 | 0 | portée réductible ? |
| `Debe1` | 49-54 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe2` | 56-61 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe3` | 63-68 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debe4` | 70-75 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn1` | 77-82 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn2` | 84-89 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn3` | 91-96 | Public | 1 | 4 | 0 | portée réductible ? |
| `Debn4` | 98-103 | Public | 1 | 4 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Ecrit_Data(Ecrit, Row, Column)`** [portée : réductible, aucun appelant] [nature : GUI].
  Se place sur la ligne `Row` du résultat global `Utils.rs1` et affiche la colonne correspondante
  (`jour`, `compte`, `dte`, `numero`, `numdoc`, `montantd`, `montantc`, `libelle`). La date est
  reformatée par découpage de chaîne (`/` → `.`, 10 caractères) ; les montants en `0.00`.
- **`Tris2(Ecrit, JO, COM, DA2, NUMERO, DOC2, DEB, CRED, INTITULE)`** [portée : réductible]
  [nature : GUI]. Fixe 8 colonnes et recopie la largeur des 8 `TextBox` d'en-tête.
- **`Debe1`…`Debe4`, `Debn1`…`Debn4` (Ecrit, Tab, Tri, Sel)** [portée : réductible] [nature : mixte].
  Exécutent `Utils.Base(grille, sql)` (qui remplit `Utils.rs1` et fixe `Rows.Count`), puis
  `Refresh`. SQL émis : `select * from <Tab> where <provisoire|validee> = 0|1 and tresorerie = 0|1
  and cloturee = 0 [and collectif is null] [and <Tri> like "%<Sel>%"] order by <Tri> [DESC]`.
  Toutes les valeurs sont **concaténées** (y compris `Sel`, saisi par l'utilisateur), avec des
  guillemets doubles. `Debe2`/`Debe4` ignorent `Sel`.

## État global utilisé

- `Utils.rs1` (résultat partagé, écrit par `Utils.Base`, lu par `Ecrit_Data`).
- `Utils.Base`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Sans objet : le module est mort. La seule action utile est sa suppression (CECRIT-001).

### Commonalisation avec d'autres fichiers

- Le même idiome (grille alimentée par `Utils.Base*` et un `Result` global) se retrouve dans
  [`Ccomptes`](../Ccomptes.module/architecture.md) (`Utils.Base3`/`Utils.rs3`) et dans
  `TriEcritures2`. Voir `Utils.Base*` (UTILS-005).

### Réduction de portée

- Tout le module : suppression plutôt que réduction.

### Séparation traitement / GUI

- Sans objet (module mort).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à ce module.
