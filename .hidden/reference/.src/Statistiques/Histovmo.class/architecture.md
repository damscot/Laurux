# Histovmo — Architecture

> Source : `.src/Statistiques/Histovmo.class`

## Vue d'ensemble

`Histovmo` imprime l'**historique des ventes de main-d'oeuvre (MO)** sur une période (menu
`Fmenu.class:1370`, `Histovmo.Show` sur l'auto-instance). L'utilisateur choisit des plages de code MO
(`Mo`–`Mo2`), de famille (`Fam`–`Fam2`), de fournisseur (`Four`–`Four2`), la période (`dteN0`–`dteN1`,
défaut `Calc_mois(dteclec1)` → aujourd'hui), le tri (`RadioButton1` code, `2` famille, `3` fournisseur,
`4` désignation), la source (`Facn` documents normaux, `Face` documents matériel, `Fact` les deux ;
le choix est masqué et forcé à `Facn` si `/Soc<XX>/Materiel = 0`) et la case `Bl` (inclure les BL en
plus des factures en cours). **Imprimer** (`Button2`) produit `~/tmp/HistoArt.pdf` (`Chistoriques`) :
une ligne par MO avec quantité et total HT vendus.

Six listes de choix (`Colmo`, `Colmo2`, `Colfam`, `Colfam2`, `Colfour`, `Colfour2`) s'ouvrent par les
boutons bascule ou F2 et remplissent les zones de plage.

Nature globale : **mixte**. Lecture seule (aucune écriture en base). `Utils.Observers(Me)` est appelé
une fois dans `_New`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Filename` | var | Private |  | String | 28 |
| `Tab` | var | Private |  | String | 29 |
| `son` | var | Private |  | Integer | 30 |
| `Coulfond` | var | Private |  | New String[] | 31 |
| `PosY` | var | Private |  | Integer | 32 |
| `PosX` | var | Private |  | Integer | 33 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 35-64 | Public | 2 | 27 | 0 | méthode spéciale |
| `dte_KeyPress` | 66-92 | Public | 10 | 22 | 0 | handler GUI |
| `dteN0_LF` | 97-110 | Public | 3 | 12 | 0 | portée réductible ? |
| `dteN1_LF` | 115-135 | Public | 6 | 19 | 0 | portée réductible ? |
| `ToggleButton1_Click` | 140-173 | Public | 5 | 30 | 0 | handler GUI |
| `Colmo_KeyPress` | 178-199 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton2_Click` | 204-237 | Public | 5 | 31 | 0 | handler GUI |
| `Colmo2_KeyPress` | 242-263 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton3_Click` | 268-300 | Public | 5 | 30 | 0 | handler GUI |
| `Colfam_KeyPress` | 305-326 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton4_Click` | 331-364 | Public | 5 | 31 | 0 | handler GUI |
| `Colfam2_KeyPress` | 369-390 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton5_Click` | 395-427 | Public | 5 | 30 | 0 | handler GUI |
| `Colfour_KeyPress` | 432-453 | Public | 6 | 18 | 0 | handler GUI |
| `ToggleButton6_Click` | 458-491 | Public | 5 | 31 | 0 | handler GUI |
| `Colfour2_KeyPress` | 496-517 | Public | 6 | 18 | 0 | handler GUI |
| `Colmo_Click` | 522-530 | Public | 1 | 7 | 0 | handler GUI |
| `Colmo2_Click` | 535-543 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam_Click` | 548-556 | Public | 1 | 7 | 0 | handler GUI |
| `Colfam2_Click` | 561-569 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour_Click` | 574-582 | Public | 1 | 7 | 0 | handler GUI |
| `Colfour2_Click` | 587-594 | Public | 1 | 6 | 0 | handler GUI |
| `Btn_Click` | 596-612 | Public | 6 | 11 | 0 | handler GUI |
| `Btn_KeyPress` | 614-621 | Public | 2 | 6 | 0 | handler GUI |
| `Cmpt_KeyPress` | 623-686 | Public | 18 | 55 | 0 | handler GUI |
| `Cmpt_GotFocus` | 691-697 | Public | 1 | 5 | 0 | handler GUI |
| `Dte_GotFocus` | 702-708 | Public | 1 | 5 | 0 | handler GUI |
| `Button2_Click` | 710-854 | Public | 39 | 140 | 0 | portée réductible ? |
| `Level1` | 857-876 | Public | 1 | 18 | 0 | portée réductible ? |
| `Level2` | 879-893 | Public | 1 | 13 | 0 | portée réductible ? |
| `Button1_Click` | 895-899 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et saisie

- **`_New()`** [portée : nécessaire (spéciale)] [nature : mixte]. `Coulfond`, `Frmt` (inutilisés),
  `Utils.Observers(Me)`, son ; `SELECT * FROM Fiches_Parametres` (nom en dur, sans test `Available`) →
  `dteN0 = Calc_mois(dteclec1)`, `dteN1` = aujourd'hui ; plages par défaut `00000`–`ZZZZZ` (MO et
  famille) et `401001`–`40199999` (fournisseur) ; masque `HBox3` et coche `Facn` si `/Soc<XX>/Materiel
  = 0`.
- **`dte_KeyPress()`** [portée : nécessaire (handler du groupe `Dte`)] [nature : GUI]. Entrée/Retour/Tab
  sur `DteN0` (tag 7) → `dteN0_LF` puis focus `dteN1` ; sur `Dten1` (tag 8) → `dteN1_LF` puis focus
  `dteN0` ; F1 → `Button1_Click`.
- **`dteN0_LF()` / `dteN1_LF()`** [portée : réductible] [nature : GUI]. Normalisation (`Cdate_calc`,
  `Cdate_aff`, `"00.00.0:00"` → aujourd'hui) ; `dteN1_LF` avertit si la fin précède le début. Mêmes
  méthodes que [`HitCarte`](../HitCarte.class/architecture.md).
- **`Cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI]. Entrée/Tab :
  focus sur la zone suivante (tags 1 à 6) ; F1 → aide ; F2 → bascule de la liste correspondante
  (`ToggleButton1..6_Click`).
