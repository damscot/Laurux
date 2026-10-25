# ObjFacB — Architecture

> Source : `.src/Gestion/option/ObjFacB.class`

## Vue d'ensemble

`ObjFacB` est l'**objet d'édition des documents de vente** effectivement instancié par Laurux :
il hérite d'[`ObjFac`](../../Facturation/ObjFac.class/architecture.md) (`Inherits ObjFac`), qui
charge le document et calcule les totaux, et lui ajoute :

- l'**option boisson** (codes `Utils.Option()` `B` ou `T`) : consignes (`Fiches_ligcons`,
  `Fiches_consigne`), déconsignes, droits de régie et sécurité sociale (`Fiches_ligregie`,
  `Fiches_regie`, via `Calculdroit`), comptabilité matière et vignettes (`comptmat`,
  `nvignette`) ; l'édition passe alors en paysage (`borientation`) avec les colonnes
  supplémentaires d'[`EditfacB`](../EditfacB.class/architecture.md) ;
- les **éditions** : facture (`editef`), BL/devis/commande/proforma (`editebl`), factures de fin
  de mois (`editefm`), visualisation (`visualisation`), envoi par courriel (`mail`) ;
- l'**archivage** d'une facture (`transblfac`) : copie BL → `Fiches_HistoFac[M]` /
  `Fiches_HistoLigfac[M]`, matériels, sorties de dépôt, consignes, puis suppression du BL ;
- le **contrôle des dates** de clôture des droits (`verifdat`, `datebl`).

Les codes d'option (`$option`, lu une fois dans `_new` par `Utils.Option()`) : `N` aucune
option, `B` boisson, `P` produits pétroliers (carburant), `T` les deux. Les branches boisson ne
s'exécutent que pour `B`/`T` ; `transblfac` recopie les colonnes TIPP pour `P`/`T`.

