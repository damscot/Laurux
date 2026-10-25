# Consigne — Architecture

> Source : `.src/Gestion/option/Consigne.class`

## Vue d'ensemble

`Consigne` est l'**objet de calcul des consignes d'emballages** de l'option « boissons » (options
`B` ou `T` de `Utils.Option()`, colonnes et tables créées à l'exécution par
`modfichier.fichierboisson`). C'est une classe sans formulaire qui **hérite de
[`calculdroit1`](../calculdroit1.class/architecture.md)**, elle-même héritière de
[`LPrix`](../../../Utils/LPrix.class/architecture.md) : un objet `Consigne` est donc à la fois un
prix (`Mnt` × `Qte`, taxes `LTaxe`), un calcul de droits sur les alcools (régie) et un calcul de
consignes.

Règle métier telle que le code l'applique :

- un article de boisson porte trois codes de consigne (`Fiches_Art.art_consp` palette,
  `art_consc` colis/caisse, `art_consb` bouteille/unité) ; chaque code renvoie à
  `Fiches_consigne` (`code`, `libelle`, `prix`, `type` `P`/`C`/`B`) ;
- le montant consigné d'une ligne = `prix(palette) × nb palettes + prix(colis) × nb colis +
  prix(unité) × quantité de la ligne` (`consigne_Read`), chaque terme passant par une `LTaxe` de
  type `LTaxe.Consigne` (montant fixe, non pourcentage) ;
- les mouvements de consigne d'une réception sont stockés dans `Fiches_ligcons` avec la clé
  `bloc = date (dd.mm.yyyy) & numéro de réception & code fournisseur` et `numlig` = numéro de
  ligne sur 3 chiffres (`"001"`…) ; `recuppalette`/`recupcol` relisent les nombres de palettes et
  de colis déjà enregistrés pour une ligne.

Le constructeur Gambas d'une classe héritée consomme les paramètres **de la classe mère d'abord** :
`New Consigne(a1…a13)` répartit `a1-a4` sur `LPrix._New(Montant, Quantite, Arr, Cpt)`, `a5-a8`
sur `calculdroit1._new(dra, vol, deg, fam)` et `a9-a13` sur `Consigne._new(cdepal, nbpal, cdecol,
nbcol, cdeunit)`. C'est la forme utilisée par `Achat` (`Achat.class:214`, 13 arguments) ;
`ValidBR1` (`ValidBR1.class:414`) n'utilise que `New Consigne(prvt, qte)`.

**Lien avec `Sailig`/`Achat`** : l'écran de réception `Achat` (hérite de `SaiTableau`) stocke dans
`Sailig.AutresObj[Achat.Consignes]` une structure `Achat.boisson` (`NbCol`, `NbUnit`, `ccd As
Consigne`) par ligne de saisie (`Achat.class:203-222`). `AutresObj` est un `Variant[]` : les accès
`AutresObj[Consignes].ccd.cdepal`, `.ccd.code`, `.ccd.volume`… ne sont **pas résolus** par
`deps.py`. À l'enregistrement (`Achat.EnrRec`, `Achat.class:955-978`) la `Consigne` de la ligne
alimente `Fiches_ligregie` (droits) et trois `Achat.EnrConsigne` (palette, colis, unité) qui
appellent `consigne_montant`. À la validation du bon de réception (`ValidBR1.ValideSaisie`,
`ValidBR1.class:414-429`), une `Consigne` est recréée par ligne pour relire palettes/colis
(`recuppalette`/`recupcol`) et passer le montant `consigne.TotNHT` en écriture comptable sur le
compte `Fiches_Parametres.consfou`. `Sailig` détruit les objets de `AutresObj` à la suppression de
ligne (`Sailig.class:100-107`). `Facture` ne manipule pas `Consigne` : la facturation des consignes
passe par `facopt` (même lot) et `Fiches_ligcons`.

Nature globale : **calcul + SQL** (aucun accès GUI).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `cdepal` | var | Public |  | String | 5 |
| `nbpal` | var | Public |  | Integer | 6 |
| `cdecol` | var | Public |  | String | 7 |
| `nbcol` | var | Public |  | Integer | 8 |
| `cdeunit` | var | Public |  | String | 9 |
| `consigne` | property | Public |  | LPrix | 11 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 13-21 | Public | 1 | 7 | 0 | méthode spéciale |
| `LecCons` | 23-28 | Private | 2 | 3 | 0 |  |
| `consigne_montant` | 30-45 | Public | 2 | 13 | 1 |  |
| `recuppalette` | 47-62 | Public | 3 | 13 | 1 |  |
| `recupcol` | 64-79 | Public | 3 | 13 | 1 |  |
| `consigne_Read` | 81-88 | Private | 1 | 5 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(Optional cdepal, nbpal, cdecol, nbcol, cdeunit)`** [portée : nécessaire] [nature :
  calcul]. Recopie les cinq paramètres dans les membres publics homonymes. Les paramètres de
  `LPrix` et de `calculdroit1` sont consommés avant (voir vue d'ensemble).
- **`LecCons()`** (privée) [nature : calcul] — **code mort** (`unused` confirmé par `grep`) : corps
  vide après `If Me.opt Then Return`.
- **`consigne_montant(code, qte As Integer) As LTaxe`** [portée : nécessaire, `Achat.class:994`]
  [nature : calcul]. `SELECT * FROM Fiches_consigne WHERE code = …` ; renvoie `New LTaxe(prix ×
  qte, LTaxe.Consigne)` ou `New LTaxe(0, LTaxe.Consigne)` si le code est absent. Le paramètre est
  quoté par `Utils.db.Subst("&1", code)` puis **concaténé** dans la requête (équivalent à `&1`,
  mais idiome hors convention). ⚠️ `qte` est typé `Integer` : `Achat.EnrConsigne` passe un `Float`
  (`nb As Float`) et `consigne_Read` passe `Me.Qte` (Float) : une quantité fractionnaire est
  convertie en entier (troncature ou arrondi, à confirmer) avant multiplication.
- **`recuppalette(block, nlge As Variant) As Integer`** [portée : nécessaire,
  `ValidBR1.class:427`] [nature : calcul]. `nlge` entier → `Format(nlge, "000")`, sinon utilisé
  tel quel. `SELECT * FROM Fiches_ligcons, Fiches_consigne WHERE Fiches_consigne.code = codecons
  AND type = 'P' AND bloc = &1 AND numlig = &2`. Effet de bord : affecte `nbpal` (0 si absent) et
  renvoie la même valeur. Lit la première ligne seulement (une seule consigne palette par ligne).
- **`recupcol(block, nlge As Variant) As Integer`** [portée : nécessaire, `ValidBR1.class:428`]
  [nature : calcul]. Identique à `recuppalette` pour le type `C` ; affecte `nbcol`.
- **`consigne_Read() As LPrix`** (propriété `consigne`) [portée : nécessaire,
  `ValidBR1.class:429`] [nature : calcul]. `New LPrix(Σ consigne_montant(code, nb).Montant(Me,
  True).TotNHT.G)` pour (palette, `nbpal`), (colis, `nbcol`), (unité, `Me.Qte`). Trois `SELECT` à
  chaque lecture ; `ValidBR1` lit la propriété deux fois (`ValidBR1.class:429`), soit six requêtes.
  `Montant(Me, True)` ignore la quantité : le montant de la `LTaxe` est déjà prix × nombre.

## État global utilisé

- `Utils.db` (`Exec`, `Subst`).
- Hérité : `Me.opt` (drapeau « option boisson désactivée » de `calculdroit1`, voir
  CALCULDROIT1-A01), `Me.Qte`, `Me.Cpt`, taxes de `LPrix`.
- Tables : `Fiches_consigne`, `Fiches_ligcons` (noms en dur, sans clé `Cbase`). Ces tables sont
  créées par `modfichier.fichierboisson` et **absentes de `db_control.csv`** et de `Laurux01.sql`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `consigne_montant` : passer `code` en paramètre `&1` d'`Exec` au lieu du `Subst` + concaténation
  (SQL émis identique).
- `consigne_Read` : les trois appels peuvent passer par une boucle sur trois couples (code, nombre),
  sans changement de SQL.

### Commonalisation avec d'autres fichiers

- `recuppalette`/`recupcol` sont deux copies (seul le type `P`/`C` et le membre affecté changent) :
  helper privé `RecupNb(type, block, nlge)`. La même requête existe dans
  [`fourconsdroi`](../fourconsdroi.class/architecture.md) (`recuppalette`/`recupcoli`, code mort).
- Prix d'une consigne × nombre : même calcul dans `consigne_montant`, `fourconsdroi.calcons` (mort)
  et [`Saisiedecons.majcons`](../Saisiedecons.class/architecture.md) (`Val(nb) × resc!prix`, sans
  test `Available`) : fonction `Static` `Consigne.PrixUnitaire(code) As Float` réutilisable
  (équivalence à prouver par les tests de Saisiedecons).
- Clé `bloc` (date `dd.mm.yyyy` & numéro & fournisseur) construite à trois endroits
  (`Achat.EnrConsigne`, `ValidBR1.ValideSaisie`, `Saisiedecons.selectionbr`) : candidate à une
  fonction `Static` `Consigne.Bloc(dte, num, four)` (phase 3).

### Réduction de portée

Aucune : tous les membres `Public` sont utilisés par `Achat` ou `ValidBR1` (vérifié par `grep`).

### Séparation traitement / GUI

Sans objet (aucun accès GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer `Fiches_consigne`, `Fiches_ligcons` (et les colonnes `art_consp/consc/consb`,
  `art_nbcol/nbbou`, `cli_cons`) dans `db_control.csv` et les bases de référence au lieu de leur
  création à l'exécution par `modfichier`.
- Remplacer la clé texte `bloc` (concaténation date + numéro + fournisseur, `varchar(33)`) par des
  colonnes séparées indexées (`four`, `numrecpt`, `daterecpt`), cohérentes avec `Fiches_Ligrecpt`.
- Index sur `Fiches_ligcons(bloc, numlig)` et `Fiches_ligcons(num, type)`.
