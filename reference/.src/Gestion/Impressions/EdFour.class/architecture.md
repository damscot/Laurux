# EdFour — Architecture

> Source : `.src/Gestion/Impressions/EdFour.class` (+ `EdFour.form`)

## Vue d'ensemble

Écran « Liste des fournisseurs » (menus `Menu104` et `Menu108`, `Fmenu.class:1141` et `:1278`,
appelé sous la casse `EDfour`). Plage de codes fournisseur (`Cli` = `00000`, `Cli2` = `4099999` par
défaut ; noms de contrôles hérités d'`EdClient`), tri par code (`RadioButton1`, défaut) ou par nom
(`RadioButton2`), deux listes de sélection (`Colcli`, `Colcli2`), impression paysage
`~/tmp/Fours.pdf` (classe `Cclients`, `Level1F`/`Level2F`).

Même gabarit qu'[`EdFam`](../EdFam.class/architecture.md) (104 lignes communes) et
[`EdClient`](../EdClient.class/architecture.md) (141 lignes communes). Particularité : les boucles
sont écrites `Do … Loop Until rResult.MoveNext()` (équivalent du `Repeat … Until` du dépôt), et F2
dans un champ de plage ouvre la liste correspondante.

Groupes : `Cli`/`Cli2` dans `Cmpt` (tags 1/2), `Button2`/`Button3` dans `Btn` (tags 2/3) ;
`Button1` (aide, tag 1) n'est **pas** groupé.

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 33-44 | Public | 1 | 9 | 0 | méthode spéciale |
| `ToggleButton1_Click` | 46-78 | Public | 5 | 30 | 0 | handler GUI |
| `Colcli_KeyPress` | 83-103 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton2_Click` | 105-137 | Public | 5 | 30 | 0 | handler GUI |
| `Colcli2_KeyPress` | 142-162 | Public | 6 | 17 | 0 | handler GUI |
| `Btn_Click` | 164-180 | Public | 6 | 11 | 0 | handler GUI |
| `Cmpt_KeyPress` | 182-215 | Public | 10 | 28 | 0 | handler GUI |
| `Cmpt_GotFocus` | 220-226 | Public | 1 | 5 | 0 | handler GUI |
| `Colcli_Click` | 228-236 | Public | 1 | 7 | 0 | handler GUI |
| `Colcli2_Click` | 238-246 | Public | 1 | 7 | 0 | handler GUI |
| `Button2_Click` | 248-316 | Public | 7 | 66 | 0 | portée réductible ? |
| `Button1_Click` | 318-322 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : `Utils.Observers(Me)`, `Music.Load`, bornes par défaut, focus.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [handlers] [mixte] : bascule `Colcli` /
  `Colcli2` ; `SELECT * FROM Fiches_Four order by fo_code` (clé `TabFour` disponible) ; corps
  identiques au contrôle près (et à ceux d'`EdFam`, table près).
- **`Colcli_KeyPress()` / `Colcli2_KeyPress()`** [handlers] : Entrée → `*_Click`, F1 → aide,
  Échap/F2 → ferme.
- **`Colcli_Click()` / `Colcli2_Click()`** [handlers ; `replay_dynamic` : restent `Public`] :
  recopie du code dans `Cli`/`Cli2`.
- **`Btn_Click()`** [handler du groupe `Btn`] : tag 2 → `Button2_Click`, tag 3 → suppression du
  PDF et fermeture ; `Case 1` inatteignable.
- **`Cmpt_KeyPress()`** (CC 10) [handler] : Entrée/Tab alterne les champs ; F1 aide ; F2 ouvre la
  liste du champ (`ToggleButton1_Click`/`ToggleButton2_Click`).
- **`Cmpt_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Button2_Click()`** [portée : réductible — bouton groupé, appelé seulement par `Btn_Click`]
  [mixte] : `SELECT * FROM Fiches_Four WHERE fo_code >= &1 and fo_code <= &2 order by fo_code` (ou
  `fo_nom`) ; `fo_code` est `int(11)` : la comparaison avec les chaînes `00000`/`4099999` est
  numérique (MySQL, et SQLite par affinité de colonne). PDF paysage : `EnteteP`, `Level1F`,
  `Level2F` + `LinesP` par fournisseur, saut de page à 194 (`BasPageP`), puis **`BasPage`**
  (pied **portrait**, centré sur 206 mm) pour la dernière page (EDFOUR-A01), `Output`,
  `Visualiseur.Prog`. Résidus : `dte`, `Nbpage`, `Shell "cd …"`. Si aucun bouton radio n'était
  coché, `rResult` serait nul (impossible : `RadioButton1` vaut `True` dans le `.form`).
- **`Button1_Click()`** [handler] : `Doc.Open("Edfour")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `User.Home` ; `Utils.Observers`, `SetEditColor`, `Utils.db`, `Doc`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Do … Loop Until` → `Repeat … Until` (idiome du dépôt, comportement identique).
- Helpers privés pour les deux listes ; suppression du `Case 1`, `dte`, `Nbpage`, `Shell "cd"`.

### Commonalisation avec d'autres fichiers

- Socle « plage de codes + listes » avec [`EdFam`](../EdFam.class/architecture.md),
  [`EdClient`](../EdClient.class/architecture.md), [`EdDocs`](../EdDocs.class/architecture.md).
- Liste des fournisseurs (code, nom) : aussi construite par `Edcom`, `FFournisseur`, `Achat`…
  (notes du lot Gestion-1 : « recherches famille/fournisseur ») ; un `RemplitListeFournisseurs(col)`
  commun est à recenser en phase 3.

### Réduction de portée

- `Button2_Click` → `Private`.

### Séparation traitement / GUI

- `ListeFournisseurs(sDe, sA, sTri) As Result` séparée de l'impression.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à cet écran.
