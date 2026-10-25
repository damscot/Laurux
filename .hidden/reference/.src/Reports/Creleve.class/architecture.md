# Creleve — Architecture

> Source : `.src/Reports/Creleve.class`

## Vue d'ensemble

`Creleve` est le **gabarit PDF des courriers aux tiers de la comptabilité** (`Inherits
PdfWriter`, A4 portrait) : **relevés** de compte ou de factures
([FRelCompte](../../Compta/Relances/FRelCompte.class/architecture.md),
[FRelFacture](../../Compta/Relances/FRelFacture.class/architecture.md)) et **lettres de relance**
([FEditrel](../../Compta/Relances/FEditrel.class/architecture.md),
[Ligcli](../../Compta/Relances/Ligcli.class/architecture.md)). Les quatre appelants créent
l'objet (`New Creleve("Portrait", "mm", "A4")`, `Open`, `AliasNbPages`), lisent eux-mêmes la
société et le tiers en base, puis enchaînent :

| Étape | Relevé (`FRelCompte`, `FRelFacture`) | Relance (`FEditrel`, `Ligcli`) |
|---|---|---|
| Page, cadre société, logo | `Entete(…17 paramètres…)` | idem |
| Cadre destinataire | `Entete2(rs2, adr1, adr2, ville, Pays, "", False)` | idem |
| Date / titre | `Level1(Jour, dte, Org)` (« Relevé de facture/compte du … » + `Page n/{nb}`) | `Level5(jour)` (lieu et date du courrier) |
| En-tête de tableau | `Level2()` (y = 110) | `Level6()` (y = 140) |
| Lignes | `Level3(…)` | `Level7(…)` (soldes compris) |
| Fin | `Lines`, `Level4` (total), `Level9` (texte centré, `FRelFacture`) | `Level8(txt, PosY)` (texte libre de la lettre) |

La classe ne lit pas la base : tout le contenu est passé en paramètre. Elle lit seulement la
configuration locale pour le logo.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `R` | var | Private |  | Integer | 3 |
| `G` | var | Private |  | Integer | 4 |
| `B` | var | Private |  | Integer | 5 |
| `Coln` | var | Private |  | Boolean | 6 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 9-16 | Public | 1 | 6 | 0 | méthode spéciale |
| `_free` | 18-20 | Public | 1 | 2 | 0 | méthode spéciale |
| `EnteteN` | 23-31 | Public | 1 | 7 | 0 | portée réductible ? |
| `Lines` | 34-40 | Public | 1 | 5 | 2 |  |
| `Entete` | 42-130 | Public | 12 | 85 | 4 |  |
| `Entete2` | 133-161 | Public | 2 | 26 | 4 |  |
| `Logo` | 163-184 | Public | 7 | 19 | 0 | portée réductible ? |
| `Level1` | 187-200 | Public | 2 | 12 | 2 |  |
| `Level2` | 203-213 | Public | 1 | 9 | 2 |  |
| `Level3` | 216-226 | Public | 1 | 9 | 2 |  |
| `Level4` | 229-237 | Public | 1 | 7 | 2 |  |
| `Level5` | 241-247 | Public | 1 | 5 | 2 |  |
| `Level6` | 250-260 | Public | 1 | 9 | 2 |  |
| `Level7` | 263-273 | Public | 1 | 9 | 2 |  |
| `Level8` | 276-282 | Public | 1 | 5 | 2 |  |
| `Level9` | 285-291 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Méthodes spéciales et communes

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI] : `R`, `G`, `B` = `Start.R/G/B` puis
  `SetFillColor` (la couleur est mémorisée par `PdfWriter` et réappliquée au premier `AddPage` ;
  rien n'est écrit dans le flux tant que `$page = -1`). **`_free()`** : vide.
- **`EnteteN(ent)`** [nature : GUI] : bandeau titre standard (`AddPage`, 16 pt, 206 mm) — **jamais
  appelé** (code mort ; les appels `pdf.EnteteN` du projet visent `Cdocuments`/`Cdocuments2`).
  Corps identique à `Ctraites.EnteteN`, `Cdocuments.EnteteN`, `Cdocuments2.EnteteN`.
- **`Lines(PosY As String)`** [portée : nécessaire] [nature : GUI] : `SetXY(7, PosY)` et filet de 6 à
  205 mm.

### En-têtes

- **`Entete(rs, adr11, adr22, ville, cap, rcs, siret, ape, Tvaintra, tel, portable, fax, mail, site,
  Pays, Iban, Col)`** (CC 12, max du fichier) [portée : nécessaire, 4 appelants, 2 appels chacun]
  [nature : GUI] :
  1. mémorise `Col` dans `Coln` (**jamais relu** : variable morte) ;
  2. **nouvelle page** (`AddPage`) et cadre de la société (6,7)-(100,90) ;
  3. `Logo()` (voir ci-dessous) ;
  4. raison sociale 12 pt gras, adresse et ville 10 pt gras, puis une ligne par information non vide
     (capital, RCS, SIRET, NAF, TVA intra, téléphone, portable, fax, **site avant courriel**, IBAN en
     8 pt italique), 5 mm d'interligne. Le `SetXY(6, PosY)` de la ligne 59 est sans effet (écrasé
     avant toute sortie). `Pays` est inutilisé (les appelants y passent d'ailleurs le pays **du
     destinataire**).
  Les libellés (« Rcs : », « Capital : »…) sont construits par les appelants.
