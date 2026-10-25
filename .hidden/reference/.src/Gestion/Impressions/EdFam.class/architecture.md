# EdFam — Architecture

> Source : `.src/Gestion/Impressions/EdFam.class` (+ `EdFam.form`)

## Vue d'ensemble

Écran « Liste des familles » (menu `Menu54`, `Fmenu.class:811`). L'utilisateur choisit une plage
de codes famille (`Fam` = `00000`, `Fam2` = `ZZZZZ` par défaut), éventuellement par sélection dans
une liste (`Colfam`, `Colfam2`, ouvertes par `ToggleButton1`/`ToggleButton2`), puis imprime
`~/tmp/Famille.pdf` (classe `Cdocuments`, méthodes `Level1FAM`/`Level2FAM`).

Même gabarit qu'[`EdFour`](../EdFour.class/architecture.md) (104 lignes communes) et
[`EdClient`](../EdClient.class/architecture.md) (88 lignes communes) : plage de codes, deux listes
de sélection, boutons groupés `Btn` (impression, quitter), aide HTML.

Contrôles groupés : `Fam`/`Fam2` dans `Cmpt` (tags 1/2), `Button2`/`Button3` dans `Btn` (tags 2/3,
la casse `btn`/`Btn` est indifférente). `Button1` (aide) n'est pas groupé.

Nature : **mixte** (une requête de lecture, PDF, GUI).

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
| `Colfam_KeyPress` | 83-103 | Public | 6 | 17 | 0 | handler GUI |
| `ToggleButton2_Click` | 105-137 | Public | 5 | 30 | 0 | handler GUI |
| `ColFam2_KeyPress` | 142-162 | Public | 6 | 17 | 0 | handler GUI |
| `Btn_Click` | 164-180 | Public | 6 | 11 | 0 | handler GUI |
| `Cmpt_KeyPress` | 182-203 | Public | 7 | 18 | 0 | handler GUI |
| `Cmpt_GotFocus` | 208-214 | Public | 1 | 5 | 0 | handler GUI |
| `Colfam_Click` | 216-224 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 226-234 | Public | 1 | 7 | 0 | handler GUI |
| `Button2_Click` | 236-297 | Public | 7 | 59 | 0 | portée réductible ? |
| `Button1_Click` | 299-303 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [GUI] : `Utils.Observers(Me)`, `Music.Load`, valeurs par défaut, focus.
- **`ToggleButton1_Click()` / `ToggleButton2_Click()`** [handlers] [mixte] : bascule la liste
  `Colfam` / `Colfam2` ; à l'ouverture, `SELECT * FROM Fiches_Fam order by code_fam` (nom en dur,
  clé `TabFam`), colonnes « code » / « Intitulé ». Les deux corps sont identiques au contrôle près.
- **`Colfam_KeyPress()` / `ColFam2_KeyPress()`** [handlers] [GUI] : Entrée → `*_Click` ; F1 → aide ;
  Échap/F2 → ferme la liste.
- **`Colfam_Click()` / `Colfam2_Click()`** [handlers ; `replay_dynamic` : doivent rester `Public`,
  `ReplayObserver` les appelle par `Object.Call`] [GUI] : recopie le code dans `Fam`/`Fam2`, ferme
  la liste, passe au champ suivant.
- **`Btn_Click()`** [handler du groupe `Btn`] [GUI] : tag 2 → `Button2_Click()` ; tag 3 → suppression
  du PDF puis fermeture. Le `Case 1` est **inatteignable** (aucun contrôle du groupe n'a le tag 1).
- **`Cmpt_KeyPress()`** [handler] : Entrée/Tab alterne `Fam` ↔ `Fam2` ; F1 → aide.
- **`Cmpt_GotFocus()`** [handler] : `Utils.SetEditColor`.
- **`Button2_Click()`** [portée : réductible — `Button2` est groupé dans `Btn`, Gambas ne lève pas
  ce nom ; appelé seulement par `Btn_Click`] [mixte] : `SELECT * FROM Fiches_Fam WHERE code_fam >=
  &1 and code_fam <= &2 order by code_fam` ; PDF portrait : `EnteteN`, `Level1FAM`, `level2FAM`
  (code, intitulé, compte, compte de remise, coefficient `00.000`, code TVA, remise, écotaxe
  `0.00`), saut de page à 278 (`Baspage` + en-tête), `Lines`, `Baspage`, `Output`,
  `Visualiseur.Prog` ; sinon message « Aucune Famille ». Résidus : `dte`, `Shell "cd …"`.
- **`Button1_Click()`** [handler] : `Doc.Open("Edfam")`.

## État global utilisé

- `Start.Son`, `Start.Musique` ; `Utils.Observers`, `Utils.SetEditColor`, `Utils.db`, `Doc`.
- Membres : `Filename`, `Tab`, `son`, `PosY`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Un helper privé `BasculeListe(col As ColumnView)` pour `ToggleButton1/2_Click` et
  `ClavierListe(col, champ)` pour les deux `KeyPress` (handlers conservés, EDFAM-004).
- Supprimer `Case 1` de `Btn_Click`, `dte`, `Shell "cd"`, `With Utils` superflus (EDFAM-002).

### Commonalisation avec d'autres fichiers

- Socle « édition d'une plage de codes » partagé avec [`EdFour`](../EdFour.class/architecture.md),
  [`EdClient`](../EdClient.class/architecture.md) et [`EdDocs`](../EdDocs.class/architecture.md) :
  module commun (par ex. `PlageCodes`) avec `RemplitListe(col, sql, champCode, champLibelle)`,
  `ChoixListe(col, champ, suivant)` et la navigation clavier. Les `.form` et les noms de handlers
  restent inchangés : seuls les corps délèguent au module.
- Liste de familles : aussi construite dans d'autres écrans (`Famille`, `Articles`, recherches de
  famille relevées au lot Gestion-1) ; recenser en phase 3.

### Réduction de portée

- `Button2_Click` → `Private` (pseudo-handler d'un bouton groupé). Les `*_Click` des grilles
  restent `Public`.

### Séparation traitement / GUI

- `ListeFamilles(sDe, sA) As Result` sans contrôle ; le handler imprime.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à cet écran.
