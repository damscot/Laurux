# Facturefm — Architecture

> Source : `.src/Gestion/Facturation/Facturefm.class`

## Vue d'ensemble

`Facturefm` est l'écran de **facturation de fin de mois** (menu Gestion › Facturation › Factures
fin de mois, `Fmenu.Menu138` et le libellé `lblFacfm`). Il sélectionne les BL non facturés
(`type = "B"`, ou `"F"` non imprimés) jusqu'à une date, éventuellement sur une période de
regroupement (décade, quinzaine, mois), pour tous les clients ou un seul, avec des filtres
(tournée, type de client, commercial, clients divers, type de facture « Boissons »/« Autres »,
documents d'entretien `Fiches_BlM`). Il remplit deux **tables de travail** :

- `Facturefm` (un enregistrement par client, ou par client + nom pour les clients divers :
  `code, nom, cp, adr1, adr2, ville, totf, tottc, gestbl`) ;
- `Bl` (un enregistrement par BL retenu : `num, code, nom, date, ht, ttc`) ;

les affiche dans `Colbl` (clients) et `Coldetail` (BL du client), permet d'en retirer
(touche Suppr), puis lance l'édition par `OptFac` en mode `ObjFac.finmois`
([OptFac](../OptFac.class/architecture.md) → `ObjFacB.editefm`, qui relit `Facturefm` et, via
`ObjFac.calcul`, la table `Bl`).

Nature globale : **mixte** : SQL de sélection et d'agrégation entremêlé avec l'affichage.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 27 |
| `b` | var | Private |  | Integer | 28 |
| `rResult` | var | Private |  | Result | 31 |
| `CblRslt` | var | Private |  | Result | 32 |
| `numbl` | var | Private |  | Result | 33 |
| `Nfac` | var | Private |  | String | 34 |
| `Jnl` | var | Private |  | String | 35 |
| `cpt` | var | Private |  | String | 36 |
| `Intit` | var | Private |  | String | 37 |
| `numecr` | var | Private |  | String | 38 |
| `numr` | var | Private |  | Integer | 39 |
| `numrd` | var | Private |  | Integer | 40 |
| `numr2` | var | Private |  | Integer | 41 |
| `cptRem` | var | Private |  | String | 42 |
| `Ctva` | var | Private |  | String | 43 |
| `Ctx` | var | Private |  | String | 44 |
| `cpttva` | var | Private |  | String | 45 |
| `IntitTva` | var | Private |  | String | 46 |
| `Txtleg` | var | Private |  | String | 47 |
| `Txtleg2` | var | Private |  | String | 48 |
| `numeroFac` | var | Private |  | String | 49 |
| `Remmo` | var | Private |  | String | 50 |
| `Remart` | var | Private |  | String | 51 |
| `Mgart` | var | Private |  | String | 52 |
| `Mgmo` | var | Private |  | String | 53 |
| `Ttva` | var | Private |  | Float | 54 |
| `dateech` | var | Private |  | String | 55 |
| `Filename` | var | Private |  | String | 56 |
| `jour` | var | Private |  | String | 57 |
| `Nbl` | var | Private |  | Integer | 58 |
| `Nlgn` | var | Private |  | String | 59 |
| `Totalmo` | var | Private |  | String | 60 |
| `Totalart` | var | Private |  | String | 61 |
| `Totalrem` | var | Private |  | String | 62 |
| `totalht` | var | Private |  | String | 63 |
| `Totht` | var | Private |  | String | 64 |
| `typeL` | var | Private |  | String | 65 |
| `Fam` | var | Private |  | String | 66 |
| `Ardi` | var | Private |  | String | 67 |
| `nbdec` | var | Private |  | String | 68 |
| `Totttc` | var | Private |  | String | 69 |
| `Brutht` | var | Private |  | String | 70 |
| `Rem` | var | Private |  | String | 71 |
| `TotEuros` | var | Private |  | String | 72 |
| `nom` | var | Private |  | String | 73 |
| `Mttc` | var | Private |  | String | 74 |
| `adr211` | var | Private |  | String | 75 |
| `adr222` | var | Private |  | String | 76 |
| `numbonl` | var | Private |  | String | 77 |
| `intituleb` | var | Private |  | String | 78 |
| `Bonl` | var | Private |  | Result | 79 |
| `dte` | var | Private |  | String | 80 |
| `Devises` | var | Private |  | String | 81 |
| `PosY` | var | Private |  | Integer | 82 |
| `Visudoc` | var | Private |  | Boolean | 83 |
| `Coulfond` | var | Private |  | New String[] | 84 |
| `ty` | var | Private |  | String | 85 |
| `scourriel` | var | Private |  | String | 86 |
| `spiece` | var | Private |  | String | 87 |
| `sclient` | var | Private |  | String | 88 |
| `nmclient` | var | Private |  | String | 89 |
| `sclient2` | var | Private |  | String | 90 |
| `Bsel` | var | Public |  | Boolean | 91 |
| `Bval` | var | Public |  | String | 92 |
| `Cclient` | var | Public |  | String | 93 |
| `Ccli` | var | Private |  | String | 94 |
| `dateech2` | var | Private |  | String | 95 |
| `pdf` | var | Private |  | Object | 96 |
| `Rs2` | var | Private |  | String | 97 |
| `Vic` | var | Private |  | String | 98 |
| `Vichq` | var | Private |  | String | 99 |
| `Viautre` | var | Private |  | String | 100 |
| `Cptreglt` | var | Private |  | String | 101 |
| `Reglmt` | var | Private |  | String | 102 |
| `Prxdec` | var | Private |  | Boolean | 103 |
| `Codecli` | var | Private |  | String | 104 |
| `NomCli` | var | Private |  | String | 105 |
| `adr1` | var | Private |  | String | 106 |
| `adr2` | var | Private |  | String | 107 |
| `cpcli` | var | Private |  | String | 108 |
| `villecli` | var | Private |  | String | 109 |
| `bnumfac` | var | Private |  | Boolean | 110 |
| `Liste` | var | Private |  | Boolean | 111 |
| `$soption` | var | Private |  | String | 112 |
| `$sreq` | var | Private |  | String | 113 |
| `$obs` | var | Private |  | Observer | 114 |
| `frais` | var | Private |  | String | 115 |
| `$bl` | var | Private |  | String | 116 |
| `$process` | var | Private |  | Boolean | 117 |
| `$ligbl` | var | Private |  | String | 118 |
<!-- /AUTO:declarations -->

**≈ 60 variables d'instance sont mortes** (déclarées, jamais utilisées : `son`, `CblRslt`,
`numbl`, `Nfac`, `Jnl`, `cpt`, `Intit`, `numecr`, `numr`, `numrd`, `numr2`, `cptRem`, `Ctva`,
`Ctx`, `cpttva`, `IntitTva`, `Txtleg`, `Txtleg2`, `numeroFac`, `Remmo`, `Remart`, `Mgart`, `Mgmo`,
`Ttva`, `dateech`, `jour`, `Nbl`, `Nlgn`, `Totalmo`, `Totalart`, `Totalrem`, `totalht`, `Totht`,
`typeL`, `Fam`, `Ardi`, `nbdec`, `Totttc`, `Brutht`, `Rem`, `TotEuros`, `nom`, `Mttc`, `adr211`,
`adr222`, `numbonl`, `intituleb`, `Bonl`, `dte`, `PosY`, `Visudoc`, `ty`, `scourriel`, `spiece`,
`Cclient`, `Ccli`, `dateech2`, `pdf`, `Rs2`, `Vic`, `Vichq`, `Viautre`, `Cptreglt`, `Reglmt`,
`Prxdec`, `bnumfac`, `Liste`, `frais`) ; `Devises` et `Coulfond` sont écrites mais jamais lues ;
`Filename` n'est jamais affectée et `$process` n'est jamais mise à `True`. C'est un héritage de
l'ancienne facturation directe, aujourd'hui confiée à `ObjFacB`. `Bsel`/`Bval` sont positionnées
par `TriCpt` (`Object.SetProperty`) : elles doivent rester `Public`.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 123-212 | Public | 10 | 80 | 0 | méthode spéciale |
| `Form_Close` | 214-224 | Public | 5 | 9 | 0 | handler GUI |
| `recup_bl` | 228-370 | Public | 29 | 138 | 0 | portée réductible ? |
| `totfrais` | 372-382 | Private | 2 | 8 | 0 |  |
| `Colbl_Click` | 384-417 | Public | 6 | 31 | 0 | handler GUI |
| `Colbl_Keypress` | 419-426 | Public | 3 | 6 | 0 | handler GUI |
| `supclient` | 428-442 | Public | 2 | 12 | 0 | portée réductible ? |
| `affclient` | 444-467 | Public | 4 | 21 | 0 | portée réductible ? |
| `Coldetail_Click` | 469-473 | Public | 1 | 3 | 0 | handler GUI |
| `Coldetail_Activate` | 475-482 | Public | 1 | 5 | 0 | handler GUI |
| `Coldetail_Keypress` | 484-526 | Public | 8 | 38 | 0 | handler GUI |
| `Quittedate` | 532-543 | Public | 2 | 9 | 0 | portée réductible ? |
| `Button1_KeyPress` | 545-549 | Public | 1 | 3 | 0 | handler GUI |
| `Button1_Click` | 551-565 | Public | 5 | 13 | 0 | handler GUI |
| `requete` | 567-611 | Public | 23 | 38 | 0 | portée réductible ? |
| `Button5_Click` | 613-618 | Public | 1 | 3 | 0 | handler GUI |
| `Radiobutton1_Click` | 620-628 | Public | 1 | 6 | 0 | handler GUI |
| `Radiobutton2_Click` | 630-641 | Public | 2 | 9 | 0 | handler GUI |
| `codeclient_KeyPress` | 643-656 | Public | 5 | 12 | 0 | handler GUI |
| `Togglebutton1_Click` | 658-673 | Public | 3 | 12 | 0 | handler GUI |
| `dte_LostFocus` | 675-686 | Public | 5 | 10 | 0 | handler GUI |
| `dte_DblClick` | 688-700 | Public | 3 | 11 | 0 | handler GUI |
| `DateChooser1_Activate` | 702-707 | Public | 1 | 4 | 0 | handler GUI |
| `dte_KeyPress` | 709-726 | Public | 6 | 16 | 0 | handler GUI |
| `Divers_Click` | 728-732 | Public | 1 | 3 | 0 | handler GUI |
| `Checentr_Click` | 734-744 | Public | 2 | 9 | 0 | handler GUI |
| `Buttour_Click` | 746-753 | Public | 1 | 5 | 0 | handler GUI |
| `tourne_trouve` | 755-759 | Public | 1 | 3 | 0 | handler GUI |
| `combregr_Click` | 761-774 | Public | 2 | 12 | 0 | handler GUI |
| `Button9_Click` | 776-788 | Public | 3 | 10 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation et fermeture

