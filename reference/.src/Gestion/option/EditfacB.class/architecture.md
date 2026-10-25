# EditfacB — Architecture

> Source : `.src/Gestion/option/EditfacB.class`

## Vue d'ensemble

`EditfacB` est l'**état imprimé des documents de vente** : il hérite du report `Editfac`
(`.src/Reports/Editfac.class` + `Editfac.report`, lot Reports) et ne fait rien de plus que lui,
sauf en option boisson (`Utils.Option()` = `B` ou `T`) pour un document « boisson »
(`ObjFacB.borientation()`). Il modifie alors la mise en page **par code** :

- **BL non chiffré** (`Not blchif`) : deux colonnes « Colis » et « Pal » ;
- **facture / BL chiffré** : passage en **paysage**, en-tête DSA (document d'accompagnement des
  produits soumis à accises), colonnes consignation (palettes, colis, bouteilles, montant) et
  alcool (C.U, %, V.E, A.P), bandeau des frais (gestion, accise, régie, sécu, sous-total, poids,
  volumes), TVA réduite, cadre « retour des emballages », totaux (gestion/droits, HT, TVA, TTC,
  consigne, déconsigne, net facturé), cadres transport et signataire, et ajout des lignes de
  **déconsigne** à la fin du détail (`repligne.DataCount += nbdecons`).

Les données proviennent d'[`ObjFacB`](../ObjFacB.class/architecture.md) (`$cal`) : propriétés
`aimprimer`, `decons`, `nbdecons`, `consigne`, `deconsigne`, `droit`, `secu`, `ascise`,
`totvolume`, `totap`, `poid()`, et membres hérités d'`ObjFac` (`blchif`, `couleur`, `gestion`,
`ligne`, `montart`, `montmo`, `montht`, `monttva`, `montttc`, `rescli`).

Construction : `New EditfacB(Me, Me)` dans `ObjFacB` (5 appels) — le premier argument va à
`Editfac._new(vfac As ObjFacB)`, le second à `EditfacB._new(cal As ObjFacB)` (deux paramètres
obligatoires, appel correct).

