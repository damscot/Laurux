# RelvMo — Architecture

> Source : `.src/Statistiques/RelvMo.class`

## Vue d'ensemble

`RelvMo` produit le **relevé des prestations de main-d'oeuvre (MO) par client** (menu
`Fmenu.class:1823`, `RelvMo.Show()` sur l'auto-instance). L'utilisateur saisit une période (défaut :
`Calc_mois(dteclec1)` → aujourd'hui), lance **Traitement** (`Button1`) qui remplit la table de travail
`Fiches_Stat` et la `ColumnView` `RlCli` (client, MO, quantité, montant TTC), peut retirer des lignes
(touche Suppr ou double-clic `Activate`), puis **Imprime** (`Button2`) un relevé PDF par client
(`Cdocuments`, en-tête société + adresse client), soit pour toutes les lignes (`RB1`), soit pour les
lignes sélectionnées (`RB2`, coché par défaut et par tout clic dans la liste).

Nature globale : **mixte**. L'écran appelle `Utils.Observers(Me)` une fois dans `_New`.

### Table de travail `Fiches_Stat` (hors `db_control.csv`)

`Button1_Click` exécute `DROP TABLE if exists Fiches_Stat` (`Cbase.Table("TabStat")`) puis `CREATE TABLE
Fiches_Stat (code Char(15) NOT NULL, intitule char(50), qte char(12), montant char(12), codecli
char(12), intitulecli char(35), PRIMARY KEY (code, codecli))`. Le même nom est recréé avec **d'autres
structures** par [`RelMoprod`](../RelMoprod.class/architecture.md) (10 colonnes, clé `code, codecli,
numfac`) et par `Affichages/TriHistos` (10 colonnes positionnelles). La table n'est pas dans
`db_control.csv` ; elle est commentée dans la liste des tables par société de `Fsoc.class:539`. Elle est
partagée entre postes (MySQL) et reste en base après le traitement.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dte` | var | Private |  | String | 27 |
| `dte1` | var | Private |  | String | 28 |
| `dte2` | var | Private |  | String | 29 |
| `jour` | var | Private |  | String | 30 |
| `son` | var | Private |  | Integer | 31 |
| `PosY` | var | Private |  | Integer | 32 |
| `b` | var | Private |  | Integer | 33 |
| `Filename` | var | Private |  | String | 34 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 36-63 | Public | 1 | 26 | 0 | méthode spéciale |
| `Cmpt_GotFocus` | 65-71 | Public | 1 | 5 | 0 | handler GUI |
| `Ex1` | 76-92 | Public | 1 | 14 | 0 | portée réductible ? |
| `cmpt_KeyPress` | 94-120 | Public | 9 | 22 | 0 | handler GUI |
| `dteN0_GotFocus` | 122-127 | Public | 1 | 4 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 129-142 | Public | 3 | 12 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 144-148 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 150-163 | Public | 3 | 12 | 0 | portée réductible ? |
| `RlCli_KeyPress` | 165-172 | Public | 2 | 6 | 0 | handler GUI |
| `RlCli_Activate` | 174-195 | Public | 6 | 19 | 0 | handler GUI |
| `Button1_Click` | 197-308 | Public | 37 | 109 | 0 | handler GUI |
| `MajTab` | 310-327 | Public | 3 | 15 | 0 | portée réductible ? |
| `Button2_Click` | 329-451 | Public | 26 | 119 | 0 | handler GUI |
| `RlCli_Click` | 453-457 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 459-463 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 465-468 | Public | 1 | 2 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`, son, 6 colonnes
  de `RlCli`, `Ex1()`, couleur et focus de `dteN0`.
- **`Cmpt_GotFocus()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI].
  `Utils.SetEditColor`.
- **`Ex1()`** [portée : réductible] [nature : mixte]. `SELECT * FROM Fiches_Parametres` (nom en dur, sans
  test `Available`) ; `dteN0 = Utils.Calc_mois(dteclec1)`, `dteN1 = aujourd'hui` ; `dte`, `dte1`, `dte2`,
  `jour` sont écrits mais jamais relus ailleurs.
- **`cmpt_KeyPress()`** [portée : nécessaire (handler du groupe `Cmpt`)] [nature : GUI]. Entrée/Retour/Tab
  sur `DteN0` (tag 1) → `dteN0_LostFocus` puis, si pas d'erreur (`b = 0`), `dteN1_GotFocus` ; sur `Dten1`
  (tag 2) → `dteN1_LostFocus`. F1 → `Button7_Click` (vide : l'aide `Doc.Open("RelMo")` est commentée).
- **`dteN0_GotFocus` / `dteN0_LostFocus` / `dteN1_GotFocus` / `dteN1_LostFocus`** [portée : réductible]
  [nature : GUI]. Les zones `DteN0`/`Dten1` appartiennent au groupe `Cmpt` : ces méthodes ne sont **pas**
  levées par Gambas (seul `Cmpt_*` l'est) ; ce sont des méthodes ordinaires appelées par
  `_New`, `cmpt_KeyPress` et `Button1_Click`. `LostFocus` normalise la date (`Cdate_calc`, `Cdate_aff`,
  `"00.00.0:00"` → aujourd'hui) et met `b = 1` en cas d'erreur (`Catch`).
- **`RlCli_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. Suppr → `RlCli_Activate`.
- **`RlCli_Activate()`** [portée : nécessaire (handler)] [nature : mixte]. Confirmation, puis
  `SELECT * FROM Fiches_Stat where codecli = &1 and code = &2` et, **pour chaque ligne trouvée**, le même
  `DELETE … WHERE codecli = &1 and code = &2` (un seul `DELETE` suffit, la clé est unique). Puis, que
  l'utilisateur ait confirmé **ou non**, `RlCli.Current.Delete`, `RlCli.Clear` et `MajTab()` (la ligne
  refusée réapparaît après rechargement : comportement visible identique, `Current.Delete` inutile).
- **`Button1_Click()`** (CC 37) [portée : nécessaire (handler)] [nature : mixte]. Valide les deux dates
  puis, si `b = 0` : recrée `Fiches_Stat` et, pour **chaque** main-d'oeuvre de `Fiches_Mo`
  (`Cbase.Table("TabMo")`) :
  1. lignes `Fiches_Ligbl` de type `M` de ce code → en-tête `Fiches_Bl` `type = 'F' and imp = 1`
     (factures non historisées) ; filtre de date **côté Gambas** (`Cdate_Comp(datebl)` entre les
     bornes `aaaammjj`, bornes incluses) ; puis `SELECT` dans `Fiches_Stat` du couple (MO, client) :
     s'il existe, `Update … SET qte = &2` (quantité cumulée) ; sinon `INSERT` (code, intitulé MO, qté,
     client, nom, `montant = nettc_ligbl`) ;
  2. idem avec `Fiches_HistoLigfac`/`Fiches_HistoFac` (`datefac`) ;
  3. idem avec `Fiches_HistoLigfacM`/`Fiches_HistoFacM`.
  Les montants **ne sont jamais cumulés** : l'`Update` n'écrit que `qte` (à la branche 3, `montant` est
  calculé ligne 276 puis ignoré) ; la colonne « Montant TTC » montre le montant de la première ligne
  trouvée (anomalie RELVMO-A02). `qte`/`montant` sont des `String` qui reçoivent des Float
  (`Val(…) + Val(…)`) puis passent dans `Format$(…, "0.00")` ; si `Val` échoue dans un `Try`, la
  variable garde la valeur de l'itération précédente (le `If Not Error` ne teste que le `Try` du
  montant). Les lignes `Fiches_LigblM` (documents matériel non historisés) ne sont pas lues. Coût :
  une requête par MO, par ligne et par document (N+1 imbriqués). Puis `MajTab()`. Si une date est
  invalide (`b = 1`) : « Veuillez saisir votre date SVP » et focus.
  Partie extractible : tout le remplissage de `Fiches_Stat` (`RemplitReleve(d0, d1)`).
- **`MajTab()`** [portée : réductible] [nature : GUI]. `SELECT * FROM Fiches_Stat order by codecli, code`
  → une ligne de `RlCli` par enregistrement (clé `codecli & code`). Le `Repeat` teste `Available` à
  chaque tour au lieu d'avant la boucle (équivalent).
- **`Button2_Click()`** (CC 26) [portée : nécessaire (handler)] [nature : mixte]. Lit la société
  (`Fiches_Societes` via `Cbase.Table("TabSoc")`, `cd_sc = Start.Societe`) et compose les mentions
  (RCS, SIRET, TVA, capital, NAF, téléphones, mail, site, IBAN). `Logo` est lu depuis la configuration
  mais jamais transmis ; `Shell "cd ~"` est sans effet. Parcourt `RlCli` (en `RB2`, seulement les
  lignes sélectionnées) ; à chaque changement de client : lecture de `Fiches_Cli` (sans test
  `Available`), `pdf.Entete(… 19 arguments)`, `Entete2`, `Level1R`, `Level4R`, `Level2R` ; puis
  `Level3R(code, libellé, qté, montant, Posy)`. **Saut de page** (`PosY >= 283`) : `pdf.Entete` est
  appelé avec **18 arguments** pour 19 paramètres obligatoires (`Libre` manque) → erreur d'exécution
  « Not enough arguments » dès qu'un client dépasse une page (anomalie RELVMO-A01). Fin : `Footer`,
  `Output(~/tmp/Relmo.pdf)`, `Visualiseur.Prog`, ou « Veuillez faire une sélection SVP ! ». Curseur
  final `Mouse.Custom` (sans image : à confirmer).
  Partie extractible : la lecture des mentions société (`MentionsSociete() As Collection`), commune
  aux autres relevés et documents.
- **`RlCli_Click()`** [portée : nécessaire (handler, rejeu dynamique)] [nature : GUI]. `RB2.Value = True`.
  Appelé par `ReplayObserver.Replay_Click` via `Object.Call` : doit rester `Public`.
- **`Button3_Click()`** [portée : nécessaire (handler)] : `Me.Close`.
- **`Button7_Click()`** [portée : nécessaire (handler)] : vide (aide commentée).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe`, `Start.LocalSettings["/Soc<XX>/glogo" | "/Logo"]`.
- `Utils.Observers`, `Utils.SetEditColor`, `Utils.Calc_mois`, `Utils.Cdate_calc`, `Utils.Cdate_aff`,
  `Utils.Cdate_Comp`, `Utils.Cdate_dbase`, `Utils.cpoint`, `Utils.db`.
- `Cbase.Table("TabStat" | "TabMo" | "TabLigbl" | "TabBl" | "TabHisLigFac" | "TabHisFac" |
  "TabHisLigFacm" | "TabHisFacm" | "TabSoc" | "TabCli")`.
- Table de travail partagée `Fiches_Stat`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser les trois blocs presque identiques de `Button1_Click` (BL, factures, factures matériel)
  dans un helper `CumuleMo(rLignes, sTableEnt, sChampNum, sChampDate, …)` en conservant les
  différences actuelles (montant ignoré à l'`Update`, `qte = "1"` seulement dans le bloc 2).
- `RlCli_Activate` : un seul `DELETE` au lieu de `SELECT` + boucle (**SQL modifié, dump identique**) ;
  supprimer `RlCli.Current.Delete` (la liste est vidée juste après).
- Supprimer `dte`, `dte1`, `dte2`, `Logo`, `Shell "cd …"`, `Button7_Click` vide (handler à garder si
  le bouton reste dans le `.form` : on garde la méthode, vide).
- Remplacer `Fiches_Parametres` en dur par `Cbase.Table("TabParam")`.

### Commonalisation avec d'autres fichiers

- **Saisie des dates** : `dteN0_LostFocus`/`dteN1_LostFocus` identiques à
  [`RelMoprod`](../RelMoprod.class/architecture.md) et proches de [`Histovmo`](../Histovmo.class/architecture.md)
  et [`HitCarte`](../HitCarte.class/architecture.md) → `StatCommun.DateSaisie` (HITCARTE-006).
- **`Ex1`** identique à `RelMoprod.Ex1` (période par défaut depuis `dteclec1`) → helper commun
  `PeriodeParDefaut() As String[]`.
- **Mentions société** : `Button2_Click` recopie la lecture de `Fiches_Societes` et la composition des
  mentions présentes dans d'autres relevés et documents (`FRelFacture`, `FRelCompte`, `FEditrel`, `Ligcli`,
  `Edcom`, `Facturergbl`, `Editfac`, `Caisse`, `ArchivesTck` lisent aussi `tvaintra_sc`) ;
  un helper `MentionsSociete()` partagé (phase 3, avec [`Cdocuments`](../../Reports/Cdocuments.class/architecture.md)).
- **Table `Fiches_Stat`** : recréée avec trois structures différentes par `RelvMo`, `RelMoprod` et
  [`TriHistos`](../../Affichages/TriHistos.class/architecture.md) (anomalie RELVMO-A03).

### Réduction de portée

- `Ex1`, `MajTab`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus` : aucun
  appelant externe et **pas** levés comme événements (zones dans le groupe `Cmpt`) → `Private`.
- `RlCli_Click` reste `Public` (rejeu dynamique) ; les autres handlers aussi.

### Séparation traitement / GUI

- `Button1_Click` → `RemplitReleve(d0, d1)` (SQL seul) ; le handler garde la validation des dates, le
  curseur, les messages et `MajTab`.
- `Button2_Click` → `MentionsSociete()` + `ImprimeReleve(lignes, txt, filename)` ; le handler lit
  `RlCli` et `RB2`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une requête d'agrégat (`GROUP BY code_ligfac, cdclifac` sur l'union des lignes factures/BL avec
  jointure des en-têtes et filtre de date en SQL) remplacerait la table `Fiches_Stat` et les milliers
  de requêtes unitaires.
- `qte`/`montant` stockés en `char(12)` dans `Fiches_Stat` : types numériques.
- Tables de travail distinctes (ou temporaires) par écran pour supprimer la collision sur `Fiches_Stat`.