- **`Entete2(rs2, adr1, adr2, ville, Pays, Col, entete)`** [portée : nécessaire] [nature : GUI] :
  `AddPage` si `entete` (les appelants passent toujours `False`), cadre destinataire (110,55)-(204,90),
  nom tronqué à 40 caractères, adresse, ville, pays. `Col` inutilisé.
- **`Logo()`** [portée : réductible (appel interne seulement)] [nature : mixte : lecture de
  configuration + rendu] : si `/Soc<XX>/glogo`, charge l'image `/Soc<XX>/Logo` pour en lire la
  largeur et l'imprime en 80 × 40 mm à `x = 116 + 80 / (largeur / 10)`, `y = 8 + 40 / hauteur`
  (formule de décalage dépendant de la taille de l'image). Seul le **dernier** `Try` est testé par
  `If Not Error` ; une image de moins de 10 pixels de large donne `L2 = 0` et une division par zéro
  hors `Try` (CRELEVE-A02). Corps identique à `Clivre.Logo` (mort), voisin de `Cfacture.Logo`.

### Relevés

- **`Level1(Jour, dte, Org)`** : « Relevé de facture du <dte> » si `Org = "1"`, sinon « Relevé de
  compte du <dte> », et `Page n/{nb}` en haut à droite. `Jour` inutilisé.
- **`Level2()`** : en-tête Date, N° de facture, Intitulé, Débit, Crédit (rempli, couleur du thème).
- **`Level3(dte, num, lib, mtd, mtc, Posy)`** : ligne (montants imprimés tels quels).
- **`Level4(totmtd, totmtc, Posy)`** : « Total relevé » + deux montants.
- **`Level9(txt, PosY)`** : texte centré `MultiCell` 200 mm (bas de relevé, `FRelFacture`).

### Relances

- **`Level5(jour)`** : lieu et date du courrier (x = 125, y = 100).
- **`Level6()`** : en-tête du tableau (y = 140), mêmes colonnes que `Level2` avec Date sur 28 mm.
- **`Level7(dte, num, lib, mtd, mtc, Posy)`** : ligne (même code que `Level3`, largeur de date
  28 au lieu de 26).
- **`Level8(txt, PosY)`** : texte de la lettre en `MultiCell` de **294 mm** sur une page de 210 mm :
  les lignes longues sont coupées à 294 mm et débordent de la page (CRELEVE-A01, à confirmer).

Toutes les méthodes de rendu sont `[portée : nécessaire]` (appelées par au moins un écran) sauf
`EnteteN` (morte) et `Logo` (interne).

## État global utilisé

- `Start.R/G/B` (couleurs), `Start.LocalSettings["/Soc<XX>/glogo"]` et `["/Soc<XX>/Logo"]`,
  `Start.Societe`.
- État `PdfWriter` (police, couleur de remplissage, position) ; `{nb}` dépend de l'`AliasNbPages`
  de l'appelant.

## En-tête société commun (`Creleve.EnteteSociete`, LIGCLI-004)

`Creleve.EnteteSociete` **n'existe pas** dans le code : c'est une méthode **proposée** par
LIGCLI-004 et reprise dans d'autres documents (`Bordereaux`, `Edcom`, `Edart4`, `EdReg`,
`Facturergbl`, `Ecomptamat`, `Einvmat`, `EditStkDepart`). État constaté :