Nature globale : **GUI** (mise en page d'état), sans SQL direct (seulement via
`cal.borientation()` et `cal.poid()`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$cal` | var | Private |  | ObjFacB | 5 |
| `$Palette` | var | Private |  | ReportLabel | 7 |
| `$coli` | var | Private |  | ReportLabel | 8 |
| `$bout` | var | Private |  | ReportLabel | 9 |
| `$montcons` | var | Private |  | ReportLabel | 10 |
| `$cu` | var | Private |  | ReportLabel | 11 |
| `$pourc` | var | Private |  | ReportLabel | 12 |
| `$ve` | var | Private |  | ReportLabel | 13 |
| `$ap` | var | Private |  | ReportLabel | 14 |
| `$gestion` | var | Private |  | ReportLabel | 15 |
| `$accise` | var | Private |  | ReportLabel | 16 |
| `$regie` | var | Private |  | ReportLabel | 17 |
| `$secu` | var | Private |  | ReportLabel | 18 |
| `$stotart` | var | Private |  | ReportLabel | 19 |
| `$poid` | var | Private |  | ReportLabel | 20 |
| `$totve` | var | Private |  | ReportLabel | 21 |
| `$totap` | var | Private |  | ReportLabel | 22 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 24-556 | Public | 10 | 496 | 0 | méthode spéciale |
| `modtva` | 558-565 | Private | 1 | 7 | 0 |  |
| `palette_data` | 569-577 | Public | 2 | 5 | 0 | handler GUI |
| `bout_data` | 579-587 | Public | 2 | 5 | 0 | handler GUI |
| `coli_data` | 589-596 | Public | 2 | 5 | 0 | handler GUI |
| `montcons_data` | 598-605 | Public | 2 | 5 | 0 | handler GUI |
| `cu_data` | 607-619 | Public | 3 | 10 | 0 | handler GUI |
| `pourc_data` | 621-633 | Public | 3 | 10 | 0 | handler GUI |
| `ve_data` | 635-646 | Public | 2 | 9 | 0 | handler GUI |
| `ap_data` | 648-659 | Public | 2 | 9 | 0 | handler GUI |
| `code_data` | 661-679 | Public | 2 | 16 | 0 | portée réductible ? |
| `intitule_Data` | 681-703 | Public | 5 | 20 | 0 | portée réductible ? |
| `affvri` | 705-720 | Private | 2 | 13 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(cal)`** [portée : nécessaire (constructeur)] [nature : GUI] (496 LOC, CC 10). Décrit
  ci-dessus. Appelle deux fois `Utils.Option()` et rappelle `cal.borientation()` (requêtes SQL
  déjà exécutées par `ObjFacB.calcul`). Utilise `Me.clr` (couleur alternée de colonne, `Try`
  interne) : dans la branche BL non chiffré, `Me.clr($bout)` est appelé sur un objet nul (sans
  erreur, mais l'alternance des couleurs diffère de la branche facture). Libellés fixes, dont le
  texte DSA (fautes d'origine conservées). `modtva` ajuste les largeurs des 5 lignes de TVA.
- **`modtva(ltva, ptva)`** [Private] [GUI]. Largeurs fixes des 4 étiquettes et du panneau.
- **`palette_data`, `coli_data`, `bout_data`, `montcons_data`** [handlers `Data` des colonnes
  créées par code : restent `Public`] [GUI]. Valeur `[0]`, `[1]`, `[2]`, `[3]` du tableau renvoyé
  par `affvri(Index)`, ou `" "`.
- **`cu_data`, `pourc_data`** [handlers] [GUI]. Valeurs `[4]`, `[5]` de `aimprimer[clé]` pour les
  lignes du document seulement (`Index < ligne.Count`).
- **`ve_data`, `ap_data`** [handlers] [GUI]. Valeurs `[6]`, `[7]` de `aimprimer[clé]` **sans**
  borne sur `Index` : pour une ligne de déconsigne, la clé `Format(Index + 1)` peut exister dans
  `aimprimer` (clés ajoutées depuis `Fiches_ligregie`) et afficher un volume (A01, à confirmer).
- **`code_data`, `intitule_Data`** [handlers `Data` des contrôles `code`/`intitule` de
  `Editfac.report` : **surcharges** de `Editfac.code_Data`/`intitule_Data`, restent `Public`]
  [GUI]. Ligne du document : code et libellé (tronqué à `longueur()` sauf `TD`, `C`, `R`) ;
  ligne de déconsigne : code et libellé de `decons[i]`. `deps.py` les signale à tort `unused`
  (la surcharge d'un handler hérité n'est pas reconnue).
- **`affvri(Index)`** [Private] [calcul]. `decons[Index - ligne.Count]` pour une ligne de
  déconsigne, sinon `aimprimer[clé]` (peut être `Null`).

## État global utilisé

`Utils.Option()`, `Utils.totobs` ; propriétés et membres de `ObjFacB`/`ObjFac` ; contrôles du
report parent (`rcolon`, `ligne`, `repligne`, `rfrais`, `gest`, `lgtva`, `ltt`, `lct`, `lmtv`,
`ltn`, `ltoh`, `ltot`, `ctx*`, `txtva*`, `mtva*`, `tnet*`, `ptva*`, `delais`, `rtotttc`,
`enttva`, `rbasfac`, `telcli`, `comdsa`, `rs`, `tel`, `expb`, `expn`, `ReportPanel1`), `lgint`,
`clr`, `longueur`.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : helpers `AjouteColonne(nom, largeur, police)` (8 colonnes de ligne), `AjouteEntete(texte,
  largeur)`, `AjouteFrais(libellé, valeur, largeurLib, largeurVal)` (6 paires du bandeau),
  `AjouteTotal(panneau, libellé, valeur)` (6 lignes de totaux) ; découper en
  `MiseEnPageBl()` et `MiseEnPageFacture()` ; réduction visée d'environ 500 à 200 LOC.
- Handlers `cu/pourc/ve/ap_data` : `ValeurImprimer(Index, colonne, avecBorne)` privé, bornes
  conservées à l'identique.
- Un seul appel à `Utils.Option()` (variable locale).

### Commonalisation avec d'autres fichiers

- Les handlers de colonnes et la logique « lignes du document + lignes de déconsigne » dépendent
  de `Editfac` (lot Reports, non documenté à ce jour) : à reprendre avec lui.
- L'orientation boisson est recalculée ici : utiliser la valeur déjà calculée par
  `ObjFacB.calcul` (OBJFACB-011).

### Réduction de portée

Aucune : tous les membres publics sont des handlers (`*_data`, surcharges `code_data`,
`intitule_Data`) ou le constructeur.

### Séparation traitement / GUI

Classe d'état : sans objet, hormis `affvri` (déjà sans contrôle).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune propre à l'état ; voir ObjFacB.
