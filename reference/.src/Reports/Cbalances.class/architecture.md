# Cbalances — Architecture

> Source : `.src/Reports/Cbalances.class`

## Vue d'ensemble

`Cbalances` est le **gabarit PDF des balances comptables et de l'état de TVA** (`Inherits
PdfWriter`). Comme [Ccompta](../Ccompta.class/architecture.md), il ne contient que de la mise en
page : l'appelant crée l'objet (`New Cbalances("Portrait", "mm", "A4")`), gère l'ordonnée `PosY`
et les sauts de page (`BasPage` puis `Entete`), et produit le fichier par `Output`.

Deux familles de niveaux :

| Famille | Méthodes | Appelant |
|---|---|---|
| Balance avec cumul hors période | `Level0`, `Level1`, `Level2`, `Level3`, `Level4` | [BalanceM](../../Compta/Impressions/BalanceM.module/architecture.md) |
| Balance sans cumul hors période (`a`) | `Level1a`, `Level2a`, `Level3a`, `Level4a` (+ `Level2s`, `Level2sbis` morts) | `BalanceM` |
| TVA (`T`) | `Level0T`, `Level1T`, `Level2T`, `Level3T`, `Level4T`, `Level4TVA`, `Level5T` | [FTVA](../../Compta/Impressions/FTVA.class/architecture.md) |
| Communes | `Entete`, `BasPage` | `BalanceM`, `FTVA` |

Nature globale : **GUI (rendu PDF)**, avec un petit calcul de solde débit − crédit dans
`Level2a`, `Level2s`, `Level3a`, `Level4a`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 4 |
| `G` | var | Private |  | Integer | 5 |
| `B` | var | Private |  | Integer | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-14 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 16-18 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 20-28 | Public | 1 | 7 | 2 |  |
| `BasPage` | 31-38 | Public | 1 | 6 | 2 |  |
| `Level0` | 40-46 | Public | 1 | 5 | 1 |  |
| `Level1` | 49-73 | Public | 1 | 22 | 1 |  |
| `Level2` | 76-92 | Public | 1 | 14 | 1 |  |
| `Level3` | 95-113 | Public | 1 | 16 | 1 |  |
| `Level4` | 116-131 | Public | 1 | 13 | 1 |  |
| `Level1a` | 134-152 | Public | 1 | 16 | 1 |  |
| `Level2a` | 155-173 | Public | 5 | 16 | 1 |  |
| `Level2s` | 176-199 | Public | 5 | 20 | 0 | portée réductible ? |
| `Level2sbis` | 201-206 | Public | 1 | 4 | 0 | portée réductible ? |
| `Level3a` | 209-227 | Public | 5 | 16 | 1 |  |
| `Level4a` | 229-246 | Public | 5 | 15 | 1 |  |
| `Level0T` | 250-258 | Public | 1 | 7 | 1 |  |
| `Level1T` | 261-278 | Public | 1 | 15 | 1 |  |
| `Level2T` | 281-300 | Public | 5 | 17 | 1 |  |
| `Level3T` | 303-312 | Public | 1 | 7 | 1 |  |
| `Level4T` | 315-327 | Public | 1 | 10 | 1 |  |
| `Level4TVA` | 330-346 | Public | 2 | 14 | 1 |  |
| `Level5T` | 349-370 | Public | 2 | 12 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les méthodes sont `[nature : GUI]` sauf mention ; aucune ne touche la base.

### Communes

- **`_new()`** [portée : nécessaire (spéciale)] : `R`, `G`, `B` = `Start.R/G/B` (identique à 11
  autres gabarits). **`_free()`** : vide.
- **`Entete(sEntete)`** [portée : nécessaire, `BalanceM:87`, `FTVA:543`] : `AddPage` + titre
  centré 16 pt gras, x = 2, largeur 206, bordé et rempli (identique à `Cecheancier.Entete`,
  `CLcr.Entete` et au `EnteteN` de `Creleve`/`Ctraites`/`Cdocuments*`).
- **`BasPage()`** [portée : nécessaire] : pied de page standard (date du jour, `User.Name`,
  `Page n/{nb}`), identique à `Ccompta.BasPage`.
- **`Level0(nom, dateedition, ste)`** [portée : nécessaire, `BalanceM:90`] :
  `"<ste>.  <nom> <dateedition>"` centré (identique à `CLcr.Level0`, mort dans `CLcr`).

### Balance avec cumul hors période

- `Level1()` : en-tête à deux étages (Compte, Intitulé, Cumul période / hors période / Total en
  Débit-Crédit, Solde), y = 24-34.
- `Level2(code, intitule, stotdeb, stotcred, sdebhp, scredhp, totdeb2, totcred2, totsld2, PosY)` :
  ligne de compte en 7 pt, montants imprimés tels que reçus (déjà formatés par `BalanceM`).
  `SetFont("Helvetica",, 7)` : style par défaut `""`.
- `Level3(clas, …, sldclass, PosY)` : « Total classe » + 7 cellules remplies, trait de 2 à 206.
  Les deux premières lignes (`SetXY` + `SetFont(…, 7)`) sont immédiatement écrasées par les deux
  suivantes (code superflu ; le `SetFont` inutile émet tout de même un opérateur de police dans le
  flux PDF).
- `Level4(…, PosY)` : « Total balance » + 7 cellules remplies.

### Balance sans cumul hors période

- `Level1a()` : en-tête Compte, Intitulé, Cumul période (Débit, Crédit), Solde, à x = 26.
- `Level2a(code, intitule, stotdeb, stotcred, posY)` [nature : mixte] : calcule `sld =
  Format$(Val(Utils.cpoint(deb)) - Val(Utils.cpoint(cred)), ",0.00")` (chaîne vide ou `Null` → `"0"`),
  puis efface les montants égaux à `"0"`. ⚠️ `Val("")` est évité par le test `IsNull` (une
  chaîne vide est `Null` en Gambas).
- `Level3a(clas, debclass, credclass, PosY)`, `Level4a(totbaldeb, totbalcred, PosY)` [nature :
  mixte] : même calcul de solde pour les totaux de classe et de balance.
- `Level2s(code, intitule, stotdeb, stotcred, posY)` : bandeau gris des sous-comptes — **jamais
  appelé** (le `Level2s` utilisé par `EditcompteM` est celui de `Ccompta`, dont le corps diffère).
- `Level2sbis(cpt, posy)` : **jamais appelé** (identique à `Ccompta.Level2sbis`, mort aussi).

### TVA

- `Level0T(dateedition, ste)` : société et période (lignes 12 et 16).
- `Level1T()` : en-tête 9 colonnes Compte … Solde.
- `Level2T(intitule, jour, dte, numero, Lot, montantd, montantc, solde, Posy)` : ligne d'écriture ;
  `"0"`/`Null` → `""` pour débit et crédit ; montants non reformatés.
- `Level3T(cpt, intit, Posy)` : compte en gras.
- `Level4T(totd, totc, tots, Posy)` : « Total compte » (non rempli) + 3 montants `Format$`.
- `Level4TVA(totd, totc, tots, Posy, Type)` : « Total TVA achats » si `Type = "1"`, sinon « Total TVA
  ventes », cellule remplie.
- `Level5T(totd, totc, tots, Dte, Posy)` : ligne de total final (« <Dte> --> » puis le solde
  `Format$`). Les deux branches du `If Val(Format$(tots, "0.0")) <= 0` sont **identiques**
  (complexité superflue) ; `totd` et `totc` sont inutilisés (ancien code commenté).

## État global utilisé

- `Start.R/G/B` (dans `_new`), `User.Name`, `Now` (pied de page), `Utils.cpoint`.
- État hérité de `PdfWriter` : la couleur de remplissage des totaux (`Level3`, `Level4`,
  `Level3a`, `Level4a`, `Level4TVA`) est celle laissée par l'en-tête (`Level1`/`Level1a`/
  `Level1T`), soit la couleur du thème.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level2s`, `Level2sbis` (morts), `_free` (vide) et les deux premières lignes de `Level3`.
