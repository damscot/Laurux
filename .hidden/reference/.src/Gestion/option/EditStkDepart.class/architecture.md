# EditStkDepart — Architecture

> Source : `.src/Gestion/option/EditStkDepart.class` (+ `EditStkDepart.report`)

## Vue d'ensemble

**État `gb.report`** de l'option boissons : édition des stocks d'alcool par code régie et par
degré, avec volumes effectif, d'alcool pur (AP) et sécurité sociale (SS) calculés par
[`Calculdroit`](../calculdroit.class/architecture.md). Quatre variantes, choisies par le
paramètre du constructeur (énumération `Public` `inventaire`, `tournant`, `depart`, `fin`) :

| Valeur | Libellé (`nomInv`) | Source des quantités |
|---|---|---|
| `inventaire` | inventaire fin d'année | `Fiches_Inv.inv_qtecomptee` ⨝ `Fiches_Art` |
| `tournant` | inventaire tournant | `Fiches_InvT.inv_qtecomptee` ⨝ `Fiches_Art` |
| `depart` | stock de départ | `Fiches_Art.art_stkdep` |
| `fin` | stock de fin | `Fiches_Art.art_qte` |

Articles retenus : `art_dra IS NOT NULL` (code régie renseigné), triés par `art_dra, art_deg`.
Un saut de page sépare chaque code régie ; un sous-total est imprimé à chaque changement de
degré, un total à chaque changement de régie. L'en-tête de régie lit `Fiches_regie.nom`.

Appelant unique : [Caleditcmat](../Caleditcmat.class/architecture.md) (`editinv`, boutons
« Inventaire », « Inventaire tournant », « Stock de départ », « Stock »), qui imprime l'état dans
`~/tmp/stockmat.pdf` et l'ouvre par `Desktop.Open`. Lecture seule. Ce fichier ne touche à aucune
table `*M` du matériel : « mat » désigne ici la comptabilité **matières**.

Nature : **mixte** (requête + construction dynamique des lignes du report).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `inventaire` | enum | Public | oui |  | 3 |
| `tournant` | enum | Public | oui |  | 3 |
| `depart` | enum | Public | oui |  | 3 |
| `fin` | enum | Public | oui |  | 3 |
| `nomInv` | var | Public |  | String[] | 4 |
| `stk` | var | Private |  | Float | 7 |
| `totvol` | var | Private |  | Float | 8 |
| `totap` | var | Private |  | Float | 9 |
| `totss` | var | Private |  | Float | 10 |
| `$soustot` | var | Private |  | Totalc | 13 |
| `$totgen` | var | Private |  | Totalc | 14 |
| `$ind` | var | Private |  | Integer | 15 |
| `$tab` | var | Private |  | Integer | 16 |
| `$resalc` | var | Private |  | Result | 17 |
| `champs` | const | Private |  |  | 19 |
<!-- /AUTO:declarations -->

