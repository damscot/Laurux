# CLcr — Architecture

> Source : `.src/Gestion/Lcr/CLcr.class`

## Vue d'ensemble

`CLcr` est le **gabarit PDF des états LCR** : classe `Inherits PdfWriter` (méthodes en minuscules
`SetXY`, `Cell`, `SetFont`…), construite par `New CLcr("Portrait", "mm", "A4")` dans les cinq écrans
LCR. Elle fournit trois familles de « niveaux » d'impression :

| Famille | Méthodes | Utilisée par |
|---|---|---|
| Commune | `Entete`, `BasPage`, `Lines` | tous les écrans |
| Liste des LCR (acceptation/écartées) | `Level1`, `Level2` | `Lcr.Imp_Lcr` |
| Liste des LCR avec banque | `Level1A`, `Level2A` | `Attribution`, `Glcr`, `Preparation` |
| Bordereau de remise | `Level1B`, `Level2B`, `Level3B`, `Level4B` | `Bordrx.Gen_Bordereau` |
| Non utilisées | `Level0`, `Level5A` | aucun appelant |

La couleur de fond des en-têtes vient du thème (`Start.R/G/B`, lue dans `_new`). Les positions sont
en millimètres ; l'appelant gère `PosY` et les sauts de page (seuil 268 mm).

Nature globale : **GUI d'impression** (aucun SQL) ; seul calcul : formatage des montants.

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
| `Entete` | 20-28 | Public | 1 | 7 | 5 |  |
| `BasPage` | 31-38 | Public | 1 | 6 | 5 |  |
| `Level0` | 40-46 | Public | 1 | 5 | 0 | portée réductible ? |
| `Level1` | 49-64 | Public | 1 | 13 | 1 |  |
| `Level2` | 67-93 | Public | 4 | 24 | 1 |  |
| `Level1A` | 96-112 | Public | 1 | 14 | 3 |  |
| `Level2A` | 115-140 | Public | 10 | 23 | 3 |  |
| `Level1B` | 143-172 | Public | 1 | 27 | 1 |  |
| `Level2B` | 174-187 | Public | 1 | 11 | 1 |  |
| `Level3B` | 190-202 | Public | 1 | 10 | 1 |  |
| `Level4B` | 205-218 | Public | 1 | 11 | 1 |  |
| `Level5A` | 221-235 | Public | 1 | 12 | 0 | portée réductible ? |
| `Lines` | 238-244 | Public | 1 | 5 | 4 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et éléments communs

- **`_new()`** [portée : nécessaire (spéciale)] [nature : calcul] : copie `Start.R/G/B` dans les
  membres privés `R`, `G`, `B` (déclarés sans mot-clé, donc `Private`). Les arguments
  `("Portrait", "mm", "A4")` des appelants sont consommés par le constructeur de `PdfWriter`.
- **`_free()`** : vide → code mort (méthode spéciale inutile).
- **`Entete(sEntete)`** [portée : nécessaire] [nature : GUI] : nouvelle page (`AddPage`) puis
  bandeau titre coloré, Helvetica gras 16, largeur 206 mm à (2, 5).
- **`BasPage()`** [portée : nécessaire] [nature : GUI] : pied de page « Page n/{nb} - date du jour -
  Impression demandée par <utilisateur> ». Déclarée `Function` sans type de retour (renvoie
  `Variant` nul). **Strictement identique** à `Ccompta.BasPage` (`.src/Reports/Ccompta.class`).
- **`Lines(PosY As String)`** [portée : nécessaire] [nature : GUI] : trait horizontal de 2 à
  206 mm. Le paramètre est typé `String` alors que tous les appelants passent un `Integer`
  (conversion implicite) ; `SetXY(7, PosY)` est sans effet visible.

### Liste des LCR (écran `Lcr`)

- **`Level1()`** [portée : nécessaire, `Lcr.Imp_Lcr` l. 625] [nature : GUI] : en-tête de tableau à
  y = 24 (N° facture, Date facture, Nom, Date échéance, Montant, Écartée, Code acpt).
  ⚠️ `deps.py` la déclare « jamais référencée » : faux positif (voir dependencies.md).
- **`Level2(num, Datel, snom, sadr1, sadr2, scp, datech, smontant, secartee, sacceptee, PosY)`**
  (11 paramètres) [portée : nécessaire, `Lcr.Imp_Lcr` l. 635] [nature : GUI] : une ligne, puis
  l'adresse sur 1 à 3 lignes à x = 51 (+5 mm par ligne non nulle). Montant :
  `Format$(Val(smontant), "0.00")` **sans** `Utils.cpoint`.

### Liste des LCR avec banque (`Attribution`, `Glcr`, `Preparation`)

- **`Level1A()`** [portée : nécessaire] : même en-tête que `Level1` décalé à x = 2, colonnes
  ajustées, plus une colonne « Banque ».
