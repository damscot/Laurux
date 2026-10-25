# artopt — Architecture

> Source : `.src/Gestion/option/artopt.class` (+ `artopt.form`)

## Vue d'ensemble

`artopt` est l'**onglet « Options » de la fiche article** pour les options métier : formulaire
incrusté dans un `TabStrip` par [`Articles`](../../Tables/Articles.class/architecture.md)
(`New Artopt(TabStrip1, $soption, Frais, PaHt, Prvt, TxTva, code, TabStrip1) As "$opt"`) et par
`commande1` (`New Artopt(TabStrip1, $opt, Null, Null, Null, Null, Null, TabStrip1) As "opt"`).
Les 7 paramètres obligatoires sont suivis du `Parent` (`TabStrip1`) : appels corrects.

- `Panel1` (boisson, `B`/`T`) : frais de transport (`Texttrs`, `Texttrsa`, `Texttrsr`), sucre
  (`Texttsu`), remise (`Textremv`), régie (`Textcdr` + liste `Listregie`), volume, degré, droits
  et sécu calculés (`Calculdroit`), consignes palette/colis/bouteilles (`Textcp`, `Textcc`,
  `Textcb` + liste `Listcons`), prix de revient ;
- `Panel2` (carburant, `P`/`T`) : transport, éco-contribution (`Textcee`), prix de revient, grille
  du tarif fioul (`Gridtarpp`, `Fiches_ligtarpp`).

Elle lit et écrit des **contrôles de l'appelant** reçus en paramètres (`Frais` mis en lecture
seule et recalculé, `PaUA`, `Prvt`, `TxTva`, `code`) et lève l'événement **`recalculpx`** à chaque
recalcul du prix de revient ; `Articles.$opt_recalculpx` le traite (`PaUALF`). `commande1`
déclare le groupe `"opt"` sans gestionnaire `opt_recalculpx` (événement ignoré).

