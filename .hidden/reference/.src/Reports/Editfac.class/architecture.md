# Editfac — Architecture

> Source : `.src/Reports/Editfac.class`

## Vue d'ensemble

`Editfac` est l'**état imprimé des documents de vente** (facture, avoir, BL, devis/estimation,
commande, proforma, duplicata, fiche atelier, factures fin de mois et d'abonnement). C'est un
report **gb.report** : la mise en page est décrite dans `Editfac.report` (même syntaxe qu'un
`.form` : `ReportHBox`/`ReportVBox`/`ReportLabel`/`ReportImage`), et la classe :

1. dans `_new(vfac As ObjFacB)`, adapte le report au document à imprimer : textes d'en-tête,
   adresse société (lecture de `Fiches_Societes`) ou logo pleine largeur, adresse client, titre
   du document, masquage de colonnes et de bandeaux (largeur ou hauteur `0mm`,
   `Children.Clear`), totaux, tableau de TVA (`edtva`), couleurs alternées des colonnes (`clr`) ;
2. fournit les **valeurs des lignes** à la demande du moteur de report par les handlers
   `<contrôle>_Data(Index)` des dix colonnes répétées (`ligne.DataCount = $vfac.ligne.Count`).

L'objet document `ObjFacB` (sous-classe d'[`ObjFac`](../../Gestion/Facturation/ObjFac.class/architecture.md))
porte tout le contenu déjà calculé : en-tête (`resent`), client (`rescli`, `adrfac`, `adrliv`),
lignes (`ligne`, collection de structures `Ledit` clés `"0001"`…), taxes (`tva`, `LTaxe`),
totaux, options d'affichage.

**Héritage et instanciation** : `Editfac` n'est jamais instancié directement. La seule classe
dérivée est [`EditfacB`](../../Gestion/option/EditfacB.class/architecture.md) (`Inherits Editfac`),
créée par `New EditfacB(Me, Me)` dans [`ObjFacB`](../../Gestion/option/ObjFacB.class/architecture.md)
(lignes 658, 726, 773, 800, 866) : Gambas passe le premier argument à `Editfac._new(vfac)` et le
second à `EditfacB._new(cal)`. Le report est ensuite imprimé par `edit.Print(imp)` vers un
`Printer` (fichier `~/tmp/Facture.pdf`, `~/Impressions/<type>.pdf` ou imprimante, voir
`ObjFac.CopieGedFac`, `ObjFacB.visualisation`/`mail`). `EditfacB` **surcharge** les handlers
`code_Data` et `intitule_Data` (sous les noms `code_data`, `intitule_Data`) pour ajouter les
lignes de déconsigne : les versions d'`Editfac` ne sont donc jamais exécutées aujourd'hui.

