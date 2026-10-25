# TriMo — Architecture

> Source : `.src/Affichages/TriMo.class`

## Vue d'ensemble

`TriMo` est une ancienne **fenêtre de sélection d'une main d'œuvre** (`Fiches_Mo` : code,
désignation, valeurs HT et TTC). Elle est **morte** : aucun `New TriMo`, aucune chaîne `"TriMo"`
(`Object.New`, `Class.Load`) dans le projet (signal `jamais_reference`, vérifié par grep). La
sélection de main d'œuvre passe aujourd'hui par
[`TriArticles`](../TriArticles.class/architecture.md) avec `TriArticle = "mo_code"`
(`Prodcomposes:673`).

Le seul homonyme est la méthode `Facture.TriMo()` (`Facture.class:2832`), qui dimensionne la grille
`ColMo` de `Facture` et n'a aucun lien avec cette classe.

Protocole (historique) : `_new(sOrg)` ; pour `sOrg = "Prodcomposes"`, `colmo_Click` écrivait
`Variables.Bsel = True` et `Variables.$Codemo = <code>` puis fermait. `Variables.$Codemo` n'est lu
nulle part (VARIABLES-002).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `MoTable` | var | Private |  | New String[4] | 3 |
| `Origine` | var | Private |  | String | 4 |
| `lg` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-18 | Public | 1 | 9 | 0 | méthode spéciale |
| `trimo` | 20-32 | Public | 1 | 11 | 0 | portée réductible ? |
| `Colmo_Data` | 34-45 | Public | 2 | 10 | 0 | handler GUI |
| `Deb1` | 47-55 | Public | 2 | 7 | 0 | portée réductible ? |
| `colmo_Click` | 57-68 | Public | 2 | 8 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(sOrg)`** [portée : nécessaire (spéciale)] [nature : GUI] : `Utils.Observers(Me)`, `lg`
  (calculé, jamais utilisé : pas de pagination), centrage, mémorisation de l'origine, `trimo()`,
  `Deb1()`, curseur en première ligne.
- **`trimo()`** [portée : réductible] [GUI] : 4 colonnes (code, intitulé, PV HT, PV TTC alignés à
  droite) calées sur les en-têtes `CO`, `INT`, `PVHT`, `PVTTC`. Nom identique à la classe (casse
  près) : source de confusion.
- **`Colmo_Data(Row, Column)`** [handler] [GUI] : `Utils.rs4.MoveTo(Row)` et lecture du champ ;
  `MoTable` réécrit à chaque cellule.
- **`Deb1()`** [portée : réductible] [mixte] : `Utils.Base4(Colmo, "select * from Fiches_Mo order by
  mo_code")`, ou `… where mo_tempmont <> '1' …` pour `Prodcomposes` (MO hors temps de montage).
  Table **en dur** (pas de `Cbase.Table("TabMo")`), toute la table chargée (pas de `LIMIT`).
- **`colmo_Click()`** [handler, rejoué par `Object.Call` : `Public`] [GUI] : protocole ci-dessus.
  Aucune touche gérée (pas de `KeyPress`), pas de filtre.

## État global utilisé

- `Utils.rs4` (via `Utils.Base4`), partagé avec d'autres écrans (dont la grille `ColMo` de
  `Facture`).
- `Variables.Bsel`, `Variables.$Codemo` (écrits seulement).

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : la classe est morte. Sa suppression (couple `TriMo.class` + `TriMo.form`) est une
  anomalie soumise à validation (TRIMO-A01), à faire avec la suppression de `Variables.$Codemo`
  (VARIABLES-002).

### Commonalisation avec d'autres fichiers

- Fonction remplacée par `TriArticles` en mode `"mo_code"` (avec filtre et pagination) ; le
  filtre `mo_tempmont <> '1'` propre à `Prodcomposes` n'y est **pas** repris (à signaler si la
  suppression est validée : comportement déjà actuel de `Prodcomposes`).

### Réduction de portée

- Sans objet (classe morte) ; `trimo`, `Deb1` seraient réductibles.

### Séparation traitement / GUI

- Sans objet.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune.
