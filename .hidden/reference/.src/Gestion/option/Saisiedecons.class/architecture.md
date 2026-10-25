# Saisiedecons — Architecture

> Source : `.src/Gestion/option/Saisiedecons.class` · Formulaire : `Saisiedecons.form`

## Vue d'ensemble

`Saisiedecons` est l'écran de **saisie des déconsignations fournisseur** (option boissons) : sur
un bon de réception **non validé** (`Fiches_Entrecpt.validee` faux), l'utilisateur saisit les
emballages rendus au fournisseur (palettes, colis, bouteilles), qui viennent **en déduction** du
montant de la réception. Ouvert par `menuopt.decfour_click` (`Saisiedecons.Show`, auto-instance,
sans paramètre).

Règle métier telle que le code l'applique :

- sélection du fournisseur (`Textfour`, `TriCpt`) et de la réception (`Textbl`, liste des
  réceptions non validées construite dans une fenêtre `$win` créée par code) ; la clé de
  consigne est `bloc = date (dd.mm.yyyy) & n° réception & fournisseur` (même clé que
  `Achat.EnrConsigne` et `ValidBR1`) ;
- en tête : HT/TTC de la réception, total des consignes (`numlig <> 'D'`), total des
  déconsignations (`numlig = 'D'`), cumul des droits d'accise (`calculdroit.droit` des lignes
  d'articles à régie si `drsurfac`) ;
- une déconsignation est une ligne `Fiches_ligcons` avec `numlig = 'D'`, `type = 'E'`,
  `nb = −quantité`, `montant = −quantité × prix de la consigne`, `envaleur = True` ;
- **chaque déconsignation diminue d'autant le HT et le TTC** de la réception (pas de TVA sur les
  consignes), réécrits dans `Fiches_Entrecpt.montant`/`mttc` à la validation de la ligne ;
- la saisie d'un nombre de palettes propose `palettes × art_nbcol` colis, celle des colis
  `colis × art_nbbou` bouteilles (une seule fois par article) ; F5 ouvre la calculette
  [`FCalc`](../../../Utils/FCalc.class/architecture.md) (`FCalc.Resultat`, format `"0"`).