Nature : **mixte**. La classe ne calcule rien de métier (tout vient d'`ObjFacB`) mais fait deux
requêtes SQL et pose une question à l'utilisateur dans le constructeur.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$vfac` | var | Public |  | ObjFacB | 3 |
| `$c1` | var | Private |  | Integer | 4 |
| `$c2` | var | Private |  | Integer | 5 |
| `$frm` | var | Private |  | String | 6 |
| `lgint` | var | Public |  | Integer | 8 |
| `coef` | const | Private |  |  | 10 |
<!-- /AUTO:declarations -->

- `$vfac` : document à imprimer (`Public`, jamais lu hors du fichier).
- `$c1`, `$c2` : couleurs alternées des colonnes, permutées par `clr`.
- `$frm` : format des montants (`",0"` si `pxsdec`, sinon `",0.00"`).
- `lgint` : largeur utile de l'intitulé en mm, augmentée quand des colonnes sont masquées ;
  `Public` car modifiée par `EditfacB` (`Me.lgint += 80`).
- `coef` : nombre de caractères par mm (0,538) pour `longueur()`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 12-354 | Public | 112 | 315 | 0 | méthode spéciale |
| `edtva` | 356-411 | Private | 11 | 54 | 0 |  |
| `code_Data` | 415-425 | Public | 3 | 8 | 0 | handler GUI |
| `intitule_Data` | 427-441 | Public | 5 | 12 | 0 | handler GUI |
| `stk_Data` | 443-454 | Public | 2 | 9 | 0 | handler GUI |
| `qte_Data` | 456-467 | Public | 2 | 9 | 0 | handler GUI |
| `u_Data` | 469-480 | Public | 2 | 9 | 0 | handler GUI |
| `puht_Data` | 482-493 | Public | 3 | 9 | 0 | handler GUI |
| `bht_Data` | 495-506 | Public | 3 | 9 | 0 | handler GUI |
| `rem_Data` | 508-519 | Public | 2 | 9 | 0 | handler GUI |
| `nht_Data` | 521-532 | Public | 3 | 9 | 0 | handler GUI |
| `tx_Data` | 534-545 | Public | 2 | 9 | 0 | handler GUI |
| `clr` | 547-552 | Public | 3 | 4 | 1 |  |
| `longueur` | 554-561 | Public | 1 | 5 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### `_new(vfac As ObjFacB)` (CC 112, LOC 315)

[portée : nécessaire (constructeur)] [nature : mixte : SQL + `Message.Question` + mise en page].
Étapes, dans l'ordre :

1. **Format et lignes** : `$frm`, `resent.MoveFirst`, `expb`/`expn`, `ligne.DataCount`.
2. **Couleurs** des bandeaux `rcolon`, `enttva`, `ptot` (`vfac.couleur`).
3. **En-tête société** si `vfac.entete` : logo pleine largeur `/Soc<XX>/Logo2` si `adrlogo`,
   sinon `SELECT * FROM Fiches_Societes WHERE cd_sc=&1` (`Start.Societe` ; nom de table en dur,
   filtre présent) et remplissage de `rs`, `adr11`, `adr22`, `ville`, `cap` (hauteur 0 si vide),
   puis `rcs`, `siret` (libellé `vfac.libsire`), `ape`, `tvaintra`, `tel`, `portable`, `fax`,
   `site`, `mail`, `iban` (texte seul). Le label `libre` du report n'est jamais renseigné
   (contrairement à `Cdocuments.Entete`, qui imprime `Fiches_Societes.libre`). Sans en-tête :
   cadre vide de 80 mm (papier pré-imprimé).
4. **Logo** `/Soc<XX>/Logo` si `vfac.lgo` ; libellés de taxe (`libtaxe`).
5. **Adresse client** (`adrfac`, nom tronqué à 35), SIRET et n° de TVA client ;
   si `AffClient` et document commande/devis/proforma : **`Message.Question`** « Voulez-vous
   masquer les coordonnées du client ? » (bloquant, y compris dans les chaînes d'envoi par mail).
6. **Titre selon `vfac.choix`** (`Select Case`) :
   - facture, fin de mois, abonnement, **archive** : « Avoir n° » si `montht < 0`, sinon
     « Facture n° » ; coupon détachable si `coupon` ; « Impression du » sauf archive ;
     délais de règlement, réserves ;
   - BL : « Bon de livraison n° » ; si `blrecap`, `SELECT * FROM Fiches_Bl WHERE cdclibl=&1` et
     « Total BL a facturer : » = nombre de lignes (compte aussi les devis, commandes et BL déjà
     facturés de `Fiches_Bl` : EDITFAC-A03) ; « A livrer » ; adresse de livraison si renseignée ;
   - commande, proforma ; devis (« Estimation » si `tab = "M"`, masquage du code si `affref`,
     texte de bas de devis, signature `Icones/signature.jpg`) ;
   - **`Case ObjFac.archive`** (« Duplicata facture n° ») : **inatteignable**, `archive` est déjà
     capté par le premier `Case` depuis le commit `537f1ee2` (EDITFAC-A01) ;
   - atelier : « Fiche atelier N° », réception du matériel, tableau de TVA masqué, bandeau
     « signature client » créé par code (`New ReportLabel(rtotttc)`, `New ReportImage`).
7. Code client ; masquage « à livrer » ; **matériel** (`tab = "M"`) : marque, série,
   désignation, type (colonnes testées par `Fields.Exist`).
8. **Colonnes facultatives** : stock (`Stock`), conditionnement (`simpcond`), remise
   (`remart + remmo = 0`) ; chaque masquage élargit `lgint`.
9. **Totaux** HT/TVA/TTC ; masquage du sous-total et du tableau de TVA en franchise,
   auto-entrepreneur ou BL exonéré (`resent!exobl`) ; mentions légales `francaut`/`autoent`.
10. **Pied** : 5 lignes `tpied`, frais de gestion (`Utils.totobs`), récapitulatif articles/MO
    (« TTC »/« HT »), écotaxes DEE/DEA, libellés TTC des colonnes si `vfac.ttc`.
11. **TVA** : `ctva = New LTaxe` (objet aussitôt remplacé par la boucle, inutile), puis
    `edtva` pour chaque taux.
12. **BL non chiffré** (`Not blchif`, BL ou atelier) : masquage du chiffrage et des totaux.
13. **Bandeaux vides** `rl1`, `rdevis`, `piedfac`, `recap`, `rgest` réduits à 0 mm.
14. **Couleurs de colonnes** (`colon` : `couleur2` et `couleur2 + 10`, sinon blanc) via `clr`.

Variable locale `tot` déclarée et jamais utilisée. `vfac` et `$vfac` désignent le même objet,
employés indifféremment.

### `edtva(ctva, nb, i)` (CC 11) [portée : Private] [nature : GUI]

Remplit la ligne `i` (0 à 4) du tableau de TVA : code, taux (`0.00`), montant de TVA, base HT.
Les branches `Else` (masquer `ptva<i>` si `nb <= i`) sont **inatteignables** : `edtva` n'est
appelée que pour `i < nb`. Les lignes `ptva1`…`ptva4` inutilisées gardent donc leur hauteur fixe
de 3 mm, vides, et `ptva` reste affichée sans taxe (EDITFAC-A02). Au-delà de 5 taux, les
suivants sont ignorés sans message. Les cinq branches ne diffèrent que par le suffixe des
contrôles.

### Handlers des lignes (`*_Data`)

[portée : nécessaire (handlers du report, appelés par gb.report ; noms et portée intouchables)]
[nature : GUI]. Chacun calcule la clé `Format(Index + 1, "0000")`, sort si la ligne n'existe
pas, puis affecte `Me.<contrôle>.Data` :

| Handler | Valeur | Particularité |
|---|---|---|
| `code_Data` | `lg.code` ou `" "` | pas de remise à `" "` avant la sortie anticipée ; **surchargé par `EditfacB.code_data`** |
| `intitule_Data` | `lg.libel`, tronqué à `longueur()` sauf types `TD`, `C`, `R` | **surchargé par `EditfacB.intitule_Data`** |
| `stk_Data`, `qte_Data`, `u_Data`, `rem_Data`, `tx_Data` | `lg.stk`, `qte`, `unit`, `rem`, `tx` | |
| `puht_Data`, `bht_Data`, `nht_Data` | TTC (`putc`, `brtc`, `nettc`) si `$vfac.ttc`, sinon HT | |

Les dix handlers répètent les mêmes quatre lignes d'accès à la ligne.

### Utilitaires

- **`clr(obj)`** [portée : nécessaire, appelée par `EditfacB` (`Me.clr`, 11 appels)]
  [nature : GUI] : applique `$c1` en fond puis permute `$c1`/`$c2` ; un objet nul (contrôle non
  créé, cas `$bout` dans `EditfacB`) est ignoré par le `Try` sans permutation.
- **`longueur()`** [portée : nécessaire, appelée par `EditfacB.intitule_Data`] [nature : calcul] :
  `Fix(lgint * coef)`, nombre de caractères de l'intitulé.

## État global utilisé

- `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Logo"]` et `["/Soc<XX>/Logo2"]`.
- `Utils.db.Exec` (2 requêtes), `Utils.totobs` (frais de gestion), `LDate(Now)` (date
  d'impression : à figer en test).
- Constantes de l'énumération `ObjFac` (`facture`, `bl`, `devis`…), propriétés d'`ObjFacB`.
- Fichier `Icones/signature.jpg` (chargé sans `Try`).

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `_new` (CC 112) en sous-procédures privées appelées dans le même ordre :
  `EnteteSociete`, `AdresseClient`, `TitreDocument`, `Materiel`, `ColonnesFacultatives`,
  `Totaux`, `PiedDocument`, `TableauTva`, `BlNonChiffre`, `MasqueBandeauxVides`,
  `CouleursColonnes`. Un helper `Masque(panneau, Optional cellule)` remplace les séquences
  répétées `Children.Clear` / `Width = "0mm"` / `Border = ReportBorder[""]`.
- `edtva` : tableaux de contrôles `[Me.ctx, Me.ctx1, …]` indexés par `i` au lieu de cinq
  `Case` identiques.
- Handlers `*_Data` : fonction `LigneDoc(Index) As Variant` (renvoie `Null` si absente) ; les
  handlers gardent nom, portée et comportement (y compris l'absence de remise à `" "` de
  `code_Data`). Elle doit être `Public` pour servir aussi à `EditfacB` (un membre `Private`
  n'est pas visible d'une classe dérivée).
- Comptage des BL : `SELECT COUNT(*)` au lieu de `SELECT *` + `.Count` (SQL modifié, résultat
  identique) ; noms de table par `Cbase.Table("TabSoc")` et `Cbase.Table("TabBl")`.

### Commonalisation avec d'autres fichiers

- **En-tête société** : mêmes colonnes de `Fiches_Societes` que `Cdocuments.Entete`,
  `Creleve.Entete` et leurs appelants ; utiliser l'objet `LEnteteSoc` proposé par
  [CDOCUMENTS-006](../Cdocuments.class/rework.md) (lecture `WHERE cd_sc = &1`, libellés), en
  gardant les libellés propres au report (« site : », libellé SIRET `vfac.libsire`).
- **Accès aux lignes** avec [`EditfacB`](../../Gestion/option/EditfacB.class/architecture.md) :
  `LigneDoc` partagée, et `EditfacB.affvri` pour les déconsignes ; à faire dans le même commit
  que les reworks d'`EditfacB` qui touchent ses handlers.
- Le choix `vfac.choix → préfixe` existe aussi dans `ObjFac.nom()` (préfixes `F`, `B`, `C`,
  `P`, `D` du nom de fichier PDF) : une table commune `choix → (préfixe, titre)` éviterait que les
  deux `Select Case` divergent (cas `archive`, `atelier` absents de `nom()`).

### Réduction de portée

- `$vfac` : aucun usage hors du fichier (`EditfacB` utilise son propre `$cal`) → `Private`.
- `lgint`, `clr`, `longueur` restent `Public` (utilisés par `EditfacB`) ; les handlers `*_Data`
  restent `Public`.

### Séparation traitement / GUI

- La question « masquer les coordonnées du client » (`Message.Question` dans le constructeur)
  est isolée dans une fonction privée ; la déplacer vers `ObjFacB`/`OptFac` (décision prise avant
  la construction du report) changerait la signature de `_new` et des cinq créations d'`ObjFacB` :
  hors du périmètre d'un rework à comportement constant, à proposer avec `ObjFacB`.
- Les deux requêtes (`Fiches_Societes`, `Fiches_Bl`) passent dans des fonctions sans accès aux
  contrôles (`LitSociete`, `NbBlClient`) appelées par `_new`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Un indicateur « facturé » indexé (ou une vue des BL à facturer) dans `Fiches_Bl` rendrait le
  comptage « Total BL a facturer » exact et rapide (`type = 'B' AND numfac IS NULL`).
- Les libellés de pied (`tpied`) et de bas de devis gagneraient à être stockés par société en
  base plutôt que dans `Start.LocalSettings`.