- **`_New()`** [portée : nécessaire (constructeur)] [nature : mixte]. Lit la devise
  (`Fiches_Parametres`, inutilisée), enregistre les observateurs de rejeu
  (`Utils.Observers(Me)`), configure les colonnes de `Colbl`/`Coldetail`, propose le dernier jour
  du mois courant dans `datej`, affiche le panneau de filtres boissons (`Panel2`) si
  `Utils.Option()` vaut `B` ou `T`, remplit les listes de regroupement, de types de client
  (`Fiches_Typec`), de commerciaux (`Fiches_Commerciaux`) et de types de facture, et crée deux
  observateurs `dte` sur `datej`/`datei`.
- **`Form_Close()`** [handler] [GUI]. Demande confirmation si `$process`, qui n'est jamais vrai :
  **corps mort** en pratique.

### Sélection des BL

- **`Button1_Click()`** [handler] [mixte]. Vide les listes, contrôle la date de fin (et de début
  si modifiable) par `Quittedate`, puis `requete` et `recup_bl`. `Button1_KeyPress` le rappelle.
- **`Quittedate(datej)`** [portée : réductible] [mixte]. `VerifDate(datej.Text).ClotFac()` ;
  positionne le drapeau `b` (1 = refus). Le paramètre masque le contrôle homonyme.
