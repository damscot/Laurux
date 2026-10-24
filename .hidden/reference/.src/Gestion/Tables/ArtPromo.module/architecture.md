# ArtPromo — Architecture

> Source : `.src/Gestion/Tables/ArtPromo.module`

## Vue d'ensemble

`ArtPromo` est un **module d'accès** à la table `Fiches_ArtPromo` (articles d'une promotion :
clé primaire `(code_promo, code)`, colonnes `libelle`, `pmp`, `pht`, `pttc`, `qte`) : test
d'appartenance d'un article à une promotion, lecture du prix HT/TTC et du libellé promotionnels,
cumul de la quantité vendue en promotion.

Nature : **calcul / SQL pur**, sans GUI ni état de module. Chaque fonction émet la même requête
`SELECT * FROM <TabArtPromo> where code = &1 and code_promo = &2` (paramétrée, `Cbase.Table`).
La clé primaire garantit au plus une ligne.

Le code de la promotion « en cours » n'est pas déterminé ici : chaque appelant le calcule lui-même
(`Articles.Form_Open`, `Caisse.class:218`, `Facture.class:508` : première ligne de `Fiches_Promo`
telle que `datedeb <= aujourd'hui <= datefin`).

## Déclarations

<!-- AUTO:declarations -->
_Aucune déclaration de niveau classe/module._
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `art_Promo` | 5-14 | Public | 2 | 7 | 4 |  |
| `Prix_Promo` | 16-23 | Public | 2 | 5 | 2 |  |
| `Prix_Promottc` | 25-32 | Public | 2 | 5 | 1 |  |
| `Intitule_Promo` | 34-41 | Public | 2 | 5 | 1 |  |
| `Maj_qtemoins` | 45-58 | Public | 4 | 11 | 1 |  |
| `Maj_qteplus` | 62-75 | Public | 4 | 11 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`art_Promo(Code_art, Code_Promo) As String`** [portée : nécessaire] [nature : calcul/SQL].
  Renvoie l'appartenance de l'article à la promotion. ⚠️ La variable locale est un `Boolean`
  (initialisée par `Cprom = 1`), mais la fonction est déclarée `As String` : Gambas convertit `True`
  en `"T"` et `False` en `""` (vérifié avec `gbs3`). Les appelants s'en accommodent car ils
  reconvertissent en `Boolean` (`Apromo = …` dans `Articles`, `Caisse`, `Facture`) ou testent la
  chaîne dans un `If` (`TarArt.class:123`) : chaîne non vide = vrai.
- **`Prix_Promo(Code_art, Code_Promo) As String`** [nécessaire] : `pht` (prix HT promotionnel) ;
  renvoie `""` (aucun `Return`) si l'article n'est pas dans la promotion. Appelants : `Caisse`
  (590, 1120), `TarArt` (124, appelé seulement après `art_Promo` vrai).
- **`Prix_Promottc(…) As String`** [nécessaire] : `pttc` ; appelant : `Caisse` (592, 1122).
- **`Intitule_Promo(…) As String`** [nécessaire] : `libelle` ; appelant : `Caisse` (1125).
- **`Maj_qtemoins(Code_art, Code_Promo, qte As Float) As String`** [nécessaire] : relit la ligne,
  `Qstock = qte − Qte` (`Null` → 0 par `Try`), puis `UPDATE <TabArtPromo> SET qte = &2 WHERE code =
  &1 and code_promo = &3`. Appelant : `Facture` (9345, 9436 : suppression ou modification de ligne).
  Ne renvoie rien malgré `As String`.
- **`Maj_qteplus(…) As String`** [nécessaire] : idem avec `+` (quantité vendue en promotion).
  Appelants : `Caisse` (7418, 7465), `Facture` (9266, 9303, 9391). ⚠️ Lecture puis écriture séparées,
  sans verrou ni transaction : deux postes de caisse qui vendent le même article promu en même temps
  peuvent perdre une mise à jour (ARTPROMO-A01).

## État global utilisé

- `Utils.db`, `Cbase.Table("TabArtPromo")`. Aucun état de module.

## Propositions d'amélioration

### Réécriture / refactorisation

- Helper privé `LitPromo(sCode, sPromo) As Result` pour les six `SELECT` identiques.
- `Maj_qtemoins`/`Maj_qteplus` → helper privé `MajQte(sCode, sPromo, fDelta)` ; signatures publiques
  conservées.
- Types de retour : `art_Promo As Boolean` (tous les appelants convertissent déjà en booléen) ;
  `Maj_qte*` en procédures (`Sub` sans type de retour).

### Commonalisation avec d'autres fichiers

- Nouvelle fonction `PromoDuJour() As String` (code de la première promotion active, `""` sinon),
  reprenant la requête dupliquée de [`Articles`](../Articles.class/architecture.md) (`Form_Open`),
  `Caisse` (ligne 218) et `Facture` (ligne 508).
- `Fpromo`, `FpromoArt`, `StatPromo`, `EtiqPromo` lisent aussi `Fiches_Promo`/`Fiches_ArtPromo`
  directement : candidats pour passer par ce module (phase 3).

### Réduction de portée

- Aucune : les six fonctions ont des appelants externes.

### Séparation traitement / GUI

- Sans objet (aucun accès GUI).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index secondaire `(code)` sur `Fiches_ArtPromo` si des recherches par article seul apparaissent
  (aujourd'hui la clé `(code_promo, code)` couvre toutes les requêtes du module).
- Historiser les ventes promotionnelles dans une table de mouvements plutôt que dans un cumul `qte`
  modifié en place.
