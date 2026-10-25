# Caleditcmat — Architecture

> Source : `.src/Gestion/option/Caleditcmat.class`

## Vue d'ensemble

Écran **« Edition de la compta matiére »** de l'option boissons : contrôle, édition et **clôture
mensuelle de la comptabilité matières** des alcools (volumes effectif et d'alcool pur, droits
d'accises, cotisation sécurité sociale), séparément pour le régime **acquitté** et le régime
**suspendu**. Ouvert en modal par `menuopt.cmat_click` (`menuopt.class:69`,
`Caleditcmat.ShowModal` : c'est l'**auto-instance** du formulaire qui est affichée, ce qui rend
valide l'accès `Caleditcmat.ddcl` depuis les reports).

Commandes (`.form`) : mois/année (`Textmois`, `Textanne`), régime (`acquite`/`suspendu`), mode
(`provisoire`/`cloture`), « Calcul sur fiche régie » (`calcregie`), nombre de décimales (`nbdec`)
et arrondi (`math`/`inf`/`sup`) ; boutons Control, Edition, Rédition, Detail, Visu, et éditions de
stock (Inventaire, Inventaire tournant, Stock de départ, Stock) déléguées à
[EditStkDepart](../EditStkDepart.class/architecture.md).

Tables :
- **lues** : `Fiches_ligregie` (mouvements `E` entrées, `S` sorties, `C`, stock début de mois `M`,
  inventaire annuel `I`), `Fiches_regie` (régime `suspendu`, taux `tauxa`/`tauxss`), `Fiches_Bl`,
  `Fiches_Ligbl` (BL non facturés, `type='B'`), `Fiches_HistoFac`, `Fiches_HistoLigfac`,
  `Fiches_Art` (`art_dra`, `art_volm`, `art_deg`) ; indirectement, via `ObjFacB`/`Calculdroit`,
  les tables de facturation et de TVA ;
- **écrites (clôture)** : `Fiches_ligregie` — `UPDATE … SET cloture=True` des mouvements du mois,
  puis **insertion** d'une ligne de type `M` par régie (stock de début du mois suivant).

**Module complexe** : la clôture modifie de façon irréversible les données fiscales de la
comptabilité matières (elle n'écrit **pas** d'écriture comptable `Fiches_Mvt*`). Les scénarios de
test doivent être validés par l'utilisateur avant la phase 2 (voir test.md).

Aucune table `*M` du matériel (`Fiches_BlM`, `Fiches_HistoFacM`, `Fiches_EntMat`,
`Fiches_HisentMat`, voir [Materiel](../../Tables/Materiel.class/architecture.md)) n'est lue ni
écrite : « cmat » signifie comptabilité **matières**. `Fiches_regie`/`Fiches_ligregie` sont créées à
l'exécution par [`modfichier.fichierboisson`](../modfichier.module/architecture.md) (hors
`db_control.csv`, `Laurux01.sql` et `Cbase`).

Nature : **mixte** (calculs de déclaration, SQL et construction de reports dans les mêmes
fonctions).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$dteinv` | var | Private |  | New LDate | 3 |
| `$dteinf` | var | Private |  | New LDate | 4 |
| `$coul` | var | Private |  | Integer | 5 |
| `vdp` | var | Private |  | Float | 8 |
| `ven` | var | Private |  | Float | 9 |
| `vso` | var | Private |  | Float | 10 |
| `vfp` | var | Private |  | Float | 11 |
| `vae` | var | Private |  | Volume | 15 |
| `vap` | var | Private |  | Volume | 16 |
| `totvol` | var | Private |  | Stk | 20 |
| `qteimp` | var | Private |  | Float | 21 |
| `tarifdr` | var | Private |  | Float | 22 |
| `tarifss` | var | Private |  | Float | 23 |
| `droit` | var | Private |  | Float | 24 |
| `secu` | var | Private |  | Float | 25 |
| `volumess` | var | Private |  | Float | 26 |
| `ddcl` | var | Public |  | Declaration | 29 |
<!-- /AUTO:declarations -->

Structures `Public` : `Volume` (`vdp` début de période, `ven` entrées, `vso` sorties, `vfp` fin de
période), `Stk` (`vae` volume effectif, `vap` alcool pur), `Declaration` (`totvol`, `qteimp`,
`tarifdr`, `tarifss`, `droit`, `secu`, `volumess`). `ddcl` (`Public`, une `Declaration`) n'est
utilisé que par [Ecomptamat](../Ecomptamat.class/architecture.md) et
[Einvmat](../Einvmat.class/architecture.md) comme variable de travail.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 31-49 | Public | 1 | 15 | 0 | méthode spéciale |
| `Control_Click` | 51-55 | Public | 1 | 3 | 0 | handler GUI |
| `ctrl` | 57-139 | Private | 14 | 61 | 0 |  |
| `ctrlachat` | 142-169 | Private | 7 | 26 | 0 |  |
| `calcdate` | 172-221 | Private | 14 | 44 | 0 |  |
| `Edition_Click` | 223-257 | Public | 7 | 31 | 0 | handler GUI |
| `Redition_Click` | 259-264 | Public | 1 | 4 | 0 | handler GUI |
| `Visu_Click` | 266-270 | Public | 1 | 3 | 0 | handler GUI |
| `Edit` | 272-440 | Private | 35 | 156 | 0 |  |
| `decim` | 442-456 | Private | 4 | 13 | 0 |  |
| `decldcl` | 458-467 | Private | 1 | 8 | 0 |  |
| `Quitter_Click` | 470-474 | Public | 1 | 3 | 0 | handler GUI |
| `detail_Click` | 476-590 | Public | 13 | 108 | 0 | handler GUI |
| `entete` | 592-720 | Private | 1 | 108 | 0 |  |
| `entreg` | 722-730 | Private | 1 | 6 | 0 |  |
| `soustot` | 732-781 | Private | 5 | 38 | 0 |  |
| `ligne` | 783-893 | Private | 9 | 93 | 0 |  |
| `inv_Click` | 896-900 | Public | 1 | 3 | 0 | handler GUI |
| `invt_Click` | 902-906 | Public | 1 | 3 | 0 | handler GUI |
| `stdep_Click` | 908-912 | Public | 1 | 3 | 0 | handler GUI |
| `stock_Click` | 914-918 | Public | 1 | 3 | 0 | handler GUI |
| `editinv` | 920-932 | Private | 1 | 10 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et commandes simples

- **`_new()`** [portée : nécessaire] [nature : GUI] : chaînage de saisie, masques `TextReg`
  (décimales 0-9, mois sur 2 chiffres, année sur 4), mois et année courants, couleur du thème
  (`Start.R/G/B`) dans `$coul`.
- **`Control_Click()`** [handler] : appelle `ctrl` (résultat ignoré, affichage dans `Textcontrol`).
- **`Visu_Click()`** [handler] : `Visucmat.Show` ([Visucmat](../Visucmat.class/architecture.md)).
- **`Quitter_Click()`** [handler] : `Me.Close`.
- **`inv_Click` / `invt_Click` / `stdep_Click` / `stock_Click`** [handler ; `stdep` est le groupe
  du bouton `Button3`] : `editinv(EditStkDepart.<valeur>)`.
- **`editinv(choix)`** [Private] [nature : GUI] : imprime `New EditStkDepart(choix)` dans
  `~/tmp/stockmat.pdf` et l'ouvre par `Desktop.Open` (les autres éditions passent par
  `Visualiseur.Prog`).

### Contrôles

- **`calcdate()`** [Private] [nature : mixte] (CC 14) : valide mois (1-12) et année (2000-2100) par
  ballons ; fixe `$dteinf` au 1er du mois ; puis, en ajoutant des messages dans `Textcontrol` :
  « Période déjà cloturée » (ligne `M` datée du mois suivant, pour le régime choisi),
  « Le dernier arrêté annuel à plus de 12 mois » (dernière ligne `I`), « Il n'existe pas
  d'inventaire matiére », « Période précédente non cloturée » (aucune ligne `M`/`I` au 1er du mois,
  **tous régimes confondus**). En mode clôture, chacun de ces cas renvoie `True` (blocage). Le
  dernier message **remplace** le contenu de `Textcontrol` au lieu de s'y ajouter
  (`Textcontrol.Text =`, ligne 217 : CALEDITCMAT-A03). Ne renvoie `True` pour une date invalide
  qu'après les deux ballons.
- **`ctrl()`** [Private] [nature : mixte] (CC 14) : `Busy += 1`, vide `Textcontrol`, `calcdate`
  (si échec : **`Return True` sans `Busy -= 1`**, CALEDITCMAT-A01) ; barre de progression ;
  - BL non facturés (`Fiches_Bl.type='B'`) d'articles soumis à régie, du mois puis antérieurs,
    vérifiés par `ctrlachat` ;
  - pour **chaque BL imprimé** (`imp=1`) d'articles régie, **sans limite de date** : recalcul du
    document par `New ObjFacB(numfac, ObjFac.facture)` + `calcul`, et vérification qu'une ligne
    `Fiches_ligregie` existe pour chaque ligne soumise à régie (« Facture bl non trouvé ») —
    coûteux sur une base ancienne ;
  - pour chaque ligne de facture archivée (`Fiches_HistoLigfac`) d'article régie datée du mois ou
    après, existence de la ligne `Fiches_ligregie` (« Facture archive non trouvé »).
  Bloc de contrôle des achats non validés **commenté** (lignes 72-84). Renvoie `True` si une
  anomalie est trouvée.
- **`ctrlachat(res)`** [Private] [nature : mixte] (CC 7) : pour chaque ligne, lit la régie de
  l'article : erreur si la régie est du régime sélectionné (document non facturé dans la période
  déclarée) ou « Probléme de regie » si elle n'existe pas. Nom trompeur : elle contrôle des BL de
  vente, plus des achats.

### Édition et clôture

- **`Edition_Click()`** [handler] [nature : mixte] (CC 7) : en mode clôture, confirmation
  « Clôture de la CM ? » ; `Busy += 1` ; si `ctrl()` signale une anomalie **et** mode clôture :
  abandon. Sinon `tabl = Edit(False)` (mouvements non clôturés). En mode clôture :
  1. `UPDATE Fiches_ligregie,Fiches_regie SET cloture=True WHERE … dtmouv BETWEEN début et fin du
     mois AND cloture=False AND type IN (S,E,C) AND suspendu=<régime>` — **UPDATE multi-tables,
     syntaxe MySQL non traduite pour SQLite** (CALEDITCMAT-A06), exécuté **hors transaction** ;
  2. `Begin`, puis pour chaque régie de `tabl` une ligne `Create9("Fiches_ligregie")` : `dtmouv` =
     1er du mois suivant, `type='M'`, `coderegie`, `volume` = `vae.vfp`, `volumeap` = `vap.vfp`,
     `volumess` = **volume SS des sorties du mois** (et non un stock, à confirmer), `cloture=True` ;
     `Commit`. Si l'insertion échoue, les mouvements restent clôturés sans report de stock
     (CALEDITCMAT-A04).
  En mode provisoire, une anomalie détectée par `ctrl` n'empêche pas l'édition ; si c'est la date
  qui est invalide, `Edit` utilise la **période précédemment calculée** (`$dteinf` inchangé).
- **`Redition_Click()`** [handler] : `ctrl` (résultat ignoré) puis `Edit(True)` (mouvements déjà
  clôturés). Le report Ecomptamat reçoit pourtant `edit = False` pour la plage de vignettes
  (CALEDITCMAT-A05).
- **`Edit(clt)`** [Private] [nature : mixte] (**CC 35, max du fichier**) : construit la
  `Collection` de `Declaration` par code régie, pour le régime choisi :
  1. stock de début : lignes `I` du mois, à défaut lignes `M` du mois (`vdp`, taux `tauxa`/`tauxss`
     ÷ 100) ;
  2. entrées : `SUM(volume)`, `SUM(volumeap)` des lignes `E` (`cloture = clt`) par régie ;
  3. sorties : si `calcregie`, recalcul ligne par ligne par `New Calculdroit(regie,
     volume/qte*100, degres, qte)` (lignes à `qte = 0` ignorées) ; sinon sommes des montants
     enregistrés (`montdr`, `montss`, `volumess`) ;
  4. pour chaque régie : `vfp = vdp + ven - vso` ; quantité imposable = sorties AP (ou effectives si
     nulles) ; tarifs déduits des montants s'ils sont nuls ; arrondi des montants selon `math`
     (`Round` à `nbdec`), `inf` (`Floor`) ou `sup` (`Ceil`) via `decim` ;
  5. si la collection n'est pas vide : impression dans `~/tmp/cmtmat.pdf` par
     `New Ecomptamat(…)` (suspendu) ou `New Einvmat(…)` (acquitté), puis `Visualiseur.Prog`.
  Renvoie la collection (utilisée par la clôture). Variables `resreg`, `restx`, `cdroit` (hors
  sorties) inutilisées.
- **`decim(value, op)`** [Private] [nature : calcul] : multiplie ou divise par 10, `nbdec` fois
  (décalage décimal pour `Floor`/`Ceil`) ; lit le contrôle `nbdec`.
- **`decldcl()`** [Private] [nature : calcul] : fabrique une `Declaration` avec ses sous-structures.

### Détail des mouvements

- **`detail_Click()`** [handler] [nature : mixte] (CC 13) : `calcdate` (résultat ignoré) ; pour
  chaque régie (`Fiches_regie`), état paysage `gb.report` construit par code (`entete`) : stock de
  début (`I` sinon `M`), mouvements `S`/`E`/`C` du mois triés par degré décroissant, avec solde
  courant et sous-total à chaque changement de degré ; puis les BL non facturés du mois
  (« Mouvements non validés », recalculés par `Calculdroit`) ; saut de page par régie. Impression
  dans `~/tmp/tarif.pdf`. Toutes régies et tous régimes confondus (pas de filtre `suspendu`), et
  mouvements clôturés compris. Dans la boucle des BL non validés, la branche `Else` (entrées) est
  **inatteignable** (la requête fixe `'S' AS type`) et contient une erreur de signe
  (`volap.vfp = volap.vdp - volap.ven`, ligne 571). Si `Fiches_regie` est vide, `rpr` reste
  `Null` et `rpr.Print` lève « Null object » (CALEDITCMAT-A07).
- **`entete()`** [Private] [nature : GUI] : report paysage, titre et ligne d'en-tête de 15
  colonnes (≈ 130 lignes de `New ReportLabel`).
- **`entreg(rpr, cde, lib)`** [Private] [nature : GUI] : ligne de titre de régie.
- **`soustot(rpr, totef, totap)`** [Private] [nature : GUI] : ligne « Total » (sorties et entrées).
- **`ligne(rpr, volef, volap, …)`** [Private] [nature : GUI] : ligne de détail (15 cellules).

## État global utilisé

- `Utils.db` (`Exec`, `Begin`, `Commit`, `Create9`), `Application.Busy`, `Start.R/G/B`,
  `User.Home` (`~/tmp/*.pdf`), `Visualiseur.Prog`, `Desktop.Open`.
- État d'instance : `$dteinf` (début du mois traité, **conservé** entre deux actions),
  `$dteinv` (date du dernier inventaire), `$coul`, `ddcl` (partagé avec les reports).
- Classes : `ObjFacB`/`ObjFac` (recalcul des factures), `Calculdroit`, `ProgBar`, `LDate`,
  `TextReg`, `Chainage`, `Ecomptamat`, `Einvmat`, `EditStkDepart`, `Visucmat`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Edit` (CC 35) : découper en `StockDebut(tabl, regime)`, `Entrees(tabl, regime, clt)`,
  `Sorties(tabl, regime, clt, calcregie)`, `TotauxEtArrondis(tabl, nbdec, mode)` et
  `ImprimeDeclaration(tabl, regime)` ; les trois blocs « si la régie existe, cumuler, sinon
  créer » deviennent une fonction `DeclarationRegie(tabl, code, res) As Declaration`.
- `ctrl` : extraire `ControleBlNonFactures`, `ControleFacturesBl`, `ControleFacturesArchivees` ;
  supprimer le bloc commenté des achats (ou le documenter comme désactivé).
- `detail_Click` : supprimer la branche inatteignable (comportement identique) ; extraire
  `MouvementsRegie(code)` du rendu.
- `entete`/`soustot`/`ligne` : ~300 lignes de `New ReportLabel` + police + bordure + largeur →
  fabrique commune (voir commonalisation).
- `decim` : garder la boucle (un `10 ^ nbd` changerait l'arrondi flottant) mais lui passer `nbd`
  en paramètre au lieu de lire `nbdec`.

### Commonalisation avec d'autres fichiers

- **Fabrique de `ReportLabel`** partagée avec [EditStkDepart](../EditStkDepart.class/architecture.md)
  (`dimention`).
- **`RegieSuspendue(code)`** commun avec [atribvignette](../atribvignette.class/architecture.md)
  (`suspendu`) et [calculdroit](../calculdroit.class/architecture.md) (propriété `suspendu`).
- **Prédicat « article soumis à régie »** : `art_dra IS NOT NULL` (lignes 86, 93, 123 via
  `art_dra <> ''`…) ; mêmes écarts que dans EditStkDepart et ObjFacB.
- **Période déclarée et exercice matières** : `$dteinf`/`FinMois` ici, calcul depuis `arrete` dans
  [Einvmat](../Einvmat.class/architecture.md)/[Ecomptamat](../Ecomptamat.class/architecture.md) et
  [Visucmat](../Visucmat.class/architecture.md).
- **Module commun des déclarations** (EINVMAT-004) : les structures `Volume`/`Stk`/`Declaration`
  et la construction de la collection y ont leur place, ce qui supprimerait la dépendance
  circulaire avec les reports.

### Réduction de portée

- Aucune méthode réductible : `_new` et les handlers doivent rester `Public`.
- `ddcl` : supprimable après EINVMAT-002/ECOMPTAMAT-002 (seuls utilisateurs).
- Les structures restent `Public` (types des paramètres des reports).

### Séparation traitement / GUI

- Les calculs d'`Edit` ne dépendent des contrôles que par `suspendu`, `calcregie`, `nbdec`,
  `math`/`inf`/`sup`, `Textmois`/`Textanne` : passer ces valeurs en paramètres
  (`CalculDeclaration(debut, regime, clt, calcregie, nbdec, arrondi) As Collection`) rend le cœur
  testable en gb.test.
- `ctrl`/`calcdate` : renvoyer la liste des messages (`String[]`) ; le handler l'affiche dans
  `Textcontrol` et pose les ballons.
- `Cloture(debut, regime, tabl)` : l'`UPDATE` et les insertions `M`, sans accès aux contrôles.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Créer `Fiches_regie`/`Fiches_ligregie` par migration et les déclarer dans `db_control.csv`.
- Table d'en-tête de clôture matières (`mois`, `régime`, date, utilisateur) au lieu de déduire
  l'état clôturé de la présence d'une ligne `M` datée du mois suivant.
- Index `(coderegie, type, dtmouv, cloture)` sur `Fiches_ligregie`.
- Colonne de régime sur la ligne de régie (dénormalisée) pour éviter l'`UPDATE` multi-tables.