**Relation avec `ObjFac`** (cohérente avec la documentation d'`ObjFac`) :

| Membre | Mécanisme | Remarque |
|---|---|---|
| `_new()` | constructeur sans paramètre | les arguments de `New ObjFacB(num, choix[, dte])` sont consommés par `ObjFac._new(num, choi, dte)` |
| `calcul(nom)` | **redéfinition** | appelle `Super.calcul(nom)` puis ajoute consignes/droits ; `ObjFac.calcul` doit rester `Public` |
| `verifdat(dtef, dtech)` | **masquage `Private`** de la méthode `Public` du parent | appelle `Super.verifdat(dtef, dtech)` ; aucun appel externe de `verifdat` sur un `ObjFacB` (vérifié par `grep`) ; `ObjFac.verifdat` doit rester `Public` |
| `ecriture`, `ecriturecompt`, `testchem`, `CopieGedFac` | hérités, appelés par `Me.` | 23 appels `Me.ecriture` |
| `resent`, `reslig`, `ligne`, `tva`, `lignetva`, `ecrit`, `montht`, `monttva`, `montttc`, `montart`, `montmo`, `remart`, `remmo`, `gestion`, `rescli`, `adrfac`, `edit`, `imp`, `choix`, `dtmouv`, `gmateriel`, `tab`, `condvent`, `joinfac`, `pdf`, `saisreg`, `AffClient`, `numcli`, `numbl`, `numfac`, `dtedoc`, `dteech`, `nbexplemplaire` | membres hérités lus ou écrits via `Me.` | toute réduction de portée d'`ObjFac` doit être vérifiée contre cette liste |
| Énumération `ObjFac.bl`, `facture`, `archive`, `finmois`, `magasin`, `commande`, `devis`, `proforma` | accès par le nom de la classe parente | |

`deps.py` attribue les membres hérités accédés par `Me.` à `ObjFac` (bloc « Utilise ») ; il ne
signale aucune portée réductible ici.

Nature globale : **mixte**. `calcul`, `borientation`, `comptmat`, `poid`, `transblfac` sont du
traitement (SQL) ; les éditions (`editef*`, `visualisation`, `mail`) mêlent SQL, impression,
messages et fenêtres (`ProgBar`, `SaiReg`, `ComMail`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$cimp` | var | Private |  | Collection | 9 |
| `$vdecons` | var | Private |  | Variant[] | 10 |
| `$stotcons` | var | Private |  | String | 11 |
| `$stotdecons` | var | Private |  | String | 12 |
| `$stotdr` | var | Private |  | String | 13 |
| `$stotss` | var | Private |  | String | 14 |
| `$stotasc` | var | Private |  | String | 15 |
| `$ftotht` | var | Private |  | Float | 16 |
| `$inb` | var | Private |  | Integer | 17 |
| `$num` | var | Private |  | String | 18 |
| `$ftotv` | var | Private |  | Float | 19 |
| `$ftotap` | var | Private |  | Float | 20 |
| `$cdrt` | var | Private |  | New Calculdroit[] | 21 |
| `$schoix` | var | Private |  | String | 22 |
| `$slstnum` | var | Private |  | String[] | 23 |
| `$clot` | var | Private |  | Date | 24 |
| `$borientation` | var | Private |  | Boolean | 25 |
| `$option` | var | Private |  | String | 26 |
| `$win` | var | Private |  | Window | 27 |
| `$sreg` | var | Private |  | SaiReg | 28 |
| `aimprimer` | property | Public |  | Collection | 30 |
| `consigne` | property | Public |  | String | 31 |
| `deconsigne` | property | Public |  | String | 32 |
| `droit` | property | Public |  | String | 33 |
| `secu` | property | Public |  | String | 34 |
| `ascise` | property | Public |  | String | 35 |
| `totht` | property | Public |  | Float | 36 |
| `nbdecons` | property | Public |  | Integer | 37 |
| `decons` | property | Public |  | Variant | 38 |
| `totvolume` | property | Public |  | String | 39 |
| `totap` | property | Public |  | String | 40 |
| `clotmat` | property | Public |  | Date | 41 |
<!-- /AUTO:declarations -->

### Variables privées : usage réel (vérifié par `grep`)

| Variable | Usage |
|---|---|
| `$cimp` (Collection de `String[8]`) | détail par ligne imprimée, clé = clé de `ligne` (`0001`…) : `[0]` nb palettes, `[1]` nb colis, `[2]` nb bouteilles, `[3]` montant consigne, `[4]` volume unitaire (`art_volm`), `[5]` degré, `[6]` volume effectif, `[7]` volume d'alcool pur ; exposé par `aimprimer` |
| `$vdecons` (Variant[] de `String[7]`) | déconsignes regroupées : `[0..2]` nb par type P/C/B, `[3]` montant, `[4]` code, `[5]` libellé ; exposé par `decons` |
| `$stotcons`, `$stotdecons`, `$stotdr`, `$stotss`, `$stotasc` | cumuls **en chaîne** (consigne, déconsigne, droits, sécu, accises) ; voir A11 |
| `$ftotv`, `$ftotap` | volumes cumulés (`totvolume`, `totap`) |
| `$inb` | nombre de déconsignes (`nbdecons`) |
| `$schoix` | `"B"` (bon) ou `"F"` (facture archivée) : type des lignes `Fiches_ligcons` à lire |
| `$borientation` | résultat de `borientation()` mémorisé par `calcul` ; lu par `comptmat` et `verifdat` |
| `$option` | code d'option (`N`/`B`/`P`/`T`) |
| `$win`, `$sreg` | fenêtre et écran `SaiReg` incrusté par `editef` (`As "win"`) |
| `$ftotht` | cumulé mais lu seulement par la propriété `totht`, **jamais lue** hors du fichier → code mort |
| `$cdrt` | réinitialisé, les `Add` sont commentés → code mort |
| `$num`, `$slstnum`, `$clot` | déclarés (et `$slstnum` réinitialisé) mais jamais lus → code mort |

Propriétés : `aimprimer`, `consigne`, `deconsigne`, `droit`, `secu`, `ascise`, `nbdecons`,
`decons`, `totvolume`, `totap` sont lues par `EditfacB` ; `totht` et `clotmat` (lecteur vide,
renvoie une date nulle) ne sont lues nulle part → code mort.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 44-48 | Public | 1 | 3 | 0 | méthode spéciale |
| `_call` | 50-59 | Public | 2 | 7 | 0 | méthode spéciale |
| `calcul` | 61-280 | Public | 56 | 205 | 3 |  |
| `cassise` | 282-317 | Private | 4 | 31 | 0 |  |
| `cdroits` | 319-386 | Private | 6 | 58 | 0 |  |
| `borientation` | 388-412 | Public | 12 | 19 | 1 |  |
| `comptmat` | 414-509 | Public | 17 | 87 | 1 |  |
| `nvignette` | 511-523 | Private | 1 | 11 | 0 |  |
| `poid` | 525-539 | Public | 5 | 11 | 1 |  |
| `aimprimer_Read` | 541-545 | Private | 1 | 3 | 0 |  |
| `consigne_Read` | 547-551 | Private | 1 | 3 | 0 |  |
| `deconsigne_Read` | 553-557 | Private | 1 | 3 | 0 |  |
| `droit_Read` | 559-563 | Private | 1 | 3 | 0 |  |
| `secu_Read` | 565-569 | Private | 1 | 3 | 0 |  |
| `ascise_Read` | 571-575 | Private | 1 | 3 | 0 |  |
| `totht_Read` | 577-581 | Private | 1 | 3 | 0 |  |
| `nbdecons_Read` | 583-588 | Private | 2 | 4 | 0 |  |
| `decons_Read` | 591-595 | Private | 1 | 3 | 0 |  |
| `totvolume_Read` | 597-601 | Private | 1 | 3 | 0 |  |
| `totap_Read` | 603-607 | Private | 1 | 3 | 0 |  |
| `clotmat_Read` | 609-613 | Private | 1 | 2 | 0 |  |
| `editefm` | 616-696 | Public | 19 | 75 | 1 |  |
| `editef` | 698-747 | Public | 10 | 45 | 2 |  |
| `win_close` | 749-754 | Public | 1 | 4 | 0 | handler GUI |
| `editebl` | 756-784 | Public | 10 | 25 | 1 |  |
| `visualisation` | 786-807 | Public | 4 | 18 | 2 |  |
| `mail` | 809-893 | Public | 24 | 79 | 1 |  |
| `verifdat` | 896-927 | Private | 12 | 26 | 0 |  |
| `datebl` | 929-946 | Private | 4 | 15 | 0 |  |
| `transblfac` | 948-1100 | Public | 25 | 142 | 2 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new()`** [portée : nécessaire (constructeur)] [nature : calcul]. Lit `$option =
  Utils.Option()`. Les arguments passés à `New` sont consommés par `ObjFac._new`.
- **`_call(num, choix, dte)`** [portée : réductible — **code mort**] [nature : calcul]. Fabrique
  `New ObjFacB(num, choix)`, fixe `dtedoc`, puis `calcul()`. **Aucun appel** : tous les
  appelants écrivent `New ObjFacB(…)` (le seul `ObjFacB(…)` est commenté, `ClotureF.class:135`).
  `deps.py` compte à tort les `New ObjFacB(…)` comme des appels de `_call` (6 appelants
  annoncés). En outre `Create Static` est commenté (l. 6), l'auto-instance n'est donc pas garantie.

### Calcul du document

- **`calcul(Optional nom)`** [portée : nécessaire (redéfinition ; `Facture:2553/9804`,
  `ClotureF:138`, `Caleditcmat:108`, et en interne)] [nature : calcul] (CC 56, maximum du fichier).
  1. `Super.calcul(nom)` (totaux `ObjFac`), puis `$borientation = borientation()` ; **sort** si
     ce n'est pas une facture boisson (le reste n'est exécuté qu'en option `B`/`T`).
  2. Réinitialise les cumuls ; `$schoix = "F"` si `choix = archive`, sinon `"B"`.
  3. **Consignes par ligne** (lignes article `A` avec code) : `SELECT … FROM Fiches_ligcons,
     Fiches_consigne WHERE num = <num_ligbl> AND type = $schoix AND numlig LIKE '%<numlig>'` ;
     remplit `vri[0..3]`, cumule `$stotcons` (chaîne formatée `,0.00`) et `$ftotht`.
  4. **Droits** : si des lignes `Fiches_ligregie` existent déjà (facture éditée : jointure
     `Fiches_Bl.numfac = num` en mode `B`, `num = numfac` en mode `F`), reprend `montdr`,
     `montss`, taux, volumes ; sinon recalcule par `New Calculdroit(art_dra, art_volm, art_deg,
     qte, art_fam)` pour chaque ligne qui a un code (`art_dra IS NOT NULL`). Cumule `$stotdr`
     (régie `A`/`V`), `$stotasc` (accises `B` si `drsurfac`), `$stotss`, volumes ; appelle
     `cassise` (droits remontés en vente si magasin acquitté) et `cdroits` (écritures si
     suspendu). ⚠️ Conditions différentes entre les deux branches (A10) ; dans la branche « non
     éditée », la condition `lg.Index = -1 Or Not lg.code And lg.type <> "A"` laisse passer les
     lignes `O` (composants) et `M` qui ont un code.
  5. **Déconsignes** des BL de `resent` : condition `num = … OR …` construite par
     `Utils.db.Subst`, `SUM(nb)`, `SUM(montant)` groupés par `codecons` (`numlig = 'D'`).
  6. Écritures consigne : `Fiches_Parametres.conscli` × `Fiches_Comptes` ; `Message.Error` si le
     compte n'est pas paramétré (seul couplage GUI de `calcul`) ; contrepartie client.
  7. **Recalcul de la TVA** : `tottva = tottc - totht` pour chaque entrée de `tva`, réécrit dans
     `tva[lg.num]` (⚠️ la clé utilisée par `cassise`/`cdroits` n'est pas `num`, voir A03), écritures
     TVA, puis `montht = montart + montmo + accises + droits + sécu + gestion`, `montttc =
     montht + consignes + monttva`, écriture client.
  Partie extractible : tout (seul `Message.Error` au point 6) ; découpage proposé plus bas.
- **`cassise(drt)`** [Private] [calcul]. Magasin acquitté avec droits séparés : écriture du droit
  sur le compte de vente de la famille (`Fiches_Fam × Fiches_Comptes`, sans test `Available`),
  TVA du droit (compte du code TVA de la famille), cumul dans `tva[drt.codetva]`, contrepartie
  client. Si `codetva` est absent de `tva` : **modifie l'objet `Me.lignetva` existant** (structure
  partagée, sans `New Ltva`) avec `num = drt.cptreg`, puis `tva.Add` (A03).
- **`cdroits(drt)`** [Private] [calcul]. Magasin en droits suspendus : écriture du droit sur
  `drt.cptreg`, de la sécurité sociale sur `Fiches_Parametres.css` (TVA `tvass`), TVA et
  contrepartie client. Même défaut de structure partagée ; en outre, si le code TVA est absent et
  que droit **et** sécu sont non nuls, deux `tva.Add` avec la même clé lèvent une erreur, et la
  ligne sécu reçoit les montants du droit et `taux = tvass` (un code, pas un taux) (A03).
- **`borientation()`** [portée : nécessaire (`EditfacB:32`)] [nature : calcul]. Faux si option
  `N`/`P`. Vrai si une ligne de `ligne` (index ≥ 0) porte un article avec `art_dra`, `art_consb`,
  `art_consc` ou `art_consp`, ou si un BL de `resent` a une déconsigne (`Fiches_ligcons`,
  `numlig = 'D'`). `Me.reslig.MoveTo` y est inutile. Critère différent de `Utils.orientation`
  (voir commonalisation).
- **`poid()`** [portée : nécessaire (`EditfacB:258`)] [nature : calcul]. `" "` pour `magasin`/
  `finmois` ; sinon `SUM(qte × art_poids)` sur `Fiches_Ligbl` (ou `Fiches_HistoLigfac` pour
  `archive`), **sans suffixe `tab`** (A13). Renvoie `"0,00"` si nul.

### Comptabilité matière

- **`comptmat(Optional numfac, magasin)`** [portée : nécessaire (`Moulinage:2870`, et
  `editef`/`editefm`)] [nature : calcul] (CC 17). `Utils.db.Begin`, puis :
  - **magasin** (facture de caisse, `Moulinage`) : vignette si un article de
    `Fiches_HistoLigfac` est en régie suspendue (`nvignette`), puis une ligne
    `Fiches_ligregie` de type `S` par ligne d'alcool (`numlig = Space(6) & numlig_ligfac`),
    `Commit` et sortie ;
  - sinon : si `$borientation` est faux, **`Return` sans `Commit`** (A02) ; vignette si un
    article est suspendu ; une ligne `Fiches_ligregie` (`S`, `num = numfac`, `numlig =
    num_ligbl & clé`) par ligne de `ligne` dont l'article a `art_dra` (y compris lignes `O`) ;
    vignette écrite si `Val($stotdr) <> 0` (et non si un numéro a été attribué, A12) ; `Commit`.
  Le cas magasin sans ligne d'alcool retombe aussi sur le `Return` sans `Commit`
  (`$borientation` est faux car `Moulinage` n'appelle pas `calcul`).
- **`nvignette()`** [Private] [calcul]. `LOCK TABLES Fiches_Parametres WRITE` (validation
  implicite de la transaction en cours sous MySQL ; neutralisé sous SQLite), incrémente
  `nvign` (25 chiffres), `UNLOCK TABLES`.

### Propriétés (lecture)

`aimprimer` (`$cimp`), `decons` (`$vdecons`), `nbdecons` (`$inb`, -1 → 0), `consigne`,
`deconsigne`, `droit`, `secu`, `ascise` (`Format(Utils.arrondi(x, 2), "0.00")`), `totvolume`,
`totap` (`Format(x, "0.00")`) [portée : nécessaire, lues par `EditfacB`] [calcul].
`totht` et `clotmat` [code mort] ; `clotmat_Read` est vide.

### Éditions

- **`editefm(Optional courriel, tri)`** [portée : nécessaire (`OptFac:501`, `mail`)]
  [nature : mixte] (CC 19). `dtmouv = False`, `testchem`, `verifdat` (⚠️ avant tout `calcul` :
  `$borientation` est encore faux, le contrôle des droits n'est jamais fait, A06) ; lit la table
  de travail `Facturefm` (+ `tri` = `ORDER BY …` fourni par `OptFac`) sans test `Available` ;
  `ProgBar` ; pour chaque client : `numcli`, `calcul(nom)`, refus si un BL vient d'un ticket non
  mouliné (`Message.Error`, `Return True` sans fermer la barre ni libérer les verrous), verrous
  `DocActif.get_lock("Facturation", numbl)` en **boucle active** (A05), `ecriturecompt`,
  `comptmat`, `EditfacB`, puis courriel (`Cbase.Table("TabTmail")` ou `Variables.sTexte`,
  `CopieGedFac`, `EnvMail.Envoi`) ou impression (`Impression.Facture` × `nbexplemplaire`, `pdf` si
  `joinfac`, `condvent`), puis `transblfac`. À la fin, ne libère que les verrous des BL du
  **dernier** client (A05).
- **`editef()`** [portée : nécessaire (`OptFac:505`, `Moulinage:1314`)] [nature : mixte].
  `Application.Busy += 1` (non décrémenté si `testchem` échoue, A04), `calcul` ; si non facturé
  (`imp = 0`) : `verifdat`, `ecriturecompt` (message d'erreur si échec), `comptmat` ; sinon
  reprend numéro et dates de la facture. `EditfacB`, `CopieGedFac`, impressions (`pdf` toujours,
  `condvent` si `joinfac`). Si `saisreg` : `SaiReg` incrusté dans une fenêtre modale sans bordure
  (`As "win"`). Ne fait **pas** l'archivage (`transblfac` est appelé par `Facture`/`ClotureF`).
- **`win_close()`** [handler de l'événement `Close` de `SaiReg` (groupe `"win"`) : reste
  `Public`] [GUI]. Appelle `$sreg.Form_Close()` puis ferme la fenêtre. `SaiReg.Form_Close` est
  déjà exécuté par Gambas pour son propre `Close` : la question « Voulez vous valider la
  saisie ? » peut être posée deux fois (A15, à confirmer).
- **`editebl()`** [portée : nécessaire (`OptFac:508`)] [nature : mixte]. `calcul` ; pour un BL non
  facturé : `testchem` et, si `dtmouv`, `verifdat` (sorties sans `Busy -= 1`, A04). Passe
  temporairement `choix = facture` si le BL est facturé, édite, imprime (`condvent` si `joinfac`,
  pas de `pdf`), restaure `choix`.
- **`visualisation()`** [portée : nécessaire (`OptFac:527`, `Stockmvt:674/677`)] [mixte].
  `calcul`, ajuste `choix` (facture non imprimée → `bl`, imprimée → `facture`), imprime dans
  `~/tmp/Facture.pdf` et ouvre `Visualiseur.Prog`.
- **`mail(courriel)`** [portée : nécessaire (`OptFac:546`)] [mixte] (CC 24).
  - `finmois` : liste des clients de `Facturefm` sans courriel (ou inexistants) → `Message.Info`
    et sortie ; sinon `ComMail("F")` (texte prédéfini au choix) puis `editefm(True)`.
  - autres : `Message.Error` si `courriel` est vide **sans sortir** (A07) ; extrait l'adresse
    après `|` ; `ComMail` ; `calcul` ; édition PDF ; objet selon `choix` ; texte
    (`Cbase.Table("TabTmail")` ou `Variables.sTexte`) ; `EnvMail.Envoi2`.
  - En fin de procédure `choix = ch` : en fin de mois `ch` n'a jamais été affecté, `choix`
    devient `0` (`sans`) (A07).

### Dates

- **`verifdat(Optional dtef, dtech)`** [Private (masque `ObjFac.verifdat`)] [mixte]. Si facture
  boisson : `VerifDate.ClotFac` si `dtmouv`, sinon `datebl` sur tous les BL de la table de travail
  `Bl` (fin de mois, sans filtre client) ou sur `numbl` (facture, BL). Puis `Super.verifdat`.
- **`datebl(num)`** [Private] [mixte]. Pour chaque ligne de `Fiches_Ligbl` (sans suffixe `tab`),
  `VerifDate.ClotDroi(code)` ; `Message.Info` et `True` si la période des droits est close.

### Archivage

- **`transblfac()`** [portée : nécessaire (`Facture:9805`, `ClotureF:139`)] [nature : calcul]
  (CC 25). Refuse (`Message.Warning`) si la facture existe dans `Fiches_HistoFac` ou
  `Fiches_HistoFacM`. Dans une transaction :
  - une ligne `Fiches_HistoLigfac<tab>` par entrée de `ligne` : copie complète pour les lignes
    indexées (TIPP/agri/adresse si option `P`/`T`), commentaire pour les autres ; ⚠️ la ligne `TD`
    (total en lettres) crée un enregistrement **sans aucun champ** (A08) ; le contenu archivé
    dépend des options d'édition (`ligne2`, `nblfac`, composants affichés) (A08) ;
  - matériels (`gmateriel`) : `Edit("Fiches_Materiels", "WHERE mat_bl = <BL> AND mat_code =
    <code de ligne>")` puis `mat_bl = numfac` sur **le premier** enregistrement seulement (A09) ;
  - consignes (`B`/`T`) : lignes `Fiches_ligcons` du BL → `num = numfac`, `type = 'F'`,
    `numlig` renuméroté ; `Fiches_ligregie` type `'C'` renuméroté (aucun écrivain de ce type
    n'existe dans le code, mise à jour probablement sans effet, à confirmer) ; déconsignes du BL
    → facture ;
  - entête `Fiches_HistoFac<tab>` (sans `cdep`) ;
  - `tab = "M"` : `Fiches_HisentMat` avec `numfac = numbl` (A09) ;
  - **sorties de dépôt** si `cdep` est renseigné : lit `Me.reslig!typel` et `Me.reslig!dtefac`,
    colonnes **inexistantes** de `Fiches_Ligbl` → erreur d'exécution, transaction non validée
    (A01).
  Après `Commit`, **hors transaction** : suppression de `Fiches_AdrlivBL`, `Fiches_Bl<tab>`,
  `Fiches_Ligbl<tab>` (A14).

## Tables construites par concaténation (non vues par `deps.py`)

| Expression | Tables réelles | Lignes |
|---|---|---|
| `"Fiches_HistoLigfac" & Me.tab` | `Fiches_HistoLigfac`, `Fiches_HistoLigfacM` | 966 |
| `"Fiches_HistoFac" & Me.tab` | `Fiches_HistoFac`, `Fiches_HistoFacM` (la seconde est aussi citée en littéral l. 957) | 1025 |
| `"Fiches_Bl" & Me.tab` | `Fiches_Bl`, `Fiches_BlM` | 1096 |
| `"Fiches_Ligbl" & Me.tab` | `Fiches_Ligbl`, `Fiches_LigblM` | 1097 |
| `"Facturefm" & tri` | table de travail `Facturefm` (+ clause `ORDER BY`) | 626 ; littéral l. 822 |
| `Bl` | table de travail `Bl` (fin de mois) | 910 |
| `Cbase.Table("TabTmail")` | `Fiches_TxtMail` (vue par `deps.py`) | 663, 877 |

## État global utilisé

- `Utils.Option()` (préférences `/Soc<XX>/bois` et `/pp`), `Utils.db` (`Exec`, `Subst`, `Edit`,
  `Create9`, `Begin`, `Commit`), `Utils.arrondi`, `Utils.totobs`, `Cbase.Table` (2 usages).
- `Variables.sTexte` (texte de courriel choisi dans `ComMail`).
- `Application.Busy`, `Windows[]` (parent de la `ProgBar`), `User.Home` (`~/tmp/Facture.pdf`).
- Classes : `Calculdroit`, `VerifDate`, `DocActif`, `EditfacB`, `Impression`, `EnvMail`,
  `ComMail`, `SaiReg`, `VarEcr`, `ProgBar`, `Visualiseur`, `LDate`.
- Tables : voir le bloc de dépendances et le tableau des concaténations ci-dessus ;
  `Fiches_ligcons`, `Fiches_consigne`, `Fiches_ligregie`, `Fiches_regie` et les colonnes
  d'option (`art_dra`, `art_cons*`, `conscli`, `css`, `tvass`, `nvign`, `tipp_ligbl`,
  `numagri_ligbl`, `numadr_ligbl`) sont créées à l'exécution par
  [`modfichier`](../modfichier.module/architecture.md) et absentes de `db_control.csv`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **`calcul` (CC 56)** : découper, sans changer l'ordre des requêtes, en `ConsignesLignes()`,
  `DroitsEdites(reslig1)`, `DroitsNonEdites()`, `Deconsignes()`, `EcrituresConsignes()`,
  `RecalculTva()` (CC ≤ 12 visé).
- `cassise`/`cdroits` : un helper privé `CumulTvaDroit(codetva, num, taux, ht, tva)` et
  `EcritureDroit(cpt, montant, cptTva, montantTva, intitule)` ; comportement **identique**
  (y compris la mutation de `Me.lignetva`, A03) tant que l'anomalie n'est pas validée.
- Propriétés de format : un helper `Fmt2(v)` pour `Format(Utils.arrondi(v, 2), "0.00")` (5 copies).
- `editefm` : deux boucles identiques de libération des verrous → `LibereVerrous()` ; boucle de
  pose → `VerrouilleBl()`.
- Impressions dupliquées dans `editefm`/`editef`/`editebl` → `ImprimeExemplaires(avecPdf,
  pdfSiJoint)` (les trois variantes diffèrent : `pdf` toujours dans `editef`, seulement si
  `joinfac` dans `editefm`, jamais dans `editebl` ; à paramétrer à l'identique).
- Texte du courriel dupliqué (`editefm`, `mail`) → `TexteCourriel(num)`.
- `Cbase.Table` pour les tables qui ont une clé (`TabArt`, `TabParam`, `TabComptes`, `TabFam`,
  `TabTvav`, `TabBl`/`TabBlM`, `TabLigbl`/`TabLigblM`, `TabHisFac`/`TabHisFacm`,
  `TabHisLigFac`/`TabHisLigFacm`, `TabCli`, `TabMat`, `TabSdepots`, `TabHisEntm`) ; ⚠️ les clés
  `TabHisFacm`/`TabHisLigFacm` ont un `m` minuscule : `"TabHisFac" & Me.tab` ne fonctionne pas
  tel quel (table de correspondance nécessaire). Les tables de l'option (`Fiches_regie`,
  `Fiches_consigne`, `Fiches_ligcons`, `Fiches_ligregie`) n'ont pas de clé `Cbase`.

### Commonalisation avec d'autres fichiers

- **Texte unique** : la lecture de `Fiches_TxtMail` (l. 663 et 877, sans `ORDER BY`) relève de
  `LitTexteUnique(sTable, sChamp)` proposée par [`Tleg`](../../Tables/Tleg.class/architecture.md)
  (TLEG-003), avec `ObjFac:215/221` et `Facturergbl:580`.
- **Facture boisson** : `borientation` (articles marqués ou déconsigne) et
  [`Utils.orientation`](../../../Utils/Utils.module/architecture.md) (lignes de consigne ou de
  régie présentes) répondent à la même question avec deux critères différents ; utilisés par
  `Facturefm`, `Archives` (`Utils.orientation`) et `EditfacB` (`borientation`). Unifier demande
  une décision (comportements différents) : non proposé en rework.
- **Alias BL ↔ historique** : les colonnes copiées par `transblfac` sont la contrepartie des
  alias `entetef`/`detailf` d'[`ObjFac`](../../Facturation/ObjFac.class/architecture.md) : un
  module de correspondance unique éviterait les divergences (`cdep`, `numserie`…).
- **Matériels** : le rapprochement BL ↔ matériel diffère de `Facture` (voir A09 et
  [`Materiel`](../../Tables/Materiel.class/architecture.md), MATERIEL-A11).
- **Verrous** : la boucle `Repeat … Until DocActif.get_lock` est propre à ce fichier ; une
  méthode `DocActif.AttendLock` (voir [`DocActif`](../../../Communs/DocActif.class/architecture.md))
  la centraliserait.

### Réduction de portée

Aucune : toutes les méthodes `Public` ont un appelant externe (vérifié par `grep` sur les
variables typées `ObjFacB` : `vfac`, `$vfac`, `fac`, `$fac`, `opt`, `cal`, `$cal`, `obj`, `ccd`),
sauf `_call` et les propriétés `totht`/`clotmat`, qui relèvent du code mort. `win_close` est un
handler et reste `Public`.

### Séparation traitement / GUI

- `calcul` : remonter le `Message.Error` du paramétrage des consignes (fonction de calcul qui
  renvoie un code, message dans l'appelant `calcul`).
- `editefm` : `BlEnAttenteMoulinage() As String` (contrôle des `numtick` sans message).
- `mail` : `ClientsSansCourriel() As String` (liste) et `ObjetCourriel(choix, imp) As String`
  (objet du message) sans GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Intégrer les tables et colonnes de l'option boisson/carburant au schéma de référence
  (`db_control.csv`, `Laurux01.sql/.sqlite`) via une migration `LauruxMaj` plutôt que
  `modfichier`.
- `Fiches_ligcons.numlig` concatène numéro de BL et numéro de ligne (`num & numlig`), d'où les
  `LIKE '%…'` : deux colonnes séparées permettraient des jointures exactes.
- `Fiches_HisentMat.numfac` reçoit un numéro de BL ; `Fiches_HistoFac` ne reçoit pas `cdep`.
- Montants stockés en `char` (`qte_ligbl`, `qte_ligfac`) : `REPLACE(qte, ',', '.')` dans `poid`.