Nature globale : **mixte** (GUI dominante ; SQL de lecture et enregistrement `Fiches_Art`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$numart` | var | Private |  | String | 5 |
| `$schoix` | var | Private |  | String | 6 |
| `$Textfrais` | var | Private |  | Object | 7 |
| `$TextPaUA` | var | Private |  | Object | 8 |
| `$textPrvt` | var | Private |  | Object | 9 |
| `$code` | var | Private |  | Object | 10 |
| `$texttxtva` | var | Private |  | TextLabel | 11 |
| `$snbdec` | var | Private |  | String | 12 |
| `$bcreer` | var | Private |  | Boolean | 13 |
| `$resregie` | var | Private |  | Result | 14 |
| `prixachat` | property | Public |  | String | 16 |
| `prixrev` | property | Public |  | String | 17 |
| `numart` | property | Public |  | String | 18 |
| `creer` | property | Public |  | Boolean | 19 |
| `recalculpx` | event | Public |  |  | 21 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 23-127 | Public | 9 | 78 | 0 | méthode spéciale |
| `form_Close` | 129-136 | Public | 5 | 6 | 0 | handler GUI |
| `cmpt_lostfocus` | 137-144 | Public | 3 | 7 | 0 | handler GUI |
| `Butrechreg_Click` | 147-167 | Public | 4 | 18 | 0 | handler GUI |
| `Listregie_Activate` | 169-175 | Public | 1 | 5 | 0 | handler GUI |
| `Textcdr_GotFocus` | 177-181 | Public | 2 | 3 | 0 | handler GUI |
| `Textcdr_LostFocus` | 183-191 | Public | 2 | 8 | 0 | handler GUI |
| `Textvol_LostFocus` | 194-201 | Public | 2 | 6 | 0 | handler GUI |
| `Textdeg_LostFocus` | 203-209 | Public | 2 | 6 | 0 | handler GUI |
| `grpal_click` | 214-235 | Public | 4 | 18 | 0 | handler GUI |
| `grcode_gotfocus` | 237-241 | Public | 2 | 3 | 0 | handler GUI |
| `grcode_lostfocus` | 243-271 | Public | 8 | 26 | 0 | handler GUI |
| `Listcons_Activate` | 273-297 | Public | 5 | 22 | 0 | handler GUI |
| `calculpxrev` | 299-314 | Private | 5 | 13 | 0 |  |
| `calculalcool` | 316-333 | Private | 5 | 15 | 0 |  |
| `Buttontar_Click` | 335-351 | Public | 2 | 13 | 0 | handler GUI |
| `Buttcons_Click` | 353-357 | Public | 1 | 3 | 0 | handler GUI |
| `affiche` | 362-427 | Private | 15 | 62 | 0 |  |
| `affmab` | 429-460 | Public | 1 | 31 | 1 |  |
| `affalcool` | 462-481 | Private | 7 | 18 | 0 |  |
| `afftarif` | 483-510 | Private | 6 | 26 | 0 |  |
| `enregiste` | 512-552 | Public | 10 | 38 | 1 |  |
| `prixachat_Read` | 554-558 | Private | 1 | 3 | 0 |  |
| `prixachat_Write` | 560-565 | Private | 1 | 4 | 0 |  |
| `prixrev_Read` | 567-571 | Private | 1 | 3 | 0 |  |
| `prixrev_Write` | 573-578 | Private | 1 | 4 | 0 |  |
| `numart_Read` | 580-584 | Private | 1 | 3 | 0 |  |
| `numart_Write` | 586-591 | Private | 1 | 4 | 0 |  |
| `creer_Read` | 593-597 | Private | 1 | 3 | 0 |  |
| `creer_Write` | 599-608 | Private | 2 | 8 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et fermeture

- **`_new(TabStrip1, choix, frais, PaUA, Prvt, TxTva, code)`** [portée : nécessaire] [GUI].
  Titre d'onglet, `Frais` de l'appelant en lecture seule et grisé, désactive le panneau de
  l'option absente, mémorise les contrôles reçus, observateurs `cmpt` sur 11 zones, types et
  décimales des `TextReg`, `Chainage` selon l'option, colonnes de `Gridtarpp`.
- **`form_Close`** [handler] [GUI]. **Détruit** (`Delete`, sous `Try`) les contrôles de
  l'appelant reçus en paramètres (`Frais`, `PaUA`, `Prvt`, `TxTva`) : sans effet visible tant
  que la fermeture coïncide avec celle de l'appelant (à confirmer pour `commande1`).

### Saisie et calculs

- **`cmpt_lostfocus`** [handler d'observateur] [GUI]. Synchronise `Texttrs`/`Texttrspp`, puis
  `calculpxrev`. `Textvol`/`Textdeg` ont en plus leurs propres `_LostFocus` : le prix de revient
  est recalculé (et `recalculpx` levé) plusieurs fois par perte de focus.
- **`calculpxrev`** [Private] [mixte]. Frais = transports + sucre + éco − remise ; sous-total ;
  + droits et sécu ; écrit `Frais` et `Prvt` de l'appelant ; `Raise recalculpx`.
- **`calculalcool`** [Private] [mixte]. `New Calculdroit(code, volume, degré, 1)` ; droits et
  sécu « à part » si la régie est suspendue ou `Checkdr` coché ; `calculpxrev`.
- **`Butrechreg_Click` / `Listregie_Activate`** [handlers] [mixte]. Liste des régies
  (`Fiches_regie`) ; sélection → `Textcdr` → `Textcdr_LostFocus`.
- **`Textcdr_GotFocus` / `Textcdr_LostFocus`** [handlers] [mixte]. Charge `$resregie` ;
  `calculalcool` puis `affalcool`.
- **`Textvol_LostFocus` / `Textdeg_LostFocus`** [handlers] : `calculalcool`, `calculpxrev`.
- **`grpal_click` / `Listcons_Activate`** [handlers des boutons `Butcons`, `Button3`, `Button4`]
  [mixte]. Liste des consignes du type `Last.Tag` ; sélection → code et libellé selon le type.
- **`grcode_gotfocus` / `grcode_lostfocus`** [handlers du groupe `Textcp`/`Textcc`/`Textcb`]
  [mixte]. Vérifie le code (`Fiches_consigne`) ; libellé + prix, ou bulle « Consigne
  innexistante ».
- **`Buttontar_Click`** [handler] [GUI]. Fenêtre modale `Ttarfioul(win, $numart)` (le `Parent`
  `win` avant l'optionnel `num` : correct).
- **`Buttcons_Click`** [handler] [GUI]. `Tconsigne.ShowModal` (auto-instance).

### Affichage et enregistrement

- **`affiche`** [Private] [mixte] (CC 15). Lit l'article ; boisson : nombres de décimales,
  frais, régie (`Textcdr` affecté deux fois), consignes et libellés (`Fiches_consigne`),
  `$resregie`, `affalcool`, `calculalcool` ; carburant : transport, `art_ecof`, `afftarif`.
- **`affmab`** [portée : nécessaire (`Articles:4167`)] [GUI]. Remise à blanc des zones (ne
  réinitialise pas `$resregie`).
- **`affalcool`** [Private] [GUI]. Type (alcool, bière, vin), `drfac`, vignette, « En AP »/
  « En volume ».
- **`afftarif(vol)`** [Private] [mixte]. `Fiches_ligtarpp` de l'article ; bornes × 1000 si
  l'unité est `M3`/`Tonne` ; TTC avec le taux de `TxTva` ou, sans `TxTva` (`commande1`), celui de
  l'article (`Fiches_Art JOIN Fiches_Tvaav`, sans test `Available`).
- **`enregiste(Optional Commit = True)`** [portée : nécessaire (`Articles:3916/3926`)]
  [calcul]. `Begin` (si `Commit`), `Edit("Fiches_Art", "art_code=&1", code)` ; ⚠️ `Return` sans
  `Commit` si l'article est introuvable (A01) ; boisson : frais, régie (vidée si le code n'existe
  pas), droits, consignes ; carburant : `art_trsp`, `art_ecof` ; `Update`, `Commit`, `affmab`.
  `art_trsp` est écrit deux fois en option `T` (le carburant l'emporte).

### Propriétés

`numart` (écriture → `affiche` ; `Articles:490`, `commande1:206`), `prixachat`, `prixrev`
(écrites par `Articles:1548/1549`, lecteurs inutilisés), `creer` (**aucun usage** → code mort,
avec `$bcreer` et l'activation de `Panel13`).

## État global utilisé

`Utils.db` (`Exec`, `Edit`, `Begin`, `Commit`), `Utils.ObsGotf`/`ObsLstf`, `TextReg.EstNum`,
`Chainage`, `Calculdroit`, `Ttarfioul`, `Tconsigne`, `Balloon`, `Last`. Tables `Fiches_Art`,
`Fiches_regie`, `Fiches_consigne`, `Fiches_ligtarpp`, `Fiches_Tvaav` ; colonnes d'option créées
par [`modfichier`](../modfichier.module/architecture.md). `$snbdec` : jamais utilisé.

## Propositions d'amélioration

### Réécriture / refactorisation

- `_new` : table `[contrôle, décimales]` pour les 20 réglages `TextReg`.
- `grcode_lostfocus` et `Listcons_Activate` : même affectation code/libellé par type →
  `AfficheConsigne(res)`.
- `affiche` : supprimer la double affectation de `Textcdr` ; extraire `AfficheConsignes(res)`.

### Commonalisation avec d'autres fichiers

- `LitConsigne(code)` commun avec [`facopt`](../facopt.class/architecture.md) (FACOPT-006).
- Calcul de prix de revient/droits proche de `calculdroit1` et `Achat` (lot option et Entrées).

### Réduction de portée

Aucune : `affmab`, `enregiste` et les propriétés `numart`, `prixachat`, `prixrev` sont utilisés
par `Articles`/`commande1` ; les autres membres publics sont des handlers.

### Séparation traitement / GUI

- `enregiste` : `EnregistreOptions(code, valeurs)` sans contrôle.
- `calculpxrev` : `PrixRevient(valeurs) As Float` pur, affectations dans l'appelant.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Colonnes `art_*` de l'option à intégrer au schéma de référence (migration `LauruxMaj`).
