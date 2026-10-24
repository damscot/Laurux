# Ccomptes — Architecture

> Source : `.src/Compta/Ccomptes.module`

## Vue d'ensemble

Module d'aide à l'affichage du **plan comptable** (`Fiches_Comptes`) dans la `GridView` `Colco` de
l'écran [`FComptes`](../Tables/FComptes.class/architecture.md), son unique appelant. Il fournit :

- le rendu d'une cellule (`Colco_Data`) à partir du résultat global `Utils.rs3` ;
- le calage des largeurs de colonnes sur les `TextBox` d'en-tête (`Tris`) ;
- le chargement de la liste filtrée par préfixe et triée (`Deb2` croissant, `Deb3` décroissant).

Six autres variantes (`Deb4`…`Deb9`, filtre par type de compte, pagination `limit`, exclusion des
collectifs ou des comptes de trésorerie) n'ont **aucun appelant** : code mort.

Nature globale : **GUI** (grille) avec SQL concaténé délégué à `Utils.Base3`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Cotable` | var | Private | oui | New String[7] | 3 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Colco_Data` | 5-39 | Public | 6 | 30 | 1 |  |
| `Tris` | 41-52 | Public | 4 | 10 | 1 |  |
| `Deb2` | 54-59 | Public | 1 | 4 | 1 |  |
| `Deb3` | 61-66 | Public | 1 | 4 | 1 |  |
| `Deb4` | 68-77 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb5` | 79-88 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb6` | 90-99 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb7` | 101-110 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb8` | 114-123 | Public | 2 | 8 | 0 | portée réductible ? |
| `Deb9` | 125-134 | Public | 2 | 8 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`Colco_Data(Colco, Row, Column)`** [portée : nécessaire, `FComptes.Colco_Data`]
  [nature : GUI]. Remplit `CoTable[0..4]` à chaque appel (`compte_cc`, `intitule_cc`, `type_cc`,
  `solde`, `coll_cc`), se place sur `Utils.rs3.MoveTo(Row)` et affiche `Str(champ)`. Couleur de
  fond selon `Start.LocalSettings["/Soc<XX>/Coul_fen"]` (`&HFAFAFA` ou `&HF9F9BD`), texte noir.
  Colonne 2 centrée ; colonne 3 (solde) formatée `0.00` via `Utils.cpoint`, alignée à droite.
  Remarques : le tableau `CoTable` a 7 cases pour 5 utilisées ; `Fnt` est calculée mais jamais
  appliquée (ligne `Font` commentée) ; si `Str(...)` échoue (`Try`), `CoulB`/`CoulF` restent à 0
  (fond noir, texte noir) — cas théorique (à confirmer).
- **`Tris(Colco, CO, Intit, Ty, Sol, Co2)`** [portée : nécessaire] [nature : GUI]. 5 colonnes,
  largeurs recopiées des `TextBox` (les 3 dernières sous `Try`).
- **`Deb2(Colco, Tab, Tri, Sel)`** / **`Deb3(...)`** [portée : nécessaire] [nature : mixte].
  `Utils.Base3(Colco, "select * from <Tab> where <Tri> like "<Sel>%" order by <Tri> [Desc]")`
  puis `Colco.Refresh`. `Tab` = `Cbase.Table("TabComptes")`, `Tri` = `cast(compte_cc AS char)` ou
  `intitule_cc` (fournis par `FComptes`). `Sel` est la saisie utilisateur, **concaténée** entre
  guillemets doubles ; `FComptes` refuse les touches `"`, `&`, `'` et `\` avant l'appel, ce qui
  limite le risque d'injection sans le supprimer (collage, à confirmer).
- **`Deb4`…`Deb9`** [portée : réductible, code mort] [nature : mixte]. Variantes avec
  `type_cc like "<Type>%"`, `coll <> 1` ou `comptr_cc = 0`, `limit NbEnreg, Nb`. `Deb6`/`Deb7` ont
  une clause `... or ...` sans parenthèses dont la priorité est douteuse. Sans appelant.

## État global utilisé

- `Utils.rs3` (résultat partagé, écrit par `Utils.Base3`, lu par `Colco_Data`) : tout autre écran
  ouvert simultanément qui utilise `Base3` écrase ce résultat.
- `Utils.Base3`, `Utils.cpoint`, `Start.LocalSettings`, `Start.Societe`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Deb4`…`Deb9`, `Fnt` et réduire `CoTable` (CCOMPTES-002).
- `Deb2`/`Deb3` → un helper privé `Charge(Colco, Tab, Tri, Sel, sOrdre)` ; les signatures
  `Public` restent (CCOMPTES-003).
- `CoTable` initialisé une seule fois (constante `["compte_cc", …]`) au lieu de 5 affectations par
  cellule.
- Paramétrer `Sel` : `like &1` avec `Sel & "%"` (CCOMPTES-004).

### Commonalisation avec d'autres fichiers

- `Utils.Base`/`Base2`/`Base3`/`Base4` + résultat global : même idiome que
  [`Cecrit`](../Cecrit.module/architecture.md) (mort) ; voir UTILS-005.
- Couleur de fond `Coul_fen` (`&HFAFAFA`/`&HF9F9BD`) : 36 fichiers lisent `Coul_fen` et 74
  occurrences de `&HF9F9BD` existent ; un helper `LCoul.FondGrille()` (voir
  [`LCoul`](../../Utils/LCoul.class/architecture.md)) les factoriserait (CCOMPTES-005).
- Module à un seul appelant : son contenu pourrait être intégré à `FComptes` (CCOMPTES-006).

### Réduction de portée

- `Deb4`…`Deb9` : suppression (code mort) plutôt que réduction.
- `Colco_Data`, `Tris`, `Deb2`, `Deb3` : nécessaires tant que le module existe.

### Séparation traitement / GUI

- Construction du SQL (`Deb2`/`Deb3`) séparable du remplissage de la grille : fonction pure
  `RequeteListe(Tab, Tri, Sel, bDesc) As String`, testable en gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `compte_cc` est un `int(11)` trié par `cast(compte_cc AS char)` : un tri lexical sur entier
  empêche l'usage de l'index. Un `compte_cc` en `VARCHAR` (ou une colonne de tri dédiée) le
  permettrait.