- **Données** : le même bloc de 17 lignes est recopié dans 6 fichiers — `Ligcli:238-254`,
  `FEditrel:497-513`, `FRelCompte:341-357`, `FRelFacture:358-374` (rendu par `Creleve.Entete`),
  `Facturergbl:587-603` et `Statistiques/RelvMo:376-393` (rendu par `Cdocuments.Entete`, 19
  paramètres, autre gabarit). Les six lisent `SELECT * FROM Fiches_Societes WHERE cd_sc = &1`
  avec `Start.Societe` : **pas de défaut multi-sociétés** dans ces six copies (nom de table en dur
  `Tab2 = "Fiches_Societes"` sauf `RelvMo` qui passe par `Cbase.Table("TabSoc")`).
  Les lectures **sans `WHERE`** relevées ailleurs (`Edart4:365`, `EdReg:16`, `Ecomptamat:26`,
  `Einvmat:24`, `Extrait:1309`, `Parametre:150`, `ExportJdv:72`, `ExportA47:44`) concernent
  d'autres éditions et n'utilisent pas `Creleve`.
- **Construction** : `Rs = type_sc & " " & int_sc`, `ville = cp_sc & "  " & burdis_sc`,
  `jour = burdis_sc & "  le  " & <date>`, puis 11 libellés conditionnels (`If rResult!champ Then
  X = "Libellé : " & champ`), dont SIRET préfixé par `/Soc<XX>/Siret` (paramètre local) et IBAN
  « Iban : … Bic : … ».
- **Proposition précise** (pour la phase 3, sans changement de rendu) :
  1. une fonction de **lecture** pure, partagée par les six fichiers (et utilisable par
     `Cdocuments`) : `EnteteSocieteLit() As Collection` (clés `rs`, `adr1`, `adr2`, `ville`, `cap`,
     `rcs`, `siret`, `ape`, `tvaintra`, `tel`, `portable`, `fax`, `mail`, `site`, `iban`, `lieu`),
     avec la requête paramétrée `WHERE cd_sc = &1` et `Cbase.Table("TabSoc")` ; place proposée : un
     module de relances ou `Utils` (à arbitrer en phase 3, une méthode de gabarit PDF ne devrait pas
     émettre de SQL) ;
  2. dans `Creleve`, `Public Sub EnteteSociete(hSoc As Collection)` qui appelle `Entete` avec les
     valeurs de la collection, `Pays = ""` et `Col = False` (valeurs actuelles sans effet) ;
  3. `Cdocuments` reçoit la même collection (`Visudoc`, `Libre` restent des paramètres).
  Les appelants gardent leur variable `jour` (lieu et date) : elle est construite à partir de la
  même ligne et doit rester identique.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `EnteteN` (mort), `_free`, la variable `Coln`, les paramètres `Pays` (`Entete`), `Col`
  (`Entete`, `Entete2`) et `Jour` (`Level1`) : appelants à modifier dans le même commit.
- `Entete` : boucle sur un tableau de lignes optionnelles (`[cap, rcs, siret, ape, tvaintra, tel,
  portable, fax, site, mail]`) au lieu de 10 blocs `If` identiques ; CC 12 → 3, rendu identique
  (l'ordre site/courriel et la police de l'IBAN sont conservés).
- `Level7` et `Level3` : helper privé `LigneTableau(largeur_date, …)` ; `Level2`/`Level6` : helper
  `EnTeteTableau(y, largeur_date)`.

### Commonalisation avec d'autres fichiers

- `_new`, `Lines`, `EnteteN` → base commune `PdfLaurux` (voir
  [Ccompta](../Ccompta.class/architecture.md#commonalisation-avec-dautres-fichiers)).
- `Logo` = `Clivre.Logo` (classe morte) ≈ `Cfacture.Logo`, `Cdocuments.Logo`, `Cdocuments2.Logo` :
  `LogoSociete(x, y, L, h)` dans la base.
- En-tête société : voir la section dédiée ci-dessus (6 copies → 1 lecture + rendu).

### Réduction de portée

- `Logo` → `Private` (appelé seulement par `Entete`) ; couverture assurée par les tests d'`Entete`.
- `EnteteN` : suppression.

### Séparation traitement / GUI

- `Logo` : séparer la lecture de configuration et le calcul de position (`PositionLogo(chemin) As
  Float[]`) du `Me.Image`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les libellés de l'en-tête société sont recomposés à chaque édition ; une vue ou des colonnes
  préformatées dans `Fiches_Societes` sont possibles mais sans gain réel (rendu local).