- **`Cmpt_GotFocus()` / `Dte_GotFocus()`** [portée : nécessaire (handlers)] [nature : GUI].
  `Utils.SetEditColor`.

### Listes de choix (6 × 3 méthodes)

- **`ToggleButton1_Click` … `ToggleButton6_Click`** [portée : nécessaire (handlers)] [nature : mixte].
  Bascule de la liste : si visible, la vide et la cache ; sinon configure 2 colonnes et la remplit par
  `SELECT * FROM Fiches_Mo order by mo_code` (1, 2), `Fiches_Fam order by code_fam` (3, 4) ou
  `Fiches_Four order by fo_code` (5, 6), sélectionne la première ligne et prend le focus. Noms de
  tables en dur ; 1, 3 et 5 écrivent dans le membre `Tab`, 2, 4 et 6 dans une variable locale.
  `With Utils` inutile. Corps identiques à `EdArt1`, `EdArt3`, `EdStk`, `Edmo`.
- **`Colmo_KeyPress` … `Colfour2_KeyPress`** [portée : nécessaire (handlers)] [nature : GUI].
  Entrée → `Col*_Click` ; F1 → aide ; Échap/F2 → ferme la liste et rend le focus à la zone. ⚠️
  `Colfam2` et `Colfour2` donnent le focus à `fam`/`four` mais sélectionnent `fam2`/`four2`.
- **`Colmo_Click` … `Colfour2_Click`** [portée : nécessaire (handlers, rejeu dynamique)] [nature : GUI].
  Recopient le code choisi dans la zone, ferment la liste, passent à la zone suivante. Appelés par
  `ReplayObserver.Replay_Click` via `Object.Call` : doivent rester `Public`.

### Boutons et impression

- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : GUI]. Tag 2 →
  `Button2_Click` ; tag 3 → suppression de `Filename` puis `Me.Close`. Le `Case 1` est **inatteignable**
  (`Button1` n'est pas dans le groupe `Btn`, il a son propre handler).
- **`Btn_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. **Toute** touche sur `Button2`
  (tag 2), y compris Tab, lance l'impression ; Espace la lance deux fois (`KeyPress` puis `Click`), à
  confirmer au rejeu.
- **`Button2_Click()`** (CC 39) [portée : réductible] [nature : mixte]. Membre du groupe `btn` dans le
  `.form` : n'est **pas** levé, il est appelé par `Btn_Click` et `Btn_KeyPress`.
  1. Ouvre le PDF (`Chistoriques`, `Entete` avec la période, `Level1`).
  2. `SELECT * FROM Fiches_Mo WHERE mo_code BETWEEN … and mo_fam BETWEEN …` ; **la plage fournisseur
     n'est appliquée qu'avec le tri par code** (`RadioButton1`), pas avec les tris 2 à 4.
  3. Pour chaque MO : lignes historisées `typel_ligfac = 'M'` (`Fiches_HistoLigfac`, `…M` ou union
     selon `Facn`/`Face`/`Fact`), puis en-tête `Fiches_HistoFac`/`…M` par `numfac`, filtre de date
     **côté Gambas** (`Cdate_Comp(datefac)`, bornes incluses) ; cumul `qte` (ou +1 si quantité nulle,
     sans montant) et `pvht += netht_ligfac`.
  4. Puis lignes en cours `Fiches_Ligbl`/`…M` de type `M` (en mode `Fact`, la partie `Fiches_LigblM`
     filtre `typel_ligbl <> 'M'` : **inversé**) ; en-tête `Fiches_Bl`/`…M` : avec `Bl` coché,
     `WHERE numbl = &1 and type = 'B' or type = 'F'` (**priorité `AND`/`OR`** : renvoie aussi toutes les
     factures `F` de la table, la première ligne lue peut être un autre document) ; sans `Bl`,
     `type = 'F'` (sans filtre `imp`). Filtre de date sur `datebl` côté Gambas, même cumul.
  5. Si `qte <> 0` : `pdf.level2(code, intitulé, famille, fournisseur, qte, pvht, PosY)` ; saut de page à
     283 (`Footer`, `Entete`, `Level1`).
  6. Fin : `Footer`, `Output(~/tmp/HistoArt.pdf)`, `Visualiseur.Prog`, ou son + « Aucune MO pour cette
     demande ». `Filename` reçoit d'abord `~/tmp/HistoMo.ps` (écrasé aussitôt) ; `Shell "cd ~"` sans
     effet ; curseur final `Mouse.Pointing`.
  Tables (noms en dur, variables `Tab` à `Tab9`) : `Fiches_Mo`, `Fiches_HistoLigfac`,
  `Fiches_HistoLigfacM`, `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Bl`, `Fiches_BlM`,
  `Fiches_Ligbl`, `Fiches_LigblM`. Coût : une requête par MO, par ligne et par document.
  Partie extractible : étapes 2 à 4 (`VentesMo(bornes, iSource, bBl) As Collection` : code → qté, pvht).
- **`Level1()` / `Level2(…)`** [portée : réductible] [nature : GUI] — **code mort** : jamais appelés
  (`grep -rn` : les appels `pdf.Level1()`/`pdf.level2(…)` visent `Chistoriques.Level1`/`Level2`). Ils
  dessinent avec l'ancienne API `Draw` (imprimante) des en-têtes et lignes équivalents ; `Level2`
  utilise le membre `PosY`.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI]. `Doc.Open("Edtar")` : aide du
  tarif des articles (même page que les éditions d'articles), probablement inadaptée.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Materiel"]`,
  `["/Coul/Fnets"]`.
- `Utils.Observers`, `Utils.SetEditColor`, `Utils.Coulfd`, `Utils.FColr`, `Utils.Calc_mois`,
  `Utils.Cdate_calc`, `Utils.Cdate_aff`, `Utils.Cdate_Comp`, `Utils.Cdate_dbase`, `Utils.cpoint`,
  `Utils.db`.
- `Chistoriques` (`Entete`, `Level1`, `Level2`, `Footer`, `Output`), `Visualiseur.Prog`, `Doc.Open`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `Level1`/`Level2`, le `Case 1` de `Btn_Click`, `Frmt`, `Coulfond`, l'affectation
  `HistoMo.ps`, `Shell "cd …"`, les `With Utils` vides.
- Noms de tables via `Cbase.Table("TabMo" | "TabFam" | "TabFour" | "TabHisLigFac" | "TabHisLigFacm" |
  "TabHisFac" | "TabHisFacm" | "TabBl" | "TabBlM" | "TabLigbl" | "TabLigblM")` (texte SQL identique).
- `Button2_Click` : choisir une fois les tables selon `Facn`/`Face`/`Fact` (helper `Sources()`) au
  lieu de 9 `If` répétés dans la boucle.

### Commonalisation avec d'autres fichiers

- Listes de choix : `ToggleButton1..6_Click` → `EdSelection.ListeCodes(cv, table, code, lib)` prévu
  par [EDART1-003](../../Gestion/Impressions/EdArt1.class/rework.md) et repris par
  [`Edmo`](../../Gestion/Impressions/Edmo.class/architecture.md) (EDMO-005, mêmes listes MO/famille).
  Les `Col*_KeyPress`/`Col*_Click` gardent leurs noms (handlers) et délèguent à un helper privé
  `FermeListe(cv, zone)`.
- Dates : `dteN0_LF`/`dteN1_LF` → `StatCommun.DateSaisie` (HITCARTE-006), avec
  [`HitCarte`](../HitCarte.class/architecture.md), [`RelvMo`](../RelvMo.class/architecture.md),
  [`RelMoprod`](../RelMoprod.class/architecture.md).
- `Dte_GotFocus` est identique au caractère près dans 7 écrans (dont `HitCarte`) et `dte_KeyPress` a
  6 copies (relevé du lot `Stat*`) : corps délégués au socle `StatCommun` proposé dans
  [`StatComm`](../StatComm.class/architecture.md), handlers conservés.
- Période par défaut depuis `dteclec1` : même code que `RelvMo.Ex1` et `RelMoprod.Ex1`
  (`PeriodeParDefaut()`, RELVMO-007).
- Cumul des ventes MO : `RelvMo.Button1_Click` parcourt les mêmes tables pour la même information
  (par client) ; une fonction `LignesMo(code, d0, d1, iSource)` commune est envisageable en phase 3,
  après correction des anomalies de chacun (les règles diffèrent aujourd'hui : `imp = 1` exigé dans
  `RelvMo`, pas ici).

### Réduction de portée

- `dteN0_LF`, `dteN1_LF`, `Button2_Click` (non levé : groupe `btn`) → `Private`. `Level1`/`Level2`
  sont supprimés (code mort). Les handlers (`ToggleButton*_Click`, `Col*_Click`, `Col*_KeyPress`,
  `Btn_*`, `Cmpt_*`, `dte_KeyPress`, `Dte_GotFocus`, `Button1_Click`) restent `Public`.

### Séparation traitement / GUI

- `Button2_Click` → `VentesMo(…)` (SQL et cumuls, sans contrôle) + `ImprimeHistoMo(ventes, titre)`
  (PDF) ; le handler lit les zones et les cases, gère le curseur et le message.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une requête d'agrégat unique (`SUM(qte_ligfac), SUM(netht_ligfac) … JOIN … WHERE datefac BETWEEN …
  GROUP BY code_ligfac`) remplacerait les requêtes unitaires ; un index `(typel_ligfac, code_ligfac)`
  sur les lignes historisées l'accélérerait.
- `qte_ligfac`/`netht_ligfac` textuels (virgule possible, d'où `cpoint`) : types numériques.
