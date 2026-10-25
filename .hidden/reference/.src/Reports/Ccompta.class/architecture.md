# Ccompta — Architecture

> Source : `.src/Reports/Ccompta.class`

## Vue d'ensemble

`Ccompta` est le **gabarit PDF des éditions comptables** : une classe `Inherits PdfWriter` sans
état métier, qui ne fait que de la mise en page (positions en mm, polices Helvetica, cellules
`Cell`). Elle ne lit pas la base, ne calcule presque rien et ne décide d'aucun saut de page :
chaque écran appelant ouvre le document (`New Ccompta("Portrait", "mm", "A4")`, `Open`,
`AliasNbPages`), parcourt ses données, appelle les « niveaux » `Level*` avec une ordonnée `PosY`
qu'il gère lui-même, appelle `BasPage` puis `Entete` quand il juge la page pleine, et termine par
`Output`.

Les 52 méthodes forment des **familles de niveaux**, une par édition (en-têtes de colonnes, ligne
de détail, totaux). Le suffixe indique l'édition :

| Famille | Méthodes | Édition / appelants |
|---|---|---|
| Communes | `Entete`, `BasPage`, `BasPage2`, `Lines`, `Level0` | 15 appelants (voir dependencies.md) |
| Extraits, impayés, non lettrées, non justifiées | `Level1`, `level2`, `Level3`, `Level4`, `Level5`, `Level6` | `EdImpayes`, `EdNlettrees`, `EdNjustifiees`, `Pointage` (`Level6`) |
| Échéancier (`E`) | `Level1E`, `level2E`, `Level4E`, `Level5E` | `Compta/Impressions/Echeancier` |
| Anomalies de clés (`A2`) | `Level1A2`, `level2A2` | `Anomalies` |
| Journaux (`J`, `JT`) | `Level0J`, `Level1J`, `level2J`, `Level1JT`, `level2JT`, `Level5J`, `level6J`, `level7J` | `JournauxA`, `JournauxM`, `Jourcent` |
| Écritures modifiées (`M`) | `Level1M`, `level2M` | `EcrM` |
| Plan comptable (`P`) | `Level0P`, `Level1P`, `level2P` | `Plancomptable`, `Anomalies` (`Level0P`) |
| Grand livre / extraits de comptes (`C`, `s`, `T`) | `Level0C`, `Level1C`, `Level2C`, `Level2s`, `Level2sbis`, `Level3C`, `Level4C`, `Level4T`, `Level5C` | `EditcompteM`, `EditcompteA` |
| Rapprochement bancaire (`R`) | `Level0R`, `Level1R`, `Level2R`, `Level3R` | `Pointage` |
| Traites (`T`) | `Level1T`, `Level2T`, `Level3T` | `Gestion/Impressions/Traites`, `Gestion/Lcr/Lcr.Imp_Traites` |
| Analytique (`A`, `CA`) | `Level0A`, `Level1A`, `Level2A`, `Level1CA`, `Level2CA` | `JournauxA`, `EditcompteA` |