- **`Level2A(num, Datel, snom, sadr1, sadr2, scp, datech, smontant, secartee, sacceptee, sbanque,
  PosY)`** (CC 10) [portée : nécessaire] : comme `Level2` (adresse à x = 47) avec la banque ; les
  lignes d'adresse égales à `" "` sont ignorées (`IsNull(x) And If x <> " "`). Même formatage du
  montant sans `cpoint`.

### Bordereau de remise (`Bordrx`)

- **`Level1B(Resoc, Dom, Emetteur, Codbanque, Codeguichet, Numerocompte, Ref, Entree, Posy)`** :
  8 lignes de texte (raison sociale, domiciliation, « Emetteur : », « Code banque : »,
  « Codeguichet : », « Numéro de compte : », référence, code entrée), +4 mm chacune.
- **`Level2B(Posy)`** : en-tête du tableau des LCR (5 colonnes).
- **`Level3B(snumfac, sdate, snom, sdatee, smontant, Posy)`** : une ligne ; le montant est imprimé
  tel que reçu (pas de formatage).
- **`Level4B(Nbtraite, montant, Posy)`** : « Nombre traite(s) », « Montant » formaté
  (`Utils.cpoint` + `"0.00"`), puis « Date de remise : » = **date du jour** (`Now`), et non la
  date de remise du bordereau (`Fiches_Bordereaux.dateremise`).

### Non utilisées

- **`Level0(nom, dateedition, ste)`** : copie exacte de `Cbalances.Level0` ; aucun appelant
  (vérifié par `grep -rn "Level0" .src` : seuls des homonymes d'autres classes `C*`).
- **`Level5A(Nbtraite, montant, Posy)`** : total des lignes LCR ; aucun appelant. `Glcr.Button9_Click`
  calcule pourtant `iLcr`/`mTotal` sans les imprimer : `Level5A` était probablement destinée à cet
  usage (voir [`Glcr`](../Glcr.class/architecture.md), anomalie GLCR-A06).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (couleurs du thème) dans `_new`.
- `Utils.cpoint` (`Level4B`, `Level5A`).
- `User.Name`, `Now` (pied de page, date de remise) : sorties non déterministes à neutraliser en
  test (faketime).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Level1`/`Level1A` et `Level2`/`Level2A` ne diffèrent que par l'abscisse de départ, quelques
  largeurs et la colonne banque : un helper privé `LigneLcr(x0, largeurs[], valeurs[], PosY)` les
  factoriserait en gardant les quatre signatures publiques et un rendu identique (positions
  inchangées).
- Les blocs d'adresse de `Level2`/`Level2A` (3 tests, `SetXY` successifs) → helper privé
  `Adresse(x, PosY, sadr1, sadr2, scp, ignorer_espace)`.
- `Lines(PosY As String)` → `Lines(PosY As Integer)` : tous les appelants passent un entier
  (même rendu).
- `_free` vide à supprimer.

### Commonalisation avec d'autres fichiers

- `BasPage` est identique à `Ccompta.BasPage` (et très proche des pieds de page des autres classes
  `C*` de `.src/Reports`) ; `Entete` ne diffère de `Ccompta.Entete` que par la position, le style
  et la largeur. Une classe intermédiaire `LPdfBase` (`Inherits PdfWriter` : couleurs du thème,
  `Entete(titre, x, style, largeur)`, `BasPage`, `Lines`) servirait aux 24 gabarits PDF. À traiter
  au lot Reports (phase 3), `CLcr` étant un consommateur.
- `Level0` = `Cbalances.Level0` (même signature, même corps).
- Le bordereau LCR (`Level1B`…`Level4B`) et le bordereau de remise de chèques
  (`Cbordereaux`, utilisé par [`BordereauxC`](../../../Compta/Impressions/BordereauxC.class/architecture.md))
  partagent la structure en-tête banque / tableau / total ; une commonalisation de la mise en page
  est possible mais de faible gain (colonnes différentes).
- Classement : `CLcr` est le seul gabarit PDF hors de `.src/Reports` ; un déplacement de fichier est
  hors périmètre (aucun impact Gambas, classes globales), à signaler en phase 3.

### Réduction de portée

- `Level0`, `Level5A` : code mort (suppression plutôt que réduction).
- Toutes les autres méthodes ont des appelants externes : portée nécessaire.

### Séparation traitement / GUI

- Le seul calcul est le formatage des montants (`Format$(Val(...))`), différent selon les niveaux
  (`Level2`/`Level2A` sans `cpoint`, `Level4B`/`Level5A` avec). Un helper privé `Montant(s)`
  documenterait les deux variantes sans les fusionner (fusion = anomalie CLCR-A01).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Fiches_Lcr.montant` est un `char(12)` : le stocker en `DECIMAL(12,2)` supprimerait l'ambiguïté
  du séparateur décimal à l'impression (anomalie CLCR-A01).