Remarque : la constante `champs` (ligne 19) n'est utilisée nulle part.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 21-69 | Public | 9 | 42 | 0 | méthode spéciale |
| `entete` | 72-81 | Private | 2 | 7 | 0 |  |
| `soustot` | 83-108 | Private | 1 | 20 | 0 |  |
| `totdra` | 110-132 | Private | 1 | 18 | 0 |  |
| `edligne` | 134-168 | Private | 1 | 25 | 0 |  |
| `dimention` | 170-183 | Private | 3 | 10 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(ind)`** [portée : nécessaire (constructeur)] [nature : mixte] (CC 9, max du fichier) :
  `Application.Busy += 1` ; fond de l'en-tête aux couleurs du thème (`Start.R/G/B`) ; requête selon
  `ind` (voir tableau) ; si des lignes existent : libellé « Édition : … », date du jour
  (`LDate(Now).L`), en-tête de la première régie, puis boucle `Repeat … Until MoveNext()` avec
  ruptures sur `art_deg` (`soustot`) et `art_dra` (`totdra`, nouvelle `ReportHBox` et `entete`).
  `Busy -= 1` en fin. Une valeur de `ind` hors énumération laisse `$resalc` à `Null` → erreur
  (impossible depuis `Caleditcmat`).
- **`entete()`** [Private] [nature : mixte] : libellé de la régie courante
  (`SELECT * FROM Fiches_regie WHERE code = &1`) dans la boîte `ligne` courante ; police
  `"Serif,Blod,11"` (faute de frappe : « Blod » au lieu de « Bold », le gras n'est probablement
  pas appliqué, à confirmer : EDITSTKDEPART-A02).
- **`soustot()`** [Private] [nature : GUI] : ligne « Sous total » (stock, volume, AP, SS), cumul
  dans `$totgen`, remise à zéro de `$soustot`.
- **`totdra()`** [Private] [nature : GUI] : ligne « TOTAL » de la régie, saut de page, remise à
  zéro de `$totgen`.
- **`edligne()`** [Private] [nature : mixte] : `New Calculdroit(art_dra, art_volm, art_deg, qte)`
  (qui lit `Fiches_regie`, `Fiches_Tvaav`, `Fiches_Parametres`), ligne détaillée (code, désignation,
  degré, quantité, volume, AP, SS), cumul dans `$soustot`.
- **`dimention(obj, h, w, f, a, b)`** [Private] [nature : GUI] : fabrique de `ReportLabel`
  (hauteur, largeur, police, alignement et bordure optionnels).

Variables : `nomInv` (`Public`, utilisée seulement dans `_new`) ; `$soustot`, `$totgen`
(structure `Public` `totalc`, utilisée seulement ici) ; `$ind`, `$tab` (`$tab` inutilisée),
`$resalc`.

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (couleur de l'en-tête), `Application.Busy`, `Utils.db.Exec`.
- Le contrôle `ligne` du `.report` est **réaffecté** à chaque nouvelle ligne (`ligne = New
  ReportHBox(Me)`) : `entete` et `dimention` écrivent toujours dans la dernière boîte créée.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer la constante `champs` et la variable `$tab` (inutilisées).
- `_new` : remplacer le `Select Case` à quatre requêtes presque identiques par une table
  (source, colonne de quantité) et une seule requête paramétrée par concaténation de nom de
  table/colonne (SQL identique au caractère près).
- `$soustot`/`$totgen` : la remise à zéro par `New Totalc` est répétée ; une méthode
  `Cumule(src, dst)` simplifierait `soustot`.

### Commonalisation avec d'autres fichiers

- **Sélection des articles soumis à régie** : `art_dra IS NOT NULL` ici, `art_dra <> ''` dans
  [Caleditcmat](../Caleditcmat.class/architecture.md) (`ctrl`) et `art_dra IS NOT NULL` dans
  `ObjFacB` : un prédicat unique (`ArticleSoumisRegie`) éviterait les écarts (voir
  EDITSTKDEPART-A01).
- **Fabrique `dimention`** : même rôle que les blocs `New ReportLabel` + `Font` + `Border`
  répétés dans `Caleditcmat.entete/soustot/ligne` (≈ 300 lignes) : un helper commun de
  construction de `ReportLabel` (module de l'option ou `Reports`) servirait aux deux fichiers.
- Pas d'en-tête société ici (contrairement à `Einvmat`/`Ecomptamat`) ; si un en-tête commun
  `Creleve.EnteteSociete` est créé (voir [Ligcli](../../../Compta/Relances/Ligcli.class/architecture.md)),
  il pourrait être ajouté, mais ce serait un changement de rendu (hors rework).

### Réduction de portée

- `nomInv` → `Private` : seule utilisation `EditStkDepart.class:41` (vérifié par `grep -rn nomInv`).
- L'énumération (`inventaire`… `fin`) reste `Public` (`Caleditcmat.class:898-917`).
- La structure `totalc` n'est utilisée que dans ce fichier ; la déclarer privée n'est pas
  possible pour une `Struct` Gambas (à confirmer), elle reste en l'état.

### Séparation traitement / GUI

- `LignesStock(ind) As Result` (requête) et un calcul des cumuls indépendant de la construction
  des `ReportLabel` permettraient de tester les totaux en gb.test.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Contrainte `art_dra` NULL ou code existant de `Fiches_regie` (au lieu de chaînes vides).
- Créer `Fiches_regie`/`Fiches_ligregie` et les colonnes `art_dra`, `art_volm`, `art_deg`,
  `art_stkdep` par migration plutôt que par `modfichier.fichierboisson`.