Nature globale : **GUI (rendu PDF)**. Le seul « calcul » est le formatage des montants
(`Format$(…, ",0.00")`), la normalisation du solde `-0,00` → `0,00` (`level2J`, `level2M`,
`level2JT`) et le solde débit − crédit de `Level2s`.

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
| `Entete` | 20-28 | Public | 1 | 7 | 15 |  |
| `BasPage` | 31-38 | Public | 1 | 6 | 12 |  |
| `BasPage2` | 41-48 | Public | 1 | 6 | 3 |  |
| `Lines` | 51-57 | Public | 1 | 5 | 10 |  |
| `Level0` | 59-67 | Public | 1 | 7 | 4 |  |
| `Level1` | 70-87 | Public | 1 | 15 | 3 |  |
| `Level1E` | 90-105 | Public | 1 | 13 | 1 |  |
| `level2` | 108-123 | Public | 1 | 13 | 3 |  |
| `Level1A2` | 126-140 | Public | 1 | 12 | 1 |  |
| `level2A2` | 143-156 | Public | 1 | 11 | 1 |  |
| `level2E` | 159-173 | Public | 1 | 12 | 1 |  |
| `Level3` | 176-185 | Public | 1 | 7 | 2 |  |
| `Level4` | 188-200 | Public | 1 | 10 | 2 |  |
| `Level4E` | 203-213 | Public | 1 | 8 | 1 |  |
| `Level5` | 216-228 | Public | 1 | 10 | 2 |  |
| `Level5E` | 231-241 | Public | 1 | 8 | 1 |  |
| `Level6` | 244-254 | Public | 1 | 8 | 2 |  |
| `Level0J` | 258-266 | Public | 1 | 7 | 3 |  |
| `Level1J` | 269-286 | Public | 1 | 15 | 2 |  |
| `level2J` | 289-307 | Public | 2 | 16 | 2 |  |
| `Level1M` | 310-328 | Public | 1 | 16 | 1 |  |
| `level2M` | 330-349 | Public | 2 | 17 | 1 |  |
| `Level1JT` | 353-365 | Public | 1 | 10 | 1 |  |
| `level2JT` | 367-379 | Public | 2 | 10 | 1 |  |
| `Level5J` | 382-389 | Public | 1 | 6 | 1 |  |
| `level6J` | 392-405 | Public | 1 | 11 | 3 |  |
| `level7J` | 408-420 | Public | 1 | 10 | 3 |  |
| `Level0P` | 423-429 | Public | 1 | 5 | 2 |  |
| `Level1P` | 432-442 | Public | 1 | 8 | 1 |  |
| `level2P` | 445-454 | Public | 1 | 7 | 1 |  |
| `Level0C` | 458-465 | Public | 1 | 6 | 2 |  |
| `Level1C` | 468-485 | Public | 1 | 15 | 1 |  |
| `Level2C` | 488-503 | Public | 1 | 13 | 1 |  |
| `Level2s` | 506-528 | Public | 5 | 20 | 1 |  |
| `Level2sbis` | 530-535 | Public | 1 | 4 | 0 | portée réductible ? |
| `Level3C` | 538-545 | Public | 1 | 6 | 2 |  |
| `Level4C` | 548-558 | Public | 1 | 9 | 2 |  |
| `Level4T` | 561-573 | Public | 1 | 11 | 1 |  |
| `Level5C` | 576-587 | Public | 1 | 10 | 2 |  |
| `Level0R` | 591-601 | Public | 1 | 9 | 1 |  |
| `Level1R` | 604-615 | Public | 1 | 10 | 1 |  |
| `Level2R` | 618-629 | Public | 1 | 10 | 1 |  |
| `Level3R` | 632-645 | Public | 1 | 12 | 1 |  |
| `Level1T` | 649-663 | Public | 1 | 13 | 2 |  |
| `Level2T` | 666-695 | Public | 1 | 28 | 2 |  |
| `Level3T` | 698-713 | Public | 1 | 14 | 0 | portée réductible ? |
| `Level0A` | 717-725 | Public | 1 | 7 | 1 |  |
| `Level1A` | 728-737 | Public | 1 | 7 | 1 |  |
| `Level2A` | 739-748 | Public | 1 | 7 | 1 |  |
| `Level2CA` | 751-766 | Public | 1 | 13 | 1 |  |
| `Level1CA` | 769-786 | Public | 1 | 15 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Conventions communes à toutes les méthodes : `h` = hauteur de cellule (5 mm pour une ligne, 6 pour
un en-tête) ; `cell(w, h, txt, bordure, ln = 0, align, remplissage)` ; aucune méthode ne modifie la
base ni l'état global ; toutes sont `[nature : GUI]` (rendu pur). Les montants reçus sont des
`String` (souvent une valeur Float de `Result` convertie implicitement par l'appel) et sont formatés
par `Format$(chaîne, ",0.00")` : la conversion chaîne → nombre faite par `Format$` n'est pas
localisée côté Gambas (à confirmer par CCOMPTA-T08 : une chaîne `"1234,5"` lèverait une erreur).

### Méthodes spéciales et communes

- **`_new()`** [portée : nécessaire (spéciale)] [nature : GUI]. Copie les couleurs du thème
  `Start.R/G/B` dans les membres privés `R`, `G`, `B` (couleur de remplissage des en-têtes). Les
  arguments de `New Ccompta("Portrait", "mm", "A4")` vont au `_new` de `PdfWriter`.
- **`_free()`** : vide (code mort).
- **`Entete(sEntete)`** [portée : nécessaire, 15 appelants] : **nouvelle page** (`AddPage`) puis
  titre centré 16 pt gras italique dans une cellule bordée et remplie (x = 4, largeur 200). C'est
  le seul niveau qui crée une page.
- **`BasPage()`** [portée : nécessaire, 12 appelants] : pied de page à 10 mm du bas,
  `"Page n/{nb} - jj/mm/aaaa - Impression demandée par <User.Name>"`. `{nb}` n'est remplacé que si
  l'appelant a fait `AliasNbPages`. Dépend de `Now` et de `User.Name` (à neutraliser en test).
  `Function` sans type de retour ni `Return` : renvoie `Null` (sans usage).
- **`BasPage2(ipage)`** [portée : nécessaire, `EcrM`, `JournauxA`, `JournauxM`] : variante avec un
  numéro de page fourni par l'appelant (`"Page N° " & ipage`), sans `{nb}`.
- **`Lines(PosY As String)`** [portée : nécessaire, 10 appelants] : `SetXY(7, PosY)` puis trait
  horizontal de 0 à 280 mm (au-delà de la largeur A4 portrait, le trait est rogné). Le `SetXY` a un
  effet de bord (position courante) : ne pas le supprimer sans vérifier les appelants qui
  enchaînent un `cell` sans `SetXY`.
- **`Level0(dateedition, ste)`** [portée : nécessaire] : société (ligne 12) et
  `"Sélection   <dateedition>"` (ligne 18).

### Extraits, impayés, non lettrées, non justifiées

| Fonction | Rendu | Remarques |
|---|---|---|
| `Level1()` | en-tête 9 colonnes Compte … Solde, y = 25 | |
| `level2(intitule, jour, dte, numero, Lot, montantd, montantc, solde, PosY)` | ligne de détail à partir de x = 22 (la colonne Compte est remplie par `Level3`) | 3 montants `Format$` |
| `Level3(cpt, intit, PosY)` | compte + intitulé en gras | corps identique à `Level2A` |
| `Level4(totd, totc, tots, PosY)` | « Total compte » + 3 cellules remplies | |
| `Level5(totd, totc, tots, PosY)` | « Total extrait » + 3 cellules remplies | même code que `Level4`, libellé seul différent |
| `Level6(cpt, intit, solde, PosY)` | compte, intitulé, solde (non formaté) | `EdNjustifiees`, `Pointage` |

### Échéancier

`Level1E` (en-tête 7 colonnes), `level2E` (ligne, x = 4, montant `Format$`), `Level4E(intit, tot,
PosY)` (total intermédiaire libellé), `Level5E(tot, PosY)` (« Total échéancier »). Appelant unique :
[Echeancier](../../Compta/Impressions/Echeancier.class/architecture.md).

### Anomalies de clés

`Level1A2` (en-tête Numéro, Compte, Intitulé, Date, Clé mémorisée, Clé calculée ; 6 pt) et
`level2A2(Numero, compte, intitule, $Date, $cle, $cle2, PosY)`. Appelant :
[Anomalies](../../Compta/Impressions/Anomalies.class/architecture.md).

### Journaux

- `Level0J(compte, Intit, dateedition, qual, ste)` : société + `"Journal N°  <compte>  <intit>  <date>  <qual>"`.
  `Level0A` est identique au préfixe « Journal N° » près.
- `Level1J()` / `level2J(intitule, compte, dte, numero, Libelle, montantd, montantc, solde, posy, Nlot)` :
  en-tête 9 colonnes et ligne (7 pt), intitulé et libellé tronqués à 28 caractères, solde
  `-0,00` → `0,00` (calcul local sur le paramètre).
- `Level1JT()` / `level2JT(montantd, montantc, solde, posy)` : totaux de journal (même normalisation).
- `Level5J(Jnal)` : bandeau « Centralisation journal … » ; `level6J()` : en-tête centralisation ;
  `level7J(cd, intitule, db, crd, sld, posy)` : ligne de centralisation. ⚠️ Le débit est imprimé par
  `Left$(db, 24)` **sans** `Format$`, alors que crédit et solde sont formatés (CCOMPTA-A02).
- Arité : `JournauxA:695` appelle `level2J` avec 9 arguments pour 10 (`Nlot` absent, non optionnel)
  → erreur « Not enough arguments » (anomalie de l'appelant JOURNAUXA-A01).

### Écritures modifiées

`Level1M()` (10 colonnes dont Statut et Date de modification) et `level2M(…, Nlot, dtem)` : même
schéma que `level2J`, largeurs différentes, un paramètre de plus. Appelant : `EcrM`.

### Plan comptable

`Level0P(ste)`, `Level1P()` (Compte, Intitulé à x = 50), `level2P(compte, intitule, posy)` (intitulé
tronqué à 24 caractères).

### Grand livre et extraits de comptes

- `Level0C(dateedition, ste)` : `"Edition  <date>"` puis société sur la même ligne.
- `Level1C()` / `Level1CA()` : en-têtes 9 colonnes, identiques sauf deux libellés (« Numéro »/« Lot »
  contre « N° Ecr. »/« N° Lot »).
- `Level2C(lib, jour, dte, numdoc, numlot, deb, cred, solde, posY)` et `Level2CA(lib, jour, dte, numero,
  numdoc, deb, cred, solde, posY)` : **corps identiques** aux noms de paramètres près ; montants non
  formatés (déjà formatés par l'appelant).
- `Level2s(code, intitule, stotdeb, stotcred, posY)` [nature : mixte, calcul extractible : solde
  `Val(Utils.cpoint(deb)) - Val(Utils.cpoint(cred))`] : bandeau gris (240) des totaux de
  sous-comptes ; remplace `"0"` par `""` ; **laisse la couleur de remplissage à blanc** (255) en
  sortie. `code` est inutilisé. Appelant : `EditcompteM:129`.
- `Level2sbis(cpt, posy)` : bandeau « Début des sous_comptes … » — **jamais appelé** (code mort,
  identique à `Cbalances.Level2sbis`, lui aussi mort).
- `Level3C(code, intitule, Posy)` : compte en gras.
- `Level4C(totdeb, totcred, totsld, compte, posy)` : « Total compte <compte> » dans une cellule
  remplie **avec la couleur courante** (non fixée : couleur du thème, ou blanc après `Level2s`, voir
  CCOMPTA-A01) ; `totsld` non formaté (l'appelant `EditcompteM` le formate). Arité : `EditcompteA:726`
  l'appelle avec 4 arguments pour 5 (`compte` manquant) → erreur d'exécution (EDITCOMPTEA-A01).
- `Level4T(totdeb, totcred, totsld, classe, posy)` : « Total classe » sur fond gris 240, puis
  restaure la couleur du thème.
- `Level5C(slddeb, sldcred, sldtot, Posy)` : « Total grand livre » sur fond gris, **sans** restaurer
  la couleur.

### Rapprochement bancaire

`Level0R(code, intitulb, num, dateedition, typeligne, ste)` (3 lignes d'en-tête), `Level1R(Posy)`
(en-tête de colonnes rempli avec la couleur courante, fixée par `Entete`), `Level2R(…)` (ligne),
`Level3R(totnp, totp, totpnp, Posy)` (totaux relevé). Appelant :
[Pointage](../../Compta/Pointage.class/architecture.md).

### Traites

- `Level1T(Posy)` : en-tête 9 colonnes (banque, guichet, compte, RIB, domiciliation, nom, dates,
  montant), rempli avec la couleur courante.
- `Level2T(setb, sguichet, snum, srib, sdom, snom, sadr1, sadr2, scp, sdate, sdatech, smontant,
  numfac, Posy)` (14 paramètres) : ligne bancaire, `"N° facture "` dans la colonne « Nom », puis
  nom et 3 lignes d'adresse sous la colonne (x = 105) et un trait. `Posy` est incrémenté
  **localement** (+25) : l'appelant doit avancer lui-même.
- `Level3T(totnp, totp, totpnp, Posy)` : « Total traites / écritures pointées… » — **jamais
  appelé** (code mort ; libellés hérités du rapprochement).

Appelants : `Gestion/Impressions/Traites` et `Gestion/Lcr/Lcr.Imp_Traites` (copie quasi identique,
voir [Lcr](../../Gestion/Lcr/Lcr.class/architecture.md)).

### Analytique

`Level0A(compte, Intit, dateedition, qual, ste)` (= `Level0J` sans « Journal N° »), `Level1A(cpt,
intit, PosY)` (poste analytique, x = 80, 10 pt), `Level2A(cpt, intit, PosY)` (**corps identique** à
`Level3`), `Level1CA()` et `Level2CA(…)` (voir grand livre).

## État global utilisé

- `Start.R`, `Start.G`, `Start.B` (couleurs du thème, lues une fois dans `_new`).
- `User.Name`, `Now` (pied de page).
- `Utils.cpoint` (`Level2s`).
- État hérité de `PdfWriter` : position courante, police, **couleur de remplissage courante**
  (plusieurs niveaux remplissent sans la fixer : `Level4C`, `Level1R`, `Level1T`, `Level3R`).
- Saut de page automatique de `PdfWriter` (`SetAutoPageBreak(True, 2 * marge)` dans
  `PdfWriter._new`) : une cellule dont le bas dépasse ≈ 295 mm (A4 portrait) déclenche un `AddPage`
  **sans** `Entete` ni `BasPage`. Les appelants l'évitent en gérant `PosY` (seuil 273-283 selon
  l'écran).

## Propositions d'amélioration

### Réécriture / refactorisation

- `Level2CA` → délègue à `Level2C` (corps identique) ; `Level2A` → délègue à `Level3` ; `Level5`
  et `Level4` → helper privé `TotalLigne(libellé, d, c, s, PosY)`. Signatures publiques conservées,
  séquence d'appels `PdfWriter` identique (PDF identique à l'octet près).
- En-têtes de colonnes (`Level1`, `Level1E`, `Level1A2`, `Level1J`, `Level1M`, `Level1JT`,
  `Level1P`, `Level1C`, `Level1CA`, `level6J`, `Level1R`, `Level1T`) : helper privé
  `EnTeteColonnes(x, y, taille, libellés As String[], largeurs As Integer[], remplir As Boolean)`
  qui émet exactement les mêmes `SetXY`/`SetFont`/`SetFillColor`/`cell`.
- Normalisation `-0,00` → `0,00` répétée 3 fois (`level2J`, `level2M`, `level2JT`) et dans les
  appelants (`EditcompteM:229-230`) : helper privé `SoldeAffiche(s) As String`.
- `Lines(PosY As String)` : passer le paramètre en `Integer` (tous les appelants passent un entier).
- Supprimer `_free` (vide), `Level2sbis` et `Level3T` (morts).

### Commonalisation avec d'autres fichiers

**Base commune des gabarits PDF (`PdfLaurux`)** — proposition transverse du lot Reports, reprise
de [CLcr](../../Gestion/Lcr/CLcr.class/architecture.md) (CLCR-005). Constat sur les 23 classes
`Inherits PdfWriter` (comparaison des corps normalisés) :

| Élément | Copies identiques | Fichiers |
|---|---|---|
| `_new` (R, G, B = `Start.R/G/B`) | 12 (+5 avec `SetFillColor`, +2 à couleur fixe 223) | `Ccompta`, `Cbalances`, `Cecheancier`, `Cbordereaux`, `Clivre`, `Cresultat`, `Cstocks`, `Cclients`, `Cdocuments2`, `Cetiquettes`, `Htickets`, `CLcr` ; `Creleve`, `Ctraites`, `Chistoriques`, `Cmat`, `Carticles` ; `Cbilan`, `Csig` |
| Pied de page « Page n/{nb} - date - Impression demandée par » (190 mm, rempli) | 8 | `BasPage` de `Ccompta`, `Cbalances`, `Cbilan`, `Cresultat`, `Cecheancier`, `Cstocks`, `CLcr` + `Cbordereaux.Footer` |
| Variantes du pied de page | 3 groupes | 206 mm sans couleur (`Clivre`, `Cclients`) ; 290 mm (`Csig`, paysage) ; `Cdocuments*` |
| Titre de page (`AddPage` + bandeau 16 pt, x = 2, 206 mm) | 9 | `EnteteN` de `Creleve`, `Ctraites`, `Cdocuments`, `Cdocuments2` ; `Entete` de `Cbalances`, `Cecheancier`, `Cclients`, `CLcr` ; `Cbordereaux.EnteteP` (paramètre `PosY` inutilisé) |
| Variante du titre (x = 4, 200 mm, gras italique) | 1 | `Ccompta.Entete` |
| `Level0(nom, dateedition, ste)` | 2 | `Cbalances`, `CLcr` |
| `Logo()` (logo société proportionnel) | 2 identiques + 3 voisins | `Creleve`, `Clivre` ; `Cfacture`, `Cdocuments`, `Cdocuments2` |
| `newPage()` / `Entete()` = `AddPage` seul | 7 | `Cfacture`, `Clivre`, `Cticket`, `Cetiquettes`, `Cbordereaux.Entete`, `Htickets.Entete`, `Cdocuments.EnteteV` |

Proposition (nom retenu par PDFWRITER-011, voir [PdfWriter](../PdfWriter.class/architecture.md)) : une classe `PdfLaurux` (`Inherits PdfWriter`, les gabarits passant à
`Inherits PdfLaurux`) qui porte `_new` (couleurs du thème), `TitrePage(titre, Optional x = 2,
Optional largeur = 206, Optional style = "B")`, `PiedPage(Optional largeur = 190, Optional
remplir = True)`, `LogoSociete(Optional x, y, L, h)` et `NouvellePage()`. Contraintes :

- **Ne pas** nommer ces méthodes `Entete`, `BasPage`, `Logo`, `Header` ou `Footer` dans la base :
  `Creleve.Entete` (17 paramètres), `Cbordereaux.Logo(Logo)` et les `Header`/`Footer` de
  `PdfWriter` ont des signatures différentes ; les méthodes publiques actuelles restent dans chaque
  gabarit comme délégations d'une ligne (appelants inchangés). La règle Gambas de surcharge
  (signature identique exigée ou non) est à confirmer par `gbc3`.
- Le nom `CBase` est exclu (collision à la casse près avec le module `Cbase`).
- Règles Gambas vérifiées lors de l'étude de `PdfWriter` : un membre `Private` du parent est
  **invisible** pour la sous-classe (erreur seulement à l'exécution) et une sous-classe doit écrire
  `Me.X` pour appeler un membre hérité. Les couleurs ne peuvent donc pas rester des `Private R, G,
  B` partagés : la base expose une méthode `CouleurTheme()` (`SetFillColor(R, G, B)`) ou des
  propriétés en lecture, et les gabarits qui lisent `R`/`G`/`B` directement sont adaptés.
- `PdfWriter.Header`/`Footer` sont des crochets désactivés (appels commentés dans `AddPage`/`Close`) :
  le rework de [PdfWriter](../PdfWriter.class/architecture.md) ne doit pas les réactiver, sinon
  `Footer` est surchargé dans `Cbordereaux`, `Carticles`, `Chistoriques`, `Cmat` et `Htickets`, qui
  seraient alors appelés automatiquement (pieds de page en double). Dans le parent, un appel
  `Footer()` sans `Me.` exécute la version du parent.

Autres commonalisations :

- Libellé société `ste = "Société  " & int_sc`, recalculé par chaque appelant après un
  `SELECT * FROM Fiches_Societes WHERE cd_sc = &1` (≈ 15 copies : `Echeancier:132`,
  `EdImpayes:312`, `Plancomptable:190`, `EdNlettrees:369`, `EdNjustifiees:251`, `EditcompteM:79`,
  `Jourcent:669`, `EcrM:421`, `JournauxM:72`, `Imp_Sig:133`, `Imp_Bilan:153`, `RubImp:534`…). Les
  textes diffèrent (« Société » / « Societe ») : un helper `LibelleSociete(Optional accent = True)`
  doit conserver la variante de chaque appelant. Voir aussi l'en-tête société des relances
  ([Creleve](../Creleve.class/architecture.md)).
- `Lcr.Imp_Traites` ≈ `Traites` (deux appelants des niveaux `T`) : commonalisation côté appelants
  (voir [Lcr](../../Gestion/Lcr/Lcr.class/architecture.md)).

### Réduction de portée

Aucune : toutes les méthodes vivantes ont au moins un appelant externe (tableau des fonctions).
`Level2sbis` et `Level3T` sont à supprimer plutôt qu'à rendre `Private`.

### Séparation traitement / GUI

- `Level2s` : extraire le calcul du solde (`SoldeDebitCredit(deb, cred) As String`, même
  `Format$`), partagé avec `Cbalances.Level2a/Level3a/Level4a` (même formule).
- Le reste est du rendu pur.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : la classe n'accède pas à la base.
