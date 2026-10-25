# Cbordereaux — Architecture

> Source : `.src/Reports/Cbordereaux.class`

## Vue d'ensemble

`Cbordereaux` est le **gabarit PDF des bordereaux de remise et des listes de paiements**
(`Inherits PdfWriter`, A4 portrait). Trois appelants, trois documents :

| Appelant | Document | Méthodes utilisées |
|---|---|---|
| [Caisse/Bordereaux](../../Caisse/Bordereaux.class/architecture.md) | bordereau de caisse (remise d'espèces / chèques) | `Entete`, `Logo`, `Entete2`, `Ligne`, `TitreB`, `Level5` |
| [Compta/Impressions/BordereauxC](../../Compta/Impressions/BordereauxC.class/architecture.md) | bordereau de remise de chèques | `Entete`, `TitreB`, `Ligne`, `Level6`, `Level7`, `Level8` |
| [Gestion/Impressions/Edpaiement](../../Gestion/Impressions/Edpaiement.class/architecture.md) | liste des paiements clients | `EnteteP`, `Level1`, `Level2`, `Level3`, `Ligne`, `Footer` |

Rendu pur (aucune lecture de base, aucun calcul) ; l'en-tête société du bordereau de caisse est
lu et composé par `Bordereaux.Imp_Entete` (SQL `WHERE cd_sc = &1`), puis imprimé ligne à ligne par
`Entete2`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-14 | Public | 1 | 5 | 0 | méthode spéciale |
| `_free` | 16-18 | Public | 1 | 2 | 0 | méthode spéciale |
| `Entete` | 20-24 | Public | 1 | 3 | 2 |  |
| `Entete2` | 26-32 | Public | 1 | 5 | 1 |  |
| `EnteteP` | 35-43 | Public | 1 | 7 | 1 |  |
| `Footer` | 46-53 | Public | 1 | 6 | 1 |  |
| `Ligne` | 55-60 | Public | 1 | 4 | 3 |  |
| `Logo` | 62-66 | Public | 1 | 3 | 1 |  |
| `TitreB` | 69-75 | Public | 1 | 5 | 2 |  |
| `Level1` | 78-89 | Public | 1 | 10 | 1 |  |
| `Level2` | 92-102 | Public | 1 | 9 | 1 |  |
| `Level3` | 105-111 | Public | 1 | 5 | 1 |  |
| `Level5` | 114-121 | Public | 1 | 6 | 1 |  |
| `Level6` | 125-135 | Public | 1 | 9 | 1 |  |
| `Level7` | 138-147 | Public | 1 | 8 | 1 |  |
| `Level8` | 150-157 | Public | 1 | 6 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Toutes les méthodes sont `[nature : GUI]` et `[portée : nécessaire]` (au moins un appelant
externe, voir dependencies.md).

- **`_new()`** : `R`, `G`, `B` = `Start.R/G/B` (identique à 11 gabarits). **`_free()`** : vide.
- **`Entete()`** : `AddPage` seul (nouvelle page sans titre) — même corps que `Cticket.newPage`,
  `Htickets.Entete`, `Cetiquettes.NewPage`, `Cdocuments.EnteteV`.
- **`Entete2(Ent, PosY)`** : une ligne d'en-tête société, 10 pt gras italique, à x = 8.
- **`EnteteP(ent, PosY)`** : `AddPage` + bandeau titre 16 pt, 206 mm (corps identique au `EnteteN`
  de `Creleve`/`Ctraites`/`Cdocuments*` et à `Cbalances.Entete`) ; `PosY` **inutilisé**.
- **`Footer()`** : pied de page standard (« Page n/{nb} - date - Impression demandée par »). Corps
  identique à `Ccompta.BasPage`. **Surcharge** le crochet `PdfWriter.Footer` (vide) : aujourd'hui
  `PdfWriter` n'appelle pas ce crochet (appels commentés dans `AddPage`/`Close`), seul
  `Edpaiement` l'appelle explicitement ; les bordereaux (`Bordereaux`, `BordereauxC`) n'ont pas de
  pied de page.
- **`Ligne(PosY)`** : filet de 2 à 206 mm (épaisseur courante, non fixée), après un `SetXY(2,
  PosY)`.
- **`Logo(Logo)`** : `Me.Image(Logo, 160, 10, 30, 30)` sans contrôle : l'appelant
  (`Bordereaux:149-153`) ne vérifie que `glogo` et un chemin non nul ; un fichier absent ou d'un
  type non géré (ni JPEG ni PNG : `Error.Raise("Unsupported image type")` dans `PdfWriter.Image`)
  interrompt l'impression (CBORDEREAUX-A01, à confirmer).
- **`TitreB(TxtB, PosY)`** : titre du bordereau centré sur 200 mm.
- **`Level1()`** : en-tête des paiements (Code client, Nom, N° de Fact/Bl, Montant facture, Montant
  réglé), y = 20, rempli à la couleur du thème.
- **`Level2(code, intitule, Nfac, MontantFac, Montant, PosY)`** : ligne de paiement.
- **`Level3(Mttc, PosY)`** : total des paiements, à `PosY + 5`.
- **`Level5(Intitule, prix, PosY)`** : ligne du bordereau de caisse (x = 26).
- **`Level6()`** : en-tête des chèques (Date chèque, Montant, Code client, Nom client), x = 20.
- **`Level7($date, Montant, code, intitule, PosY)`** : ligne de chèque.
- **`Level8(Intitule, prix, PosY)`** : ligne de total du bordereau (x = 20) ; même code que
  `Level5` à l'abscisse et à la largeur près (80 au lieu de 140).

## État global utilisé

- `Start.R/G/B`, `User.Name`, `Now`.
- État `PdfWriter` : épaisseur de trait, couleur de remplissage (fixée par `Level1`, `Level6`,
  `EnteteP`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `_free` et le paramètre inutilisé `PosY` d'`EnteteP` (appelant `Edpaiement`, même
  commit).
- `Level5`/`Level8` : helper privé `LigneMontant(x, largeur, intitulé, prix, PosY)`.

### Commonalisation avec d'autres fichiers

- Base commune `PdfLaurux` (PDFWRITER-011, voir
  [PdfWriter](../PdfWriter.class/architecture.md) et
  [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)) : `_new`,
  `Entete` (= `NouvellePage`), `EnteteP` (= titre de page standard), `Footer` (= pied de page
  standard). `Footer` doit **garder son nom** (surcharge du crochet `PdfWriter.Footer`, comme
  `Carticles`, `Chistoriques`, `Cmat`, `Htickets`) ; si le rework de `PdfWriter` réactivait
  l'appel automatique du crochet, `Edpaiement` aurait un double pied de page et les bordereaux en
  gagneraient un (changement de comportement).
- `Logo(Logo)` : signature différente des `Logo()` de `Creleve`/`Cfacture` (taille fixe, chemin
  passé par l'appelant) ; la lecture du chemin (`glogo`, `Logo`) faite par `Bordereaux` est la même
  que dans `Creleve.Logo` → `LogoSociete(x, y, l, h, proportionnel)` dans la base.
- En-tête société : `Bordereaux.Imp_Entete` recompose adresse, SIRET, téléphone ; voir l'en-tête
  société commun documenté dans [Creleve](../Creleve.class/architecture.md#en-tête-société-commun-crelevebentetesociete-ligcli-004).
- [CLcr](../../Gestion/Lcr/CLcr.class/architecture.md) (bordereau LCR) a la même structure titre /
  tableau / total, avec d'autres colonnes : gain faible.

### Réduction de portée

- Aucune : chaque méthode a un appelant externe.

### Séparation traitement / GUI

- Sans objet (rendu pur).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