- **`requete()`** [portée : réductible] [mixte] (CC 23). Construit `$sreq` (fragment SQL
  paramétré par `Utils.db.Subst`) : `datebl <= fin` et `cli_regr = 'S'` sans regroupement, sinon
  `datebl BETWEEN début AND fin` et `cli_regr = 'D'|'Q'|'M'` ; vérifie la cohérence des bornes avec
  la périodicité (1/11/21, 1/16, 1 ; 10/20/dernier jour…) et affiche un message en cas
  d'incohérence **sans interrompre le traitement** (FACTUREFM-A01) ; ajoute les filtres tournée
  (`cli_tour`), type client (`cli_typec`) et commercial (`cli_comm`).
- **`recup_bl()`** [portée : réductible] [nature : mixte] (CC 29). `DROP`/`CREATE` des tables de
  travail `Facturefm` et `Bl` (FACTUREFM-A02). Sélection :
  - tous les clients : `Fiches_Bl[M]` ⨝ `Fiches_Cli` sur `type B/F`, `totalht <> 0`,
    `cli_div = Divers`, `imp <> 1` + `$sreq` ;
  - un client (`codeclient`) : même table, `datebl <= fin`, `imp <> 1` pour les seuls `F`, **sans**
    les filtres de `$sreq` (regroupement, tournée, type, commercial).
  Pour chaque BL : cumule `totf`/`tottc` du client dans `Facturefm` (insertion ou `UPDATE`), ne
  compte les frais de gestion (`gestbl`) que pour le premier BL du client (les suivants sont
  retranchés, TTC via `totfrais`), et insère le BL dans `Bl` s'il a au moins une ligne. Affiche
  `Facturefm` trié par nom dans `Colbl`, puis, si un type de facture est choisi, retire les
  clients dont l'orientation (`Utils.orientation(code, "FM")`, paysage = boissons) ne correspond
  pas (`supclient`, `affclient`). Partie extractible : tout le SQL ; la GUI se limite au
  remplissage de `Colbl`.
