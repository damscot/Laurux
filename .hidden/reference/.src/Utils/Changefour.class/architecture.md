# Changefour — Architecture

> Source : `.src/Utils/Changefour.class`

## Vue d'ensemble

`Changefour` est l'**écran de changement du fournisseur principal** (`Fiches_Art.art_four`) des
articles, ouvert depuis le menu Gestion (`Fmenu.class:2345`, `Changefour.ShowModal()`). Il propose
les mêmes quatre modes que [`Changefam`](../Changefam.class/architecture.md), dont il est issu
(l'en-tête du fichier porte d'ailleurs encore le nom `ChangeFam.class`) :

1. **Un article** : `Code` + nouveau fournisseur `Nfour` → `Change("Btn")`.
2. **Liste d'articles** (case `Liste`) : table temporaire `CFour` remplie par `AjoutArt`, traitée par
   `Change3`.
3. **Fournisseur entier** : tous les articles de `Afour2` passent chez `Nfour2` (`Change2`).
4. **Fichier CSV** `code;fournisseur` (case `Fichier`, formulaire dynamique) → `Change("Bouton2")`.

Contrairement à `Changefam`, seule la table `Fiches_Art` est modifiée (pas d'historique), sans
verrouillage. Le seul `Cbase.Table` est `TabFour` dans `art_man`.

Nature globale : **mixte** (traitements qui lisent directement les contrôles).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 29 |
| `Bval` | var | Public |  | String | 30 |
| `Tab` | var | Private |  | String | 32 |
| `$hform` | var | Private |  | Form | 33 |
| `hText` | var | Private |  | TextBox | 34 |
| `hbutton1` | var | Private |  | Button | 35 |
| `hbutton2` | var | Private |  | Button | 36 |
| `hbutton3` | var | Private |  | Button | 37 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 42-48 | Public | 1 | 5 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 50-105 | Public | 12 | 44 | 0 | handler GUI |
| `art_man` | 113-130 | Public | 2 | 13 | 0 | portée réductible ? |
| `AjoutArt` | 132-150 | Public | 4 | 16 | 0 | portée réductible ? |
| `SelectionArt` | 152-163 | Public | 2 | 9 | 0 | portée réductible ? |
| `SelectionFour` | 168-183 | Public | 2 | 13 | 0 | portée réductible ? |
| `SelectionFour2` | 185-200 | Public | 2 | 13 | 0 | portée réductible ? |
| `SelectionFour3` | 202-218 | Public | 2 | 14 | 0 | portée réductible ? |
| `fourman` | 223-253 | Public | 9 | 27 | 0 | portée réductible ? |
| `Btn_Click` | 255-292 | Public | 9 | 30 | 0 | handler GUI |
| `Change` | 297-340 | Public | 11 | 41 | 0 | portée réductible ? |
| `Change2` | 345-380 | Public | 7 | 33 | 0 | portée réductible ? |
| `Change3` | 385-414 | Public | 6 | 27 | 0 | portée réductible ? |
| `Liste_Click` | 416-436 | Public | 2 | 17 | 0 | handler GUI |
| `Fichier_Click` | 438-482 | Public | 3 | 42 | 0 | handler GUI |
| `Bouton1_Click` | 484-500 | Public | 2 | 15 | 0 | handler GUI |
| `Bouton2_Click` | 502-535 | Public | 7 | 31 | 0 | handler GUI |
| `Bouton3_Click` | 537-542 | Public | 1 | 4 | 0 | handler GUI |
| `Button9_Click` | 544-551 | Public | 2 | 6 | 0 | handler GUI |
| `Button9_KeyPress` | 553-557 | Public | 4 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et clavier

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Music.Load`, centrage,
  `Utils.Observers`.
- **`Cmpt_KeyPress()`** (CC 12) [portée : nécessaire, handler du groupe `Cmpt`] [nature : GUI].
  Copie de `Changefam.Cmpt_KeyPress` : seul le `Tag 1` (`Code`) agit (lecture article, code-barres
  `*`) ; les cas 2, 4, 5 ne font qu'un `Stop Event` (appels `four_Man*` commentés) et le `Tag 3`
  (`Nfour`) n'a pas de branche. Variable `b` jamais mise à 1 (branches mortes).
  ⚠️ Conséquence : un fournisseur saisi au clavier n'est **jamais contrôlé** (libellé non affiché,
  existence non vérifiée) ; seul le passage par la liste `TriCpt` appelle `fourman`.
- **`Btn_Click()`** [portée : nécessaire, handler du groupe `Btn`] [nature : GUI]. Tags 1 → article,
  2/4/5 → `SelectionFour`/`SelectionFour2`/`SelectionFour3`, 3 → `Change("Btn")` ou `Change3`,
  6 → `Change2`, 8 → fermeture. Double `Stop Event` au cas 3 (redondant).

### Lecture et sélection

- **`art_man()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Art LEFT JOIN
  Cbase.Table("TabFour") ON fo_code = art_four WHERE art_code = &1` ; remplit `Desg`, `Afour`,
  `Libelfour`. Rien si l'article est inconnu (pas de message). `With utils` inutile.
- **`SelectionArt()`** [portée : réductible] [nature : GUI]. `TriArticles(…, "Fournisseur", …, Me)`.
- **`SelectionFour()` / `SelectionFour2()` / `SelectionFour3()`** [portée : réductible] [nature : GUI].
  Trois copies : ouvrent `TriCpt(TriCpt.Fournisseur, TriCpt.Sans_Solde, Me)`, recopient `Bval` dans
  `NFour`/`AFour2`/`NFour2`, puis `fourman("1"|"2"|"3")`. `SelectionFour3` remet
  `Variables.bsel` à `False` (sans effet : c'est `Me.Bsel` qui est lu).
  ⚠️ `TriCpt` ne remet pas `Bsel` à `False` à l'ouverture (seul `TriArticles` le fait) : après une
  première sélection, une annulation recopie l'**ancienne** valeur `Bval`.
- **`fourman(Org)`** [portée : réductible] [nature : mixte]. Lit `fo_nom` dans `Fiches_Four` sans
  tester `Available` ; un fournisseur inconnu passe par le `Catch` (« Ce fournisseur n'existe pas »).

### Liste d'articles

- **`Liste_Click()`** [portée : nécessaire, handler] [nature : mixte]. Bascule `Listbart`/`Button9`,
  `DROP TABLE IF EXISTS CFour` puis `CREATE TEMPORARY TABLE CFour (codeart PK, afour, nfour)`.
  Contrairement à `Changefam`, `listBart.Text` n'est pas vidé.
- **`Button9_Click()` / `Button9_KeyPress()`** [portée : nécessaire, handlers] [nature : GUI].
- **`AjoutArt()`** [portée : réductible] [nature : mixte]. `INSERT INTO CFour`. En cas de doublon :
  ⚠️ `SELECT * FROM CFour WHERE code = &1` sur une colonne **inexistante** (`codeart`) → erreur SQL
  propagée par `DB_Connection.Exec` au lieu du message « déjà saisi ».

### Traitements

- **`Change($hOrg)`** (CC 10) [portée : réductible] [nature : mixte]. Si `Code` et `Nfour` sont
  renseignés : `SELECT` de l'article puis, **dans une boucle `Repeat` sur ce résultat d'une ligne**,
  `UPDATE Fiches_Art SET art_four = &2 WHERE art_code = &1`. Messages uniquement si `$hOrg = "Btn"`
  (silencieux en import fichier). Pas de contrôle d'existence du fournisseur.
- **`Change2()`** [portée : réductible] [nature : mixte]. `UPDATE Fiches_Art SET art_four = Nfour2
  WHERE art_four = Afour2` (précédé d'un `SELECT` de test). ⚠️ Messages d'erreur **inversés** :
  `Afour2` vide → « saisir le nouveau fournisseur » ; `Nfour2` vide → « saisir l'ancien
  fournisseur » avec focus sur `Nfour` (cadre du haut).
- **`Change3()`** [portée : réductible] [nature : mixte]. Parcourt `CFour` et met à jour
  `art_four` pour chaque article. La colonne `afour` n'est jamais utilisée.

### Import par fichier

- **`Fichier_Click()`, `Bouton1_Click()`, `Bouton3_Click()`** [portée : nécessaire, handlers]
  [nature : GUI] : **identiques** à `Changefam`.
- **`Bouton2_Click()`** [portée : nécessaire, handler dynamique] [nature : mixte]. Lit
  `code;fournisseur` ; vérifie le fournisseur dans `Fiches_Four` ; `Change("Bouton2")`. Une ligne
  sans `;` provoque un dépassement d'indice (`Lig2[1]`). Variable mal nommée `Rfams`.

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.Find_cbarre`, `Cbase.Table("TabFour")`.
- `Start.Musique`, `Start.son`, `Variables.bsel` (écrit sans effet).
- Table temporaire de session `CFour`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `SelectionFour/2/3` → un helper `ChoisirFournisseur(hSaisie, sOrg)`.
- `Change` : remplacer la boucle `Repeat` sur un résultat d'une ligne par un simple test
  `Available` (l'article est unique par clé primaire : même SQL émis).
- `Cmpt_KeyPress` : supprimer `b` et les cas vides commentés.

### Commonalisation avec d'autres fichiers

- [`Changefam`](../Changefam.class/architecture.md) : 247 lignes de code identiques (similarité
  0,52). Identiques : `Fichier_Click`, `Bouton1_Click`, `Bouton3_Click`, `Button9_*`, `Btn_Click`
  (à l'appel près), `SelectionArt`, `Liste_Click`, `AjoutArt`, cas 1 de `Cmpt_KeyPress`. Voir
  CHANGEFAM-005 (classe commune import CSV + liste temporaire).
- `art_man` recoupe les lectures d'article de nombreux écrans (`Calcstock.Art_man`,
  `Changefam.art_man`) : candidat à une fonction de lecture commune (phase 3).

### Réduction de portée

- `art_man`, `AjoutArt`, `SelectionArt`, `SelectionFour*`, `fourman`, `Change`, `Change2`, `Change3`
  : aucun appelant externe → `Private`.
- À conserver `Public` : `Bsel`/`Bval` (écrits par `TriArticles`/`TriCpt` via
  `Object.SetProperty`), `Cmpt_KeyPress`, `Btn_Click` (handlers de groupes).

### Séparation traitement / GUI

- Extraire `ChangeFournisseur(code, four)`, `ChangeFournisseurGlobal(ancien, nouveau)` et
  `TraiterListe()` (SQL pur), appelés par `Change`, `Change2`, `Change3`, `Bouton2_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Clé étrangère `Fiches_Art.art_four` → `Fiches_Four.fo_code` : l'existence du fournisseur serait
  garantie par la base.
- Les fournisseurs secondaires (`Fiches_CdFour`) ne sont pas concernés par ce traitement : un modèle
  article ↔ fournisseurs unique éviterait la double source.