- `Level5T` : supprimer le `If` à branches identiques (le `Format$(tots, …)` de la ligne suivante
  conserve l'éventuelle erreur de conversion : comportement identique).
- Helper privé `SoldeDebitCredit(deb, cred) As String` pour `Level2a`, `Level3a`, `Level4a` (même
  formule, mêmes remplacements `"0"` → `""`).
- Helper privé `MontantVide(s) As String` (`Null`/`"0"` → `""`) pour `Level2T`, `Level2a`…

### Commonalisation avec d'autres fichiers

- `_new`, `Entete`, `BasPage` → base commune des gabarits `PdfLaurux` (voir
  [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- `Level0` = `CLcr.Level0` (même corps, mort dans [CLcr](../../Gestion/Lcr/CLcr.class/architecture.md)) :
  la suppression côté `CLcr` (CLCR-002) suffit, pas de partage à créer.
- `SoldeDebitCredit` partagé avec `Ccompta.Level2s` (même formule).
- `Level1T`/`Level2T`/`Level3T`/`Level4T` reprennent la mise en page de `Ccompta.Level1`/`level2`/
  `Level3`/`Level4` avec des écarts de largeur (19/21 mm) et de remplissage : pas de fusion sans
  test raster.

### Réduction de portée

Aucune : chaque méthode vivante a un appelant externe (`BalanceM` ou `FTVA`). `Level2s` et
`Level2sbis` sont à supprimer.

### Séparation traitement / GUI

- Extraire `SoldeDebitCredit` (calcul) des niveaux `Level2a`, `Level3a`, `Level4a`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