Nature globale : **GUI + SQL + règle de montant** (écran mixte de 623 lignes).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Bsel` | var | Public |  | Boolean | 3 |
| `Bval` | var | Public |  | String | 4 |
| `$rescons` | var | Private |  | Result | 6 |
| `$sbloc` | var | Private |  | String | 7 |
| `$inbc` | var | Private |  | Integer | 8 |
| `$inbb` | var | Private |  | Integer | 9 |
| `$bcrea` | var | Private |  | Boolean | 10 |
| `$smodif` | var | Private |  | String | 11 |
| `$irow` | var | Private |  | Integer | 12 |
| `$fen` | var | Private |  | Window | 13 |
| `$win` | var | Private |  | Window | 15 |
| `$grdv` | var | Private |  | GridView | 16 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 18-72 | Public | 2 | 49 | 0 | méthode spéciale |
| `form_MouseDown` | 74-78 | Public | 2 | 3 | 0 | handler GUI |
| `GridView1_MouseDown` | 79-83 | Public | 2 | 3 | 0 | handler GUI |
| `Panel1_MouseDown` | 84-88 | Public | 2 | 3 | 0 | handler GUI |
| `Panel2_MouseDown` | 89-93 | Public | 2 | 3 | 0 | handler GUI |
| `Frame1_MouseDown` | 94-98 | Public | 2 | 3 | 0 | handler GUI |
| `saisie_gotfocus` | 100-105 | Public | 3 | 4 | 0 | handler GUI |
| `saisie_lostfocus` | 107-112 | Public | 5 | 4 | 0 | handler GUI |
| `saisie_keypress` | 114-136 | Public | 9 | 19 | 0 | handler GUI |
| `Textfour_LostFocus` | 138-148 | Public | 3 | 8 | 0 | handler GUI |
| `textbl_LostFocus` | 150-164 | Public | 4 | 12 | 0 | handler GUI |
| `Butfour_Click` | 166-181 | Public | 2 | 13 | 0 | handler GUI |
| `Butbl_Click` | 183-237 | Public | 5 | 50 | 0 | handler GUI |
| `rechbl_keypress` | 239-249 | Public | 5 | 9 | 0 | handler GUI |
| `rechbl_click` | 251-258 | Public | 1 | 7 | 0 | handler GUI |
| `selectionbr` | 260-292 | Private | 8 | 31 | 0 |  |
| `GridView1_Data` | 294-306 | Public | 1 | 10 | 0 | handler GUI |
| `GridView1_Activate` | 308-332 | Public | 4 | 23 | 0 | handler GUI |
| `GridView1_KeyPress` | 334-347 | Public | 5 | 12 | 0 | handler GUI |
| `lirefour` | 349-357 | Private | 2 | 6 | 0 |  |
| `Butart_Click` | 360-378 | Public | 3 | 16 | 0 | handler GUI |
| `Textart_LostFocus` | 380-384 | Public | 1 | 3 | 0 | handler GUI |
| `selectionart` | 387-411 | Private | 7 | 22 | 0 |  |
| `consigne_click` | 413-449 | Public | 4 | 33 | 0 | handler GUI |
| `rechcons_click` | 451-456 | Public | 1 | 4 | 0 | handler GUI |
| `Textqtecol_LostFocus` | 458-471 | Public | 4 | 12 | 0 | handler GUI |
| `Textqtepal_LostFocus` | 473-486 | Public | 4 | 12 | 0 | handler GUI |
| `selectioncons` | 489-508 | Private | 5 | 17 | 0 |  |
| `Butval_Click` | 510-547 | Public | 9 | 35 | 0 | handler GUI |
| `Butval_KeyPress` | 549-553 | Public | 4 | 3 | 0 | handler GUI |
| `majcons` | 555-578 | Private | 2 | 21 | 0 |  |
| `calculbasdoc` | 580-586 | Private | 1 | 5 | 0 |  |
| `mab` | 588-602 | Private | 1 | 13 | 0 |  |
| `Butenr_Click` | 605-623 | Public | 2 | 17 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et navigation

- **`_new(Optional f, nfour, nbl, dte)`** [portée : nécessaire] [nature : GUI].
  `Utils.Observers(Me)` ; colonnes de `GridView1` ; chaînage des zones par `Tag` (précédent,
  suivant) ; observateurs `saisie` (9 zones) et `consigne` (3 boutons bascule `P`/`C`/`B`) ; si
  `nfour` fourni : préremplissage, `Butenr.Tag = 1` et `selectionbr`. Les paramètres ne sont
  fournis par **aucun** appelant (seule ouverture : `menuopt`, sans argument) : branche morte, et
  `$fen` reste `Null` (`Butenr_Click` ferait `$fen.Close`).
- **`form_MouseDown`, `GridView1_MouseDown`, `Panel1_MouseDown`, `Panel2_MouseDown`,
  `Frame1_MouseDown`** [handlers] [nature : GUI]. `Try $win.Close` (ferme la liste flottante).
- **`saisie_gotfocus`**, **`saisie_lostfocus`**, **`saisie_keypress`** [handlers] [nature : GUI].
  Focus, sélection de la consigne saisie (`selectioncons`) en sortie des zones de code, flèches /
  Entrée / Tab selon les `Tag`, **F5** → `New FCalc`, `ShowModal`, `Last.Text =
  Format$(Val(FCalc.Resultat), "0")` si non nul (hérite de FCALC-A01 : résultat non remis à zéro).

### Fournisseur et réception

- **`Textfour_LostFocus`** [handler] : `lirefour` ; code vidé si inconnu.
- **`lirefour()`** [privée] [nature : mixte]. `SELECT fo_nom FROM Fiches_Four WHERE fo_code = &1`
  avec **`Val(Textfour.Text)`** : le code fournisseur est passé en nombre (codes alphanumériques
  jamais trouvés ; zéros de tête perdus, à confirmer).
- **`textbl_LostFocus`** [handler] [nature : mixte]. `SELECT * FROM Fiches_Entrecpt WHERE four = &1
  AND numrecpt = &2` → date, `selectionbr`.
- **`Butfour_Click`** [handler] : `TriCpt(Fournisseur, Sans_Solde, Me)` ; `Bsel`/`Bval` écrits par
  `TriCpt` ; `Bsel` jamais remis à `False`.
- **`Butbl_Click`** [handler] [nature : mixte]. Fenêtre modale `$win` + `GridView` `$grdv` (`As
  "rechbl"`) des réceptions non validées (du fournisseur ou toutes) : `SELECT four, numrecpt,
  ddate, montant, fo_nom FROM Fiches_Entrecpt, Fiches_Four WHERE … AND NOT validee`.
- **`rechbl_keypress`**, **`rechbl_click`** [handlers de la grille créée par code] : Entrée/Échap ;
  reprise fournisseur, n° et date, `selectionbr`.
- **`selectionbr()`** (CC 8) [privée] [nature : mixte, extractible : les 5 requêtes et le cumul
  d'accise]. Calcule `$sbloc` ; date reconstituée depuis `Textdate` ; `SELECT montant, mttc …
  AND ddate = &3 AND NOT validee` ; sommes des consignes et déconsignations ; lignes d'articles à
  régie (`art_dra <> ''`) → `New Calculdroit(dra, volm, deg, qte)` → `Labelacc +=
  droit` si `drsurfac` ⚠️ **sans remise à zéro** : chaque nouvel appel (sortie de `Textbl`)
  recumule l'accise ; liste des déconsignations ; désactive `Panel1`.

### Grille des déconsignations

- **`GridView1_Data`** [handler]. Code, libellé, nombre, PU = `montant / nb` (division par zéro si
  `nb = 0`), montant.
- **`GridView1_Activate`** [handler] [nature : mixte]. Passe en « Modification » de la ligne :
  relit la consigne, remplit la zone du type correspondant avec la quantité positive, mémorise
  `$irow` et l'ancien montant `$smodif`.
- **`GridView1_KeyPress`** [handler] [nature : mixte]. Suppr → `DELETE FROM Fiches_ligcons WHERE
  code = &1`, `Labeldec` diminué, relecture. ⚠️ Ni `Labelht`/`Labelttc` ni
  `Fiches_Entrecpt.montant/mttc` ne sont corrigés : la réception reste diminuée du montant de la
  ligne supprimée (SAISIEDECONS-A01).

### Article et consignes

- **`Butart_Click`** [handler] : `TriArticles(…, Me)` puis `selectionart`.
- **`Textart_LostFocus`** [handler] : `selectionart`.
- **`selectionart()`** [privée] [nature : mixte]. `SELECT * FROM Fiches_Art WHERE art_code = &1` →
  libellé, `$inbc = art_nbcol`, `$inbb = art_nbbou`, codes de consigne `art_consp/consc/consb` ;
  positionne le focus.
- **`consigne_click`** [handler des 3 boutons bascule] [nature : mixte]. Fenêtre `$win` + grille
  `As "rechcons"` des consignes du type `Last.Tag` (`P`/`C`/`B`).
- **`rechcons_click`** [handler de la grille créée par code] : `selectioncons(code)`.
- **`selectioncons(code)`** [privée] [nature : mixte]. Lit la consigne et remplit la zone de son type.
- **`Textqtepal_LostFocus`**, **`Textqtecol_LostFocus`** [handlers] [nature : calcul + GUI].
  Nombre entier requis ; propose colis = palettes × `$inbc`, bouteilles = colis × `$inbb`, puis
  remet le coefficient à 0.

### Validation

- **`Butval_Click`** (CC 9) [handler] [nature : mixte]. Sort si aucune réception (`"Date"`) ; en
  modification, réintègre l'ancien montant (`calculbasdoc(−ancien)`) ; `Begin` ; `majcons` pour
  chaque type renseigné avec une quantité non nulle ; relecture ; `Utils.db.Edit("Fiches_Entrecpt",
  "four = &1 AND numrecpt = &2")` (sans la date, alors que `selectionbr` filtre aussi sur `ddate`)
  → `montant`, `mttc` = libellés HT/TTC ; `Commit` ; retour en « Création ».
- **`Butval_KeyPress`** [handler] : Entrée/Tab → `Butval_Click`.
- **`majcons(code, nb)`** [privée] [nature : mixte, extractible : calcul du montant]. `Create9` (création)
  ou `Edit` de la ligne `$irow` (modification) de `Fiches_ligcons` ; `SELECT * FROM
  Fiches_consigne WHERE code = &1` lu **sans test `Available`** ; remplit la ligne (voir règle) ;
  `calculbasdoc(montant)` ; `$bcrea = True`.
- **`calculbasdoc(montant)`** [privée] [nature : calcul + GUI]. Ajoute `montant` (négatif) à
  `Labeldec`, `Labelht`, `Labelttc`.
- **`mab()`** [privée] [nature : GUI]. Vide la saisie de ligne.
- **`Butenr_Click`** [handler] [nature : GUI]. Ferme `$fen` si `Tag = 1` (jamais le cas), vide
  l'écran et réactive la sélection.

## État global utilisé

- `Utils.db` (`Exec`, `Create9`, `Edit`, `Begin`, `Commit`), `Utils.Observers`, `Utils.ObsGotf`,
  `Utils.ObsLstf`, `Utils.totobs`, `FCalc.Resultat` (statique).
- Tables : `Fiches_ligcons`, `Fiches_consigne` (créées par `modfichier.fichierboisson`, absentes de
  `db_control.csv`), `Fiches_Entrecpt`, `Fiches_Ligrecpt`, `Fiches_Four`, `Fiches_Art` (colonnes
  d'option `art_dra`, `art_volm`, `art_deg`, `art_cons*`, `art_nbcol`, `art_nbbou`).

## Propositions d'amélioration

### Réécriture / refactorisation

- `selectionbr` : fonctions privées `TotauxReception`, `TotalConsignes(bloc, deconsigne)`,
  `CumulAccise(...)` sans contrôles (SQL identique).
- `Butbl_Click` et `consigne_click` construisent la même fenêtre flottante (fenêtre + grille) :
  helper privé `FenetreListe(nom, colonnes, largeur, hauteur, x, y)`.
- Requête `SELECT * FROM Fiches_ligcons, Fiches_consigne WHERE … numlig = 'D'` répétée 4 fois →
  `Relire()`.

### Commonalisation avec d'autres fichiers

- Prix de consigne × nombre : `Consigne.PrixUnitaire` (CONSIGNE-006).
- Clé `bloc` : `Consigne.Bloc(...)` proposée (voir [Consigne](../Consigne.class/architecture.md)).
- F5 → calculette : idiome commun aux 7 appelants de `FCalc` (FCALC-005 `FCalc.Saisir`).
- Liste flottante de choix : même besoin que [`rechcons`](../rechcons.class/architecture.md)
  (pourrait réutiliser la fenêtre `rechcons` avec un type, à évaluer en phase 3).

### Réduction de portée

Aucune : handlers, ou `Bsel`/`Bval` (écrits par `TriCpt`/`TriArticles`).

### Séparation traitement / GUI

Voir `selectionbr`, `majcons` (montant = `−nb × prix`), `Textqtepal/col_LostFocus` (coefficients).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Lier les déconsignations à la réception par clé typée plutôt que par la chaîne `bloc` et la
  valeur sentinelle `numlig = 'D'`.
- Stocker les déconsignations dans un document distinct plutôt que de modifier les totaux de la
  réception (`Fiches_Entrecpt.montant`) : aujourd'hui les totaux d'origine sont perdus.