- **`totfrais(frs)`** [Private] [calcul]. Frais TTC = `frs × (1 + taux/100)` avec le taux de
  `tvafrais` (`Fiches_Parametres` ⨝ `Fiches_Tvaav`) ; renvoie 0 implicite si non trouvé.

### Listes et retraits

- **`Colbl_Click()`** [handler, rejeu dynamique] [mixte]. Affiche dans `Coldetail` les BL du
  client (`Bl`, filtré par `nom` pour les divers) ; passe des arguments inutiles à `Exec`.
- **`Colbl_Keypress()`** [handler] [mixte]. Suppr → `supclient` puis `affclient`.
- **`supclient(sclient, nmclient)`** [portée : réductible] [calcul]. `DELETE` du client dans
  `Facturefm` et `Bl` (par code, ou code + nom).
- **`affclient()`** [portée : réductible] [GUI + SQL]. Réaffiche `Facturefm` (table en dur).
- **`Coldetail_Click()`** [handler, rejeu dynamique] [GUI]. Mémorise le BL courant.
- **`Coldetail_Activate()`** [handler] [GUI]. Ouvre le BL en consultation (`AFacture`).
- **`Coldetail_Keypress()`** [handler] [mixte]. Suppr → `DELETE` du BL dans `Bl` ; réaffiche le
  détail et recalcule les totaux affichés du client (la table `Facturefm` n'est pas mise à jour,
  sans conséquence : `ObjFac.calcul` recalcule à partir de `Bl`).

### Filtres et saisie

- **`Radiobutton1_Click`** / **`Radiobutton2_Click`** [handlers] [GUI]. Mode tous / un client
  (couleur `/Coul/Znss` si `/Coul_fen`).
- **`codeclient_KeyPress()`** [handler] [mixte]. Contrôle l'existence du client (`TabCli`).
- **`Togglebutton1_Click()`** [handler] [GUI]. Recherche de client par `TriCpt` (retour par
  `Bsel`/`Bval`).
- **`dte_LostFocus`**, **`dte_DblClick`**, **`dte_KeyPress`**, **`DateChooser1_Activate`**
  [handlers du groupe d'observateurs `dte`] [GUI]. Normalisation et sélecteur de date (motif
  répandu dans ≈ 12 écrans).
- **`Divers_Click()`** → `Button1_Click`. **`Checentr_Click()`** : bascule `Fiches_Bl`/`Fiches_Ligbl`
  ↔ `Fiches_BlM`/`Fiches_LigblM`. **`Buttour_Click()`** / **`tourne_trouve(value)`** : choix de
  tournée (`Rechtour`). **`combregr_Click()`** : active la date de début selon la périodicité.
