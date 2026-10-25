# fourconsdroi — Architecture

> Source : `.src/Gestion/option/fourconsdroi.class`

## Vue d'ensemble

`fourconsdroi` (« gère les consignes et droits accises sur les achats ») est une classe sans
formulaire qui devait accumuler, ligne par ligne, les consignes (palette, colis, bouteille) et
les droits d'accise d'une réception fournisseur, puis les enregistrer dans `Fiches_ligcons`
(`type = 'E'`, `envaleur`, `bloc`) et `Fiches_ligregie`.

**La classe n'est instanciée nulle part** (vérifié par `grep -rni fourconsdroi .src`) : c'est une
ébauche remplacée par [`Consigne`](../Consigne.class/architecture.md) /
[`calculdroit1`](../calculdroit1.class/architecture.md) et par `Achat.EnrRec`/`EnrConsigne`. Tout
son code est mort. Pas de `.form` : la suppression du fichier est un rework [code mort] et non une
anomalie.

Elle déclare deux structures publiques : `consigne` (`code`, `nb`, `montant`) — **homonyme, à la
casse près, de la classe `Consigne`** — et `ligne` (article, trois `consigne`, un `Calculdroit`).

Nature globale : **calcul + SQL** (mort).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$schois` | var | Private |  | String | 5 |
| `$cons` | var | Private |  | Float | 6 |
| `$decosn` | var | Private |  | Float | 7 |
| `$accise` | var | Private |  | Float | 8 |
| `$tva` | var | Private |  | Float | 9 |
| `$sbloc` | var | Private |  | String | 10 |
| `$bvign` | var | Private |  | Boolean | 11 |
| `code` | var | Private |  | String | 14 |
| `nb` | var | Private |  | Integer | 15 |
| `montant` | var | Private |  | Float | 16 |
| `art` | var | Private |  | String | 21 |
| `conspal` | var | Private |  | Consigne | 22 |
| `conscoli` | var | Private |  | Consigne | 23 |
| `consbte` | var | Private |  | Consigne | 24 |
| `cdt` | var | Private |  | Calculdroit | 26 |
| `$lg` | var | Private |  | Collection | 30 |
| `consigne` | property | Public |  | Float | 32 |
| `deconsigne` | property | Public |  | Float | 33 |
| `accise` | property | Public |  | Float | 34 |
| `tva` | property | Public |  | Float | 35 |
| `bloc` | property | Public |  | String | 36 |
| `lig` | property | Public |  | Collection | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 40-77 | Public | 8 | 35 | 0 | méthode spéciale |
| `addligne` | 79-114 | Public | 8 | 33 | 0 | portée réductible ? |
| `calcons` | 116-129 | Private | 2 | 11 | 0 |  |
| `supligne` | 131-140 | Public | 4 | 8 | 0 | portée réductible ? |
| `enrligne` | 142-155 | Public | 5 | 11 | 0 | portée réductible ? |
| `renligne` | 157-169 | Public | 2 | 10 | 0 | portée réductible ? |
| `recuppalette` | 171-185 | Public | 4 | 12 | 0 | portée réductible ? |
| `recupcoli` | 187-201 | Public | 4 | 12 | 0 | portée réductible ? |
| `enregistre` | 203-220 | Private | 3 | 15 | 0 |  |
| `creadra` | 222-243 | Private | 2 | 19 | 0 |  |
| `consigne_Read` | 245-249 | Private | 1 | 3 | 0 |  |
| `accise_Read` | 251-255 | Private | 1 | 3 | 0 |  |
| `deconsigne_Read` | 257-261 | Private | 1 | 3 | 0 |  |
| `bloc_Read` | 263-267 | Private | 1 | 3 | 0 |  |
| `bloc_Write` | 269-273 | Private | 1 | 3 | 0 |  |
| `tva_Read` | 275-279 | Private | 1 | 3 | 0 |  |
| `lig_Read` | 281-285 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes [portée : réductible/morte] [nature : calcul].

- **`_new(choix, Optional block)`** : en mode `"M"` (modification de réception), relit
  `Fiches_ligcons` du `bloc` (`numlig <> 'D'`), regroupe par `numlig` dans `$lg` et classe chaque
  consigne selon `Fiches_consigne.type` (une requête par mouvement, `res!type` lu sans test).
- **`addligne(art, nbpal, nbcol, qte, nlge)`** (`unused`) : lit l'article
  (`art_code`/`art_cfour`/`art_refcentrale`), calcule les trois consignes (`calcons`) et cumule
  `$cons` ; crée `New Calculdroit(…)` et cumule `$accise`/`$tva`. ⚠️ Teste `cdt.suspendu` sur la
  variable locale `cdt` **jamais affectée** (« Null object » si la fonction était appelée) ;
  `resart` lu hors du test `Available`.
- **`calcons(nb, code)`** (privée) : `Fiches_consigne.prix × nb`.
- **`supligne(nlge)`** (`unused_transitive`, appelée seulement par `addligne`) : retire les montants
  d'une ligne des cumuls.
- **`enrligne(nbr)`** (`unused`) : `DELETE FROM Fiches_ligcons WHERE bloc = &1 AND numlig <> 'D'`
  **hors transaction**, puis `Begin`, `enregistre` par consigne, `Commit`.
- **`enregistre(cons, nbr, nlig)`** (`unused_transitive`) : `Edit` ou `Create9` d'une ligne de
  `Fiches_ligcons`.
- **`renligne()`** (`unused`) : renumérote les clés de `$lg` (`001`, `002`…).
- **`recuppalette(nlge)`**, **`recupcoli(nlge)`** (`unused`) : nombre de palettes/colis en mémoire
  ou en base (même requête que `Consigne.recuppalette/recupcol`).
- **`creadra(…)`** (privée, `unused`) : ligne `Fiches_ligregie` dans sa propre transaction.
- Accesseurs `consigne`, `deconsigne` (`$decosn` jamais alimenté), `accise`, `tva`, `bloc`, `lig`.

## État global utilisé

- `Utils.db`, `Utils.totobs`. Tables `Fiches_ligcons`, `Fiches_consigne`, `Fiches_ligregie`,
  `Fiches_Art` (colonnes d'option ajoutées par `modfichier`, absentes de `db_control.csv`).

## Propositions d'amélioration

### Réécriture / refactorisation

Aucune : supprimer le fichier.

### Commonalisation avec d'autres fichiers

Sans objet ; la logique vivante est dans `Consigne`, `calculdroit1` et `Achat`.

### Réduction de portée

Sans objet (suppression). `deps.py` propose `addligne`, `supligne`, `enrligne`, `renligne`,
`recuppalette`, `recupcoli` : tous morts.

### Séparation traitement / GUI

Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Colonne `Fiches_ligcons.envaleur` écrite par tous les écrivains à `True` : à supprimer ou à
  exploiter.
