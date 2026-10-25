# EdnsaisisT — Architecture

> Source : `.src/Gestion/Stock/Inventaires/Tournant/EdnsaisisT.class`

## Vue d'ensemble

Édition PDF des **produits non saisis** de l'inventaire (menu 97, [`Fmenu.class:1103`](../../../../../Communs/Fmenu.class/architecture.md), `EdnsaisisT.Show`) : lignes de
`Fiches_InvT` avec `inv_comptee = 0`, avec code, désignation, stock théorique `inv_qtestock` et
sa valorisation au PA (`art_paht`) et au PMP actuels, plus les totaux. C'est la liste des
articles que [ValidinvT](../ValidinvT.class/architecture.md) mettra à zéro (option par défaut) ou laissera en l'état. Fichier `~/tmp/NsaisisT.pdf`,
gabarit `Cstocks` (`Level1NS`/`Level2NS`/`Level3NS`), pagination à 283 mm.

Jumeau : [Ednsaisis](../../Fin-annee/Ednsaisis.class/architecture.md) (93 % de lignes communes, 7 fonctions homonymes sur 7). Les fonctions `Level1`,
`Level2`, `Level3` (dessin `Draw` de l'ancienne impression) ne sont plus appelées.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 27 |
| `son` | var | Private |  | Integer | 28 |
| `Decm` | var | Private |  | Integer | 29 |
| `PosY` | var | Private |  | Integer | 30 |
| `Coulfond` | var | Private |  | New String[] | 31 |
| `dte` | var | Private |  | String | 32 |
| `pdf` | var | Private |  | Cstocks | 33 |
<!-- /AUTO:declarations -->

- `dte` (membre `String`) : date de l'inventaire formatée `dd.mm.yyyy` ; `Coulfond` : affecté,
  jamais lu.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-57 | Public | 4 | 17 | 0 | méthode spéciale |
| `Button1_Click` | 59-135 | Public | 7 | 74 | 0 | handler GUI |
| `Level1` | 138-157 | Public | 1 | 18 | 0 | portée réductible ? |
| `Level2` | 160-172 | Public | 1 | 11 | 0 | portée réductible ? |
| `Level3` | 175-193 | Public | 1 | 17 | 0 | portée réductible ? |
| `button2_Click` | 195-200 | Public | 3 | 4 | 0 | handler GUI |
| `Button4_Click` | 202-206 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte]. `Utils.Observers(Me)`,
  `Try SELECT * FROM Fiches_InvT` (littéral) → `dte = Format(inv_date, "dd.mm.yyyy")` et titre ; table
  vide ou absente → message « aucun inventaire » et `Me.Close` dans le constructeur.
  ⚠️ Test `If Not Error And rResult.Available` sans court-circuit : table absente (état normal
  après `ValidinvT`) → `rResult` Null → erreur non gérée à l'ouverture (EDNSAISIST-A01).
- **`Button1_Click()`** [portée : nécessaire (handler, « Imprimer »)] [nature : mixte].
  `SELECT * FROM Fiches_InvT WHERE inv_comptee = 0` sans `ORDER BY` ; par ligne `SELECT * FROM
  Fiches_Art WHERE art_code` sans `Available`. La quantité est formatée par `Utils.CDec`, complétée
  par des espaces si `art_dec < 3` (alignement), passée par `Utils.cpoint` puis relue par `Val`
  pour la valorisation (tolérance de `Val` aux espaces finaux à confirmer en phase 2). Totaux
  cumulés en chaînes `"0.00"`. Aucune ligne → « Aucun article ». `Nbpage`, `Nlig` inutiles,
  `Shell "cd ~"` sans effet. Partie extractible : lecture et calcul.
- **`Level1()`, `Level2(…)`, `Level3(…)`** [portée : réductible — **code mort**] [nature : GUI].
  Dessin `Draw` jamais appelé (signalé `unused` par `deps.py`, confirmé par grep).
- **`button2_Click()`** [handler] [GUI]. Supprime le PDF, ferme.
- **`Button4_Click()`** [handler] [GUI]. Aide `Doc.Open("Nsaisis")`.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.db`, `Utils.CDec`, `Utils.cpoint`, `Utils.PointBase`,
  `Utils.Coulfd`, `Utils.Observers` ; `Cstocks`, `Visualiseur`, `Doc`.
- Tables (littéraux) : `Fiches_InvT`, `Fiches_Art` (lecture seule).

## Propositions d'amélioration

### Réécriture / refactorisation

- Calculer la valorisation sur la quantité numérique (`inv_qtestock`) et ne garder le formatage
  avec espaces que pour l'affichage (même texte produit, à vérifier par replay).

### Commonalisation avec d'autres fichiers

- Module `Inventaire` (voir [Geninv](../../Fin-annee/Geninv.class/architecture.md)) : `DateInv`, `Lignes(sType, 0)`, `Libelle` ; édition
  des non saisis paramétrée par le type, partagée avec `Ednsaisis`.
- Squelette d'édition paginée `Cstocks` commun avec `Ecarts*` (62 % de lignes communes) et
  `Edinv`.

### Réduction de portée

- `Level1/2/3` : code mort (suppression).

### Séparation traitement / GUI

- `LignesNonSaisies()` sans contrôle ; mise en page dans le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Prix de valorisation figés à la génération (voir Ecarts).