- **`Button5_Click()`** : ferme. **`Button9_Click()`** [handler] [GUI] : si des clients sont
  listés, `New OptFac(ObjFac.finmois, "", "M"|"", Me.Parent, " ", False, LDate(datej.Text))`
  puis relance la sélection.

## État global utilisé

- `Start.LocalSettings` (`/Soc<XX>/Prxdec` dans un initialiseur mort, `/Coul/Znss`,
  `/Soc<XX>/Coul_fen`), `Start.Son`, `Start.Musique`.
- `Utils.db`, `Utils.Option`, `Utils.Coulfd`, `Utils.Observers`, `Utils.FColr`,
  `Utils.orientation`, `Utils.lastday`, `Utils.totobs`, `Utils.cpoint`, `Utils.Cdate_*`,
  `Cbase.Table("TabCli")`.
- Tables : `Fiches_Bl[M]`, `Fiches_Ligbl[M]`, `Fiches_Cli`, `Fiches_Parametres`,
  `Fiches_Tvaav`, `Fiches_Typec`, `Fiches_Commerciaux` ; tables de travail `Facturefm` et `Bl`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les ≈ 60 variables mortes, `Form_Close` réduit à rien (`$process` jamais vrai :
  le handler peut rester vide pour garder son nom) et l'initialiseur `Prxdec`.
- `recup_bl` : extraire `CreeTablesTravail()`, `SelectionBl() As Result` et
  `CumulClient(…)` ; la requête « un client » et la requête « tous » pourraient partager le même
  gabarit (attention : filtres différents aujourd'hui).
- Constantes privées `TAB_TRAVAIL = "Facturefm"` et `TAB_BL = "Bl"` à la place des variables
  locales `Tab3`/`Tab4` répétées dans 5 fonctions.

### Commonalisation avec d'autres fichiers

- [`FacturefmA`](../FacturefmA.class/architecture.md) et
  [`Facturergbl`](../Facturergbl.class/architecture.md) sont des copies de cet écran (mêmes
  colonnes, mêmes handlers `Colbl_*`/`Coldetail_*`, `Radiobutton*`, `codeclient_KeyPress`,
  `Togglebutton1_Click`, `DateChooser1_Activate`) : une classe de base commune (ou un module
  `FinMois`) pour la création des tables de travail, le remplissage des listes et les retraits.
- Les tables de travail `Facturefm`/`Bl` sont aussi créées par `SaiReg.Facture` (même
  structure), `FacturefmA` et `Facturergbl` (structures différentes), `Visimpayes` et
  `Visreglements` (`Facturefm` avec une autre structure) : un helper unique
  `TablesTravail.FinMois()` garantirait la structure attendue par `ObjFac`/`ObjFacB`.
- Gestion du sélecteur de date (`dte_*`, `DateChooser1_Activate`) : motif commun à ≈ 12 écrans
  (saisie de période, voir notes transverses).

### Réduction de portée

- `recup_bl`, `supclient`, `affclient`, `Quittedate`, `requete` → `Private` (aucun appel
  externe, vérifié par `grep`) ; `Cclient` → suppression (jamais utilisée).
- `Bsel`, `Bval` restent `Public` (écrites par `TriCpt` via `Object.SetProperty`).
- `Colbl_Click` et `Coldetail_Click` restent `Public` (rejeu dynamique, REPLAYOBSERVER-A06).

### Séparation traitement / GUI

- `recup_bl` : la sélection et l'agrégation dans `Facturefm`/`Bl` deviennent une fonction sans
  contrôle (paramètres : date, mode, client, divers, `$sreq`, tables `$bl`/`$ligbl`) ; le handler
  garde le remplissage de `Colbl` et le filtre d'orientation.
- `requete` : construire `$sreq` à partir de valeurs passées en paramètre ; les messages
  d'incohérence restent dans le handler.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer les tables de travail partagées `Facturefm`/`Bl` par des tables temporaires de
  session ou par une table de sélection avec un identifiant de poste : supprime les collisions
  multi-postes et les conflits de structure avec `Visimpayes`/`Visreglements`.
- Index sur `Fiches_Bl(cdclibl, type, imp, datebl)` pour la sélection (à mesurer).
