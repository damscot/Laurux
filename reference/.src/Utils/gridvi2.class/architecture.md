# gridvi2 — Architecture

> Source : `.src/Utils/gridvi2.class`

## Vue d'ensemble

`gridvi2` est une **ancienne variante** de [`gridvi`](../gridvi.class/architecture.md) : même
onglet « Statistiques » construit dynamiquement dans un `TabStrip`, même tableau comparatif
annuel (12 mois + TOTAL × 4 exercices × C.A / Quantité / Marge), pour les types `F`, `A`, `M`, `C`.

**La classe n'a aucun appelant** : `grep -rni 'gridvi2' .src` ne trouve que le fichier lui-même
(ni `New gridvi2`, ni `As gridvi2`, ni nom de classe en chaîne, ni `.form`). Elle a été introduite
avec `gridvi` et `gridv` (commit `d5bea4ab` « Ajout gridvi & gridv ») puis supplantée par `gridvi`.
C'est du **code mort**.

Différences notables avec `gridvi` (pour mémoire) : pas de bouton « Calcul » ni « Familles »
(`bouton_Click` n'est donc jamais déclenché comme handler), lignes de facture `A`/`E` au lieu de
`A`/`M`, pas de lecture des archives `…M`, BL lus seulement pour la période en cours/précédente,
formats d'arrondi selon `/Soc<XX>/Prxdec`, sommes ligne à ligne en Gambas (`CFloat`) au lieu de
`SUM` SQL, dates passées en `yyyymmdd`, sélection de détail par `MouseDown`/`MouseUp`.

Nature : mixte (SQL + écriture dans les cellules), comme `gridvi`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$grdv` | var | Private |  | GridView | 3 |
| `$lab` | var | Private |  | Label | 4 |
| `$sdec` | var | Private |  | String | 5 |
| `$scode` | var | Private |  | String | 6 |
| `$stype` | var | Private |  | String | 7 |
| `$ideb` | var | Private |  | Integer | 8 |
| `$ifin` | var | Private |  | Integer | 9 |
| `Prxdec` | var | Private |  | Boolean | 10 |
| `code` | property | Public |  | String | 13 |
| `dec` | property | Public |  | String | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-82 | Public | 6 | 54 | 0 | méthode spéciale |
| `bouton_Click` | 84-205 | Public | 20 | 98 | 0 | portée réductible ? |
| `requete` | 207-239 | Private | 12 | 28 | 0 |  |
| `affent` | 241-271 | Private | 7 | 27 | 0 |  |
| `razcol` | 273-290 | Public | 5 | 15 | 0 | portée réductible ? |
| `grdv_MouseDown` | 292-296 | Public | 1 | 3 | 0 | handler GUI |
| `grdv_MouseUp` | 298-412 | Public | 19 | 93 | 0 | handler GUI |
| `affdon` | 414-454 | Private | 15 | 35 | 0 |  |
| `calcanne` | 456-469 | Private | 3 | 11 | 0 |  |
| `code_Read` | 471-475 | Private | 1 | 3 | 0 |  |
| `code_Write` | 477-481 | Private | 1 | 3 | 0 |  |
| `dec_Read` | 483-487 | Private | 1 | 3 | 0 |  |
| `dec_Write` | 489-493 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les fonctions sont du code mort (aucune instance n'est créée).

- **`_new(TabStrip1, type)`** [portée : sans objet] [nature : GUI + SQL]. Ajoute toujours un
  onglet, crée le Label et le `GridView` `As "grdv"`, fixe le format `ar$` (`"0"` si `Prxdec`,
  sinon `"0.00"`), lit `Fiches_Parametres`, dessine en-têtes et mois. Identique à `gridvi._new` à
  28 lignes près.
- **`bouton_Click()`** [code mort] [nature : mixte, CC 20]. Parcourt 4 exercices × 12 mois, lit les
  lignes de factures (`Fiches_HistoLigfac`, `Fiches_HistoFac`) et, pour le mois en cours et la
  période précédente seulement, les BL (`Fiches_Ligbl`, `Fiches_Bl`) ; totalise la ligne 12.
  Code mort interne : `Select i` dont les deux branches sont identiques ; `smoiscour` calculé sur
  `Now`.
- **`requete(…)`** [privé, mort] : `SELECT <colonnes> FROM tab, tab1 WHERE cond`, cumul ligne à
  ligne avec `Try … CFloat(Replace(…))`. ⚠️ Pour le type `M`, la requête factures ne sélectionne que
  `margem` alors que le cumul lit `resbl!marge` (erreur masquée par `Try`, marge à 0).
- **`affent`, `razcol`, `calcanne`, `code_Read/Write`, `dec_Read/Write`** : **strictement
  identiques** à ceux de `gridvi` (voir sa documentation).
- **`grdv_MouseDown()` / `grdv_MouseUp()`** [handlers, morts] : bornage de la sélection par
  ligne de départ/arrivée, puis fenêtre de détail par article (requêtes `UNION` factures + BL, dates
  `yyyymmdd`). Les calculs `d1`/`d3`/`d5` utilisent des `Try … Date(Year - 4 …)` dont les
  bornes sont incohérentes avec `gridvi` (fenêtres de 1 à 2 ans selon les cas, à titre indicatif).
- **`affdon(…)`** [privé, mort] : identique à `gridvi.affdon` sauf 6 lignes (`CFloat`, types `A`/`E`).

## État global utilisé

- `Start.LocalSettings["/Soc" & Start.Societe & "/Prxdec"]` (initialiseur de membre).
- `Utils.db`, `Utils.mois`, `Utils.lastday`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Aucune : la classe doit être **supprimée**.

### Commonalisation avec d'autres fichiers

- Duplication mesurée avec [`gridvi`](../gridvi.class/architecture.md) : `affent` (31 l.),
  `razcol` (18 l.), `calcanne` (14 l.) et accesseurs (23 l.) identiques, soit 86 lignes ;
  `affdon` à 6 lignes près ; `_new` à 28 lignes de diff près. La suppression élimine toute cette
  duplication sans toucher `gridvi`.
- [`gridv`](../gridv.module/architecture.md) est l'autre variante morte, à supprimer dans le même lot.

### Réduction de portée

- Sans objet (suppression).

### Séparation traitement / GUI

- Sans objet (suppression).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune (code mort). Voir `gridvi`.
