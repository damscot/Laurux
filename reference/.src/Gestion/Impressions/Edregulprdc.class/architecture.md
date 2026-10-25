# Edregulprdc — Architecture

> Source : `.src/Gestion/Impressions/Edregulprdc.class` (+ `Edregulprdc.form`)

## Vue d'ensemble

Écran « Impression des entrées des produits composés » (menu `Menu264`, Gestion > Stock >
Impressions, `Fmenu.class:2140`). Copie d'[`Edregul`](../Edregul.class/architecture.md) appliquée à
la table `Fiches_Mvtexpdc`, alimentée par [`MvtProdcomp`](../../Stock/MvtProdcomp.class/architecture.md)
(entrée du produit composé `type = "P"`, sorties de ses composants `type = "C"`, regroupées par
numéro de fabrication `mind`). Il imprime les mouvements d'une période (`~/tmp/Regul.pdf`, même
nom de fichier qu'`Edregul`) avec un trait de séparation entre deux fabrications, et peut les
purger.

Différences avec `Edregul` (`diff`) : table, titre, tri `mind, type, code`, séparateur entre
`mind`, couleur de sortie de champ `&HF9F9BD&` au lieu de `Color.TextBackground`, `Wait 0.5`
après `Visualiseur.Prog`, textes de purge, `Level1`/`Level2` en plus (code mort), `Kill
"~/Regul.ps"`. En-tête de fichier recopié (« Edregul.class », « Impression des Bl fournisseurs »).

Boutons du `.form` sans handler : `Button1` (aide), `Button6`.

Nature : **mixte**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `jour` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `PosY` | var | Private |  | Integer | 31 |
| `PosX` | var | Private |  | Integer | 32 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 34-45 | Public | 1 | 10 | 0 | méthode spéciale |
| `Cmpt_KeyPress` | 50-78 | Public | 10 | 21 | 0 | handler GUI |
| `Cmpt_GotFocus` | 83-89 | Public | 1 | 5 | 0 | handler GUI |
| `date1_LostFocus` | 91-103 | Public | 3 | 11 | 0 | portée réductible ? |
| `date2_GotFocus` | 105-109 | Public | 1 | 3 | 0 | portée réductible ? |
| `date2_LostFocus` | 111-130 | Public | 6 | 18 | 0 | portée réductible ? |
| `Button2_Click` | 132-214 | Public | 13 | 80 | 0 | handler GUI |
| `Level1` | 217-236 | Public | 1 | 18 | 0 | portée réductible ? |
| `Level2` | 239-251 | Public | 1 | 11 | 0 | portée réductible ? |
| `Button3_Click` | 253-258 | Public | 2 | 4 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`**, **`Cmpt_KeyPress()`**, **`Cmpt_GotFocus()`** : identiques à `Edregul` (voir
  [Edregul](../Edregul.class/architecture.md)).
- **`date1_LostFocus()`**, **`date2_LostFocus()`** [portée : réductible] [GUI] : pseudo-handlers
  (`Date1`/`Date2` dans le groupe `Cmpt`), appelés seulement par `Cmpt_KeyPress` ; remettent le fond
  à `&HF9F9BD&` (jaune pâle) au lieu de la couleur système.
- **`date2_GotFocus()`** [code mort] : handler inactif (contrôle groupé), `handlers_inactifs` et
  `unused` selon `deps.py`.
- **`Button2_Click()`** (CC 13) [handler] [mixte] :
  - SQL : `SELECT * FROM Fiches_Mvtexpdc WHERE daterecpt >= &1 and daterecpt <= &2 order by mind,
    type, code`, puis `SELECT * FROM Fiches_Art WHERE art_code = &1` par ligne (N+1).
  - PDF `Carticles` : comme `Edregul`, plus `pdf.Ligne(PosY)` quand `mind` change
    (`Numero <> rResult!mind And Not IsNull(Numero)`).
  - Purge (`Effmvts` + « Oui ») : relit la période triée `mind, code` et exécute **`DELETE FROM
    Fiches_Mvtexpdc WHERE code = &1`** par ligne. ⚠️ Un composant entre dans plusieurs
    fabrications : toutes ses lignes (autres `mind`, hors période) sont supprimées, ce qui casse
    l'historique des autres fabrications (EDREGULPRDC-A01).
  - Message « Aucun mouvement » puis purge proposée même si la période est vide (A02).
- **`Level1()`**, **`Level2(…)`** [code mort] : anciennes mises en page `Draw` (`unused`, grep).
- **`Button3_Click()`** : `Try Kill "~/Regul.ps"` (fichier jamais produit) puis fermeture.

## État global utilisé

- Identique à `Edregul` : `Start.Son`, `Start.Musique`, `Utils.*` (dates, `db`, `Observers`,
  `SetEditColor`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1`, `Level2`, `date2_GotFocus`, `PosX`, variables locales inutiles.
- Extraire `ListeMouvementsPdc(sDeb, sFin)` et `PurgeMouvementsPdc(sDeb, sFin)`.

### Commonalisation avec d'autres fichiers

- Module commun avec [`Edregul`](../Edregul.class/architecture.md) (EDREGUL-004 /
  EDREGULPRDC-004) : `ImprimeMouvements(sTable, sTitre, sOrdre, bSeparateur)` ; la couleur de
  sortie de champ devient un paramètre de la saisie de période commune.
- Le libellé du type (`P`/`C`) et le commentaire sont écrits par `MvtProdcomp` : garder la
  cohérence des textes si l'un des deux change.

### Réduction de portée

- `date1_LostFocus`, `date2_LostFocus` → `Private`.

### Séparation traitement / GUI

- Comme `Edregul`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Index `Fiches_Mvtexpdc(daterecpt)` et `(mind)` ; types numériques pour `qtep`/`qtem` (`char(10)`).
