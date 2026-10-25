# RelMoprod — Architecture

> Source : `.src/Statistiques/RelMoprod.class`

## Vue d'ensemble

`RelMoprod` présente l'**historique des ventes de main-d'oeuvre et d'articles par client** (ou par
produit) sur une période (menu `Fmenu.class:1829`, `RelMoprod.Show()` sur l'auto-instance). Le bouton
**Traitement** (`Button1`) remplit la table de travail `Fiches_Stat` à partir des factures en cours
(`Fiches_Bl` type `F` imprimées) et des factures historisées (normales et matériel), pour tous les
clients (`RB1`) ou pour un client choisi (`RB2` + zone `Code` + grille de recherche `Colcli`). Le
résultat s'affiche dans l'arbre `Rlcli` (`TreeView`) organisé par client puis MO/articles (`RB3`) ou par
MO/article puis client (`RB4`). Un clic sur une ligne de facture affiche le détail de la facture
(`Panel3`, `Colrcp3`). **Imprimer** (`Button4`) produit `~/tmp/HistoMoArt.pdf` (`Cdocuments`).

Nature globale : **mixte**. L'écran appelle `Utils.Observers(Me)` **deux fois** dans `Form_Open`
(lignes 50 et 55).

### Table de travail `Fiches_Stat` (hors `db_control.csv`)

`DROP TABLE if exists Fiches_Stat` puis `CREATE TABLE Fiches_Stat (code Char(15) NOT NULL, intitule
char(50), qte char(12), type char(1), montant char(12), codecli char(12), intitulecli char(35), numfac
char(10), qtefac char(6), nethtfac char(10), PRIMARY KEY (code, codecli, numfac))` (`Cbase.Table
("TabStat")`). Structure différente de celle de [`RelvMo`](../RelvMo.class/architecture.md) et de
[`TriHistos`](../../Affichages/TriHistos.class/architecture.md), qui recréent la même table. `qte`,
`montant` et `intitulecli` ne sont jamais renseignés ici. `qtefac char(6)` et `nethtfac char(10)`
reçoivent les valeurs textuelles des lignes (troncature possible en MySQL non strict, erreur en mode
strict : à confirmer).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `dte` | var | Private |  | String | 27 |
| `dte1` | var | Private |  | String | 28 |
| `dte2` | var | Private |  | String | 29 |
| `jour` | var | Private |  | String | 30 |
| `son` | var | Private |  | Integer | 31 |
| `Clitable` | var | Private |  | New String[9] | 32 |
| `Coulfond` | var | Private |  | New String[] | 33 |
| `PosY` | var | Private |  | Integer | 34 |
| `Stats` | var | Private |  | Collection | 35 |
| `Tri` | var | Private |  | String | 36 |
| `Sens` | var | Private |  | String | 37 |
| `sel` | var | Private |  | String | 38 |
| `Dbl` | var | Private |  | String | 39 |
| `CoulB` | var | Private |  | Integer | 40 |
| `CoulF` | var | Private |  | Integer | 41 |
| `pdf` | var | Private |  | Cdocuments | 42 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Form_Open` | 44-59 | Public | 1 | 13 | 0 | handler GUI |
| `Cmpt_GotFocus` | 61-67 | Public | 1 | 5 | 0 | handler GUI |
| `Ex1` | 72-88 | Public | 1 | 14 | 0 | portée réductible ? |
| `Cmpt_KeyPress` | 90-113 | Public | 8 | 18 | 0 | handler GUI |
| `dteN0_GotFocus` | 115-120 | Public | 1 | 4 | 0 | portée réductible ? |
| `dteN0_LostFocus` | 122-136 | Public | 3 | 13 | 0 | portée réductible ? |
| `dteN1_GotFocus` | 138-142 | Public | 1 | 3 | 0 | portée réductible ? |
| `dteN1_LostFocus` | 144-158 | Public | 3 | 13 | 0 | portée réductible ? |
| `Button1_Click` | 160-259 | Public | 26 | 96 | 0 | handler GUI |
| `MajTab` | 261-329 | Public | 30 | 66 | 0 | portée réductible ? |
| `Button4_Click` | 331-476 | Public | 22 | 143 | 0 | handler GUI |
| `Controle` | 478-491 | Public | 3 | 12 | 0 | portée réductible ? |
| `RB1_Click` | 493-502 | Public | 1 | 8 | 0 | handler GUI |
| `RB2_Click` | 504-512 | Public | 1 | 7 | 0 | handler GUI |
| `RB3_Click` | 514-518 | Public | 1 | 3 | 0 | handler GUI |
| `RB4_Click` | 520-524 | Public | 1 | 3 | 0 | handler GUI |
| `Rlcli_click` | 529-646 | Public | 24 | 115 | 0 | handler GUI |
| `Button2_Click` | 648-653 | Public | 1 | 4 | 0 | handler GUI |
| `ToggleButton3_click` | 659-673 | Public | 2 | 13 | 0 | handler GUI |
| `Tris` | 675-693 | Public | 1 | 17 | 0 | portée réductible ? |
| `compteMan` | 698-710 | Public | 4 | 10 | 0 | portée réductible ? |
| `Colcli_Data` | 715-748 | Public | 5 | 31 | 0 | handler GUI |
| `compteTiers` | 753-760 | Public | 1 | 6 | 0 | portée réductible ? |
| `ColCli_Click` | 765-778 | Public | 3 | 11 | 0 | handler GUI |
| `ColCli_KeyPress` | 783-805 | Public | 7 | 19 | 0 | handler GUI |
| `Deb3` | 807-811 | Public | 1 | 3 | 0 | portée réductible ? |
| `Deb4` | 813-817 | Public | 1 | 3 | 0 | portée réductible ? |
| `Dbclk` | 819-829 | Public | 2 | 9 | 0 | portée réductible ? |
| `C1_Click` | 831-842 | Public | 1 | 10 | 0 | handler GUI |
| `C1_Dblclick` | 844-848 | Public | 1 | 3 | 0 | handler GUI |
| `N1_Click` | 850-861 | Public | 1 | 10 | 0 | handler GUI |
| `N1_Dblclick` | 863-867 | Public | 1 | 3 | 0 | handler GUI |
| `Cp1_Click` | 869-880 | Public | 1 | 10 | 0 | handler GUI |
| `Cp1_Dblclick` | 882-886 | Public | 1 | 3 | 0 | handler GUI |
| `V1_Click` | 888-899 | Public | 1 | 10 | 0 | handler GUI |
| `V1_Dblclick` | 901-905 | Public | 1 | 3 | 0 | handler GUI |
| `C1_KeyPress` | 907-911 | Public | 1 | 3 | 0 | handler GUI |
| `N1_KeyPress` | 913-917 | Public | 1 | 3 | 0 | handler GUI |
| `A1_KeyPress` | 919-923 | Public | 1 | 3 | 0 | portée réductible ? |
| `Cp1_KeyPress` | 925-929 | Public | 1 | 3 | 0 | handler GUI |
| `V1_KeyPress` | 931-935 | Public | 1 | 3 | 0 | handler GUI |
| `C1_GotFocus` | 937-942 | Public | 2 | 4 | 0 | handler GUI |
| `C1_LostFocus` | 944-948 | Public | 2 | 3 | 0 | handler GUI |
| `N1_GotFocus` | 950-955 | Public | 2 | 4 | 0 | handler GUI |
| `N1_LostFocus` | 957-961 | Public | 2 | 3 | 0 | handler GUI |
| `cp1_GotFocus` | 963-968 | Public | 2 | 4 | 0 | handler GUI |
| `cp1_LostFocus` | 970-974 | Public | 2 | 3 | 0 | handler GUI |
| `V1_GotFocus` | 976-981 | Public | 2 | 4 | 0 | handler GUI |
| `V1_LostFocus` | 983-987 | Public | 2 | 3 | 0 | handler GUI |
| `ChkInput` | 989-998 | Public | 2 | 8 | 0 | portée réductible ? |
| `Button3_Click` | 1000-1004 | Public | 1 | 3 | 0 | handler GUI |
| `Button7_Click` | 1006-1010 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Ouverture et dates

- **`Form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. `Coulfond`, `Frmt` (inutilisés),
  `Utils.Observers(Me)` **deux fois**, son, `Ex1()`, focus sur `dteN0`.
- **`Ex1()`** [portée : réductible] [nature : mixte]. Identique à `RelvMo.Ex1` : `SELECT * FROM
  Fiches_Parametres` (en dur, sans `Available`), `dteN0 = Calc_mois(dteclec1)`, `dteN1` = aujourd'hui ;
  `dte`, `dte1`, `dte2` jamais relus.
- **`Cmpt_GotFocus()`** / **`Cmpt_KeyPress()`** [portée : nécessaire (handlers du groupe `Cmpt`)]
  [nature : GUI]. `SetEditColor` ; Entrée sur `DteN0`/`Dten1` → `dteN*_LostFocus` ; F1 → aide. La zone
  `Code` (tag 3) n'a **aucun** traitement : un code client saisi à la main n'est pas contrôlé.
- **`dteN0_GotFocus` / `dteN0_LostFocus` / `dteN1_GotFocus` / `dteN1_LostFocus`** [portée : réductible]
  [nature : GUI]. Méthodes ordinaires (zones du groupe `Cmpt`, non levées) : couleur de fond,
  normalisation de la date, bascule du focus.

### Traitement

- **`Button1_Click()`** (CC 26) [portée : nécessaire (handler)] [nature : mixte]. `Message.Info`
  « Soyez patient », recrée `Fiches_Stat`, puis trois passes :
  1. `SELECT * from Fiches_Bl where datebl >= &1 and datebl <= &2 and type = 'F' and imp = 1 [and
     cdclibl = Code] order by cdclibl` (filtre sur **`datebl`**, pas `dtefac` ; borne de fin
     `aaaammjj` sur un `datetime`) ; pour chaque document, lignes `Fiches_Ligbl` de type `M` ou `A`
     (`num_ligbl = &1 and typel = 'M' or num_ligbl = &1 and typel = 'A'`, correctement parenthésé par
     la répétition) ; pour chaque ligne, `SELECT` dans `Fiches_Stat` sur (code, client, numfac) et
     `INSERT` **seulement si absent** : une deuxième ligne du même code dans la même facture est
     ignorée ;
  2. idem `Fiches_HistoFac` (`datefac`) / `Fiches_HistoLigfac` ;
  3. idem `Fiches_HistoFacM` / `Fiches_HistoLigfacM`.
  Puis `MajTab()` ou « Il n'y a aucune donnée pour ce client ». Les lignes `Fiches_LigblM` ne sont pas
  lues. Un `Catch` **vide** termine la méthode : toute erreur est avalée (curseur laissé en attente).
  Partie extractible : les trois passes (`RemplitStat(d0, d1, sClient)`).
- **`MajTab()`** (CC 30) [portée : réductible] [nature : GUI]. Remplit `Rlcli` depuis `Fiches_Stat` :
  - `RB4` : deux racines `MO` / `ART` ;
  - pour **chaque ligne** de `Fiches_Stat` (et non pour chaque client) : lecture de `Fiches_Cli`
    (`Intcli`, sans test `Available`), requête de toutes les lignes du client, puis, pour chacune,
    **parcours complet de l'arbre** (`Rlcli.MoveFirst … MoveNext`) ; les ajouts se font par
    `Try Rlcli.Add(…)` dont les doublons échouent en silence. Complexité cubique en nombre de lignes ;
  - nœuds : client → « Main d'oeuvre »/« Articles » (icônes `Icones/Mo.png`, `Icones/Article.png`) →
    code (libellé paddé par `String$`) → « Facture numéro … Qté = … Pv net HT … » (`RB3`) ; ou MO/ART →
    code → client → facture (`RB4`). Clé des feuilles : `codecli & ";" & code & numfac`.
  Le membre `Stats` est recréé sans être utilisé ; un `Catch` vide termine la méthode.
- **`RB1_Click()` / `RB2_Click()`** [portée : nécessaire (handlers)] [nature : GUI]. Masquent ou
  affichent la saisie du client ; `RB2` ouvre directement la grille de recherche.
- **`RB3_Click()` / `RB4_Click()`** [portée : nécessaire (handlers)] [nature : GUI]. Vident l'arbre (il
  faut relancer le traitement).

### Détail d'une facture

- **`Rlcli_click()`** (CC 24) [portée : nécessaire (handler de `TreeView`)] [nature : mixte]. À partir de
  la clé du nœud courant : client = texte avant `;` (si la clé n'a pas de `;`, `Left$(clé, -1)` et les
  lectures suivantes échouent, erreur avalée par le `Catch` vide), `numfac = Right$(clé, 10)` (suppose
  un numéro de 10 caractères : à confirmer). Lit le client, la date de facture (`Fiches_HistoFac` union
  `…M`), les lignes (`Fiches_HistoLigfac` union `…M`) et remplit `Colrcp3` (ligne, code, désignation,
  qté, brut, remise, net) avec le total `netht * qte` ; si la facture n'est pas historisée, la cherche
  dans `Fiches_Bl` (`numfac`) puis lit `Fiches_Ligbl`. Branche historisée : le résultat de `Utils.CDec`
  (quantité formatée selon `art_dec`) est écrit dans la colonne **2** puis écrasé par le libellé ; la
  branche BL l'écrit bien dans la colonne 3. Les commentaires (`typel = 'C'`) sont éclatés par ligne.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme le détail.

### Impression

- **`Button4_Click()`** (CC 22) [portée : nécessaire (handler)] [nature : mixte]. `New Cdocuments`, puis :
  - `RB3` (par client) : `EnteteN`, pour chaque client distinct (rupture sur `Nom`) : `Lines`,
    `level2RL` (client, `cli_nom` sans test `Available`), puis ses lignes triées par type : en-têtes
    « Main d'oeuvre »/« Articles », `Level2RL` par ligne ; saut de page à 273 (`Baspage`, `EnteteN`,
    `Lines`) seulement dans la boucle des lignes ;
  - `RB4` (par produit) : `Baspage` **avant** le premier `EnteteN`, rupture sur `type` (Articles puis
    MO avec nouvel `EnteteN`), sur `code` (`Level4RL`), une requête `Fiches_Stat` et une requête
    `Fiches_Cli` par ligne, saut de page par `Controle()` (sans `Baspage`, `PosY = 30`).
  Puis `Footer`, `Output(~/tmp/HistoMoArt.pdf)`, `Visualiseur.Prog`. Si l'arbre est vide :
  « Veuillez lancer le traitement avant l'impression SVP ! ». Variables `tri3`, `b2`… partiellement
  inutiles ; `Shell "cd ~"` sans effet.
- **`Controle()`** [portée : réductible] [nature : GUI]. Saut de page de l'impression `RB4`.

### Recherche de client (grille `Colcli`)

- **`ToggleButton3_click()`** [portée : nécessaire (handler)] [nature : GUI]. Bascule la grille, tri
  initial `cli_nom Asc` (`compteTiers`).
- **`Tris()`** [portée : réductible] [nature : GUI]. Colonnes de `Colcli` alignées sur les en-têtes
  `C1`, `N1`, `Cp1`, `V1`.
- **`compteTiers(tri, sens)`** [portée : réductible] [nature : mixte]. `Utils.Base2(colcli, "select * from
  Fiches_Cli order by <tri> <sens>")` (résultat global `Utils.rs2`).
- **`Colcli_Data(Row, Column)`** [portée : nécessaire (handler)] [nature : GUI]. Lit `Utils.rs2` à la
  ligne demandée, couleurs alternées (`/Coul/Fnets`, `/Coul/Znaff`, `/Soc<XX>/Coul_fen`) recalculées à
  chaque cellule.
- **`ColCli_Click()`** [portée : nécessaire (handler, rejeu dynamique)] [nature : mixte]. Lit le client
  de la ligne courante, remplit `Code`/`Int`, ferme la grille. Appelé par `ReplayObserver.Replay_Click`
  via `Object.Call` : doit rester `Public`.
- **`ColCli_KeyPress()`** [portée : nécessaire (handler)] [nature : GUI]. F1, Entrée, Échap/F2.
- **`Deb3()` / `Deb4()` / `Dbclk()`** [portée : réductible] [nature : mixte]. Filtre `where <tri> like
  "%<sel>%"` construit **par concaténation** (guillemets doubles), tri ascendant/descendant alterné par
  double-clic.
- **`C1_*`, `N1_*`, `Cp1_*`, `V1_*`** (`Click`, `Dblclick`, `KeyPress`, `GotFocus`, `LostFocus`)
  [portée : nécessaire (handlers)] [nature : GUI]. En-têtes de recherche : choix de la colonne de tri,
  saisie du filtre (`ChkInput`), instrumentation `Utils.ObsGotf`/`ObsLstf` (rejeu). Un `TextBox` n'a pas
  d'événement `Click` : `C1_Click` etc. ne sont atteints que par les appels de `*_GotFocus` (à confirmer
  pour `Dblclick`).
- **`A1_KeyPress()`** [portée : réductible] — **code mort** : aucun contrôle `A1` dans le `.form`.
- **`ChkInput()`** [portée : réductible] [nature : GUI]. Refuse les touches `"`, `&`, `'` ; sinon
  `sel = Utils.Obstch(sel)` et `Deb3()`. Un collage n'est pas filtré.
- **`compteMan()`** [portée : réductible] — **code mort** : jamais appelée (la zone `Code` n'a pas de
  traitement de saisie).

### Divers

- **`Button3_Click()`** : `Me.Close`. **`Button7_Click()`** : `Doc.Open("RelMo")`.

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.Societe`, `Start.LocalSettings["/Coul/Fnets" | "/Coul/Znaff" |
  "/Soc<XX>/Coul_fen"]`.
- `Utils.Observers`, `Utils.ObsGotf`, `Utils.ObsLstf`, `Utils.Obstch`, `Utils.Base2`, `Utils.rs2`
  (résultat global partagé), `Utils.SetEditColor`, `Utils.Calc_mois`, `Utils.Cdate_*`, `Utils.CDec`,
  `Utils.Coulfd`, `Utils.FColr`, `Utils.db`.
- `Cbase.Table("TabStat" | "TabBl" | "TabLigbl" | "TabHisFac" | "TabHisLigFac" | "TabHisFacm" |
  "TabHisLigFacm" | "TabCli" | "TabArt")`.
- Table de travail partagée `Fiches_Stat`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer `compteMan`, `A1_KeyPress`, `Stats`, `Coulfond`, `Frmt`, `dte`/`dte1`/`dte2`, le second
  `Utils.Observers(Me)` (voir anomalie, effet sur le journal), `Shell "cd …"`, les variables inutiles de
  `Button4_Click`, l'écriture morte de `CDec` dans la colonne 2 (écrasée) n'est **pas** supprimable sans
  décider de l'anomalie A03.
- Factoriser les trois passes de `Button1_Click` (BL, factures, factures matériel) dans un helper
  paramétré par tables et colonnes.
- `MajTab` : itérer sur les clients (ou les codes) distincts et ajouter les nœuds sans reparcourir
  l'arbre ; l'arbre obtenu (nœuds et ordre) doit rester identique (**SQL modifié, dump identique**).
- Couleurs de `Colcli_Data` calculées une fois (au remplissage) et non à chaque cellule.

### Commonalisation avec d'autres fichiers

- `Ex1` et `dteN*_LostFocus` : identiques à [`RelvMo`](../RelvMo.class/architecture.md) →
  `PeriodeParDefaut()` (RELVMO-007) et `StatCommun.DateSaisie` (HITCARTE-006).
- Grille de recherche par en-têtes (`Deb3`/`Deb4`/`Dbclk`, `C1/N1/Cp1/V1_*`, `ChkInput`, `Colcli_Data`) :
  même mécanique dans [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md),
  [`TriclientsD`](../../Caisse/Affichages/TriclientsD.class/architecture.md),
  [`TriBl`](../../Affichages/TriBl.class/architecture.md), `ConsultArt`, `Materiel`, `MajTarifM`,
  `Preparation`, `Attribution` (lot Gestion) : clause de recherche commune (`ClauseRecherche`, voir
  FCLIENTCARTE-012) avec valeurs passées en `&1`.
- Détail de facture (`Rlcli_click`) : lecture « en-tête + lignes historisées ou en cours » proche de
  celle des écrans d'historique (`TriHistos`) ; à évaluer en phase 3.
- Table `Fiches_Stat` partagée : voir RELVMO-A03.

### Réduction de portée

- `Ex1`, `dteN0_GotFocus`, `dteN0_LostFocus`, `dteN1_GotFocus`, `dteN1_LostFocus` (non levés : groupe
  `Cmpt`), `MajTab`, `Controle`, `Tris`, `compteTiers`, `Deb3`, `Deb4`, `Dbclk`, `ChkInput` → `Private`.
  `compteMan` et `A1_KeyPress` sont supprimés (code mort). `ColCli_Click` (rejeu dynamique) et les
  autres handlers restent `Public`.

### Séparation traitement / GUI

- `Button1_Click` → `RemplitStat(d0, d1, sClient) As Boolean` (SQL seul).
- `Rlcli_click` → `LitFacture(numfac) As Result` (historique puis en cours) ; le handler remplit
  `Colrcp3`.
- `Button4_Click` → impression séparée par mode (`ImprimeParClient`, `ImprimeParProduit`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une requête d'agrégat sur l'union des lignes de factures (en cours et historisées) remplacerait la
  table `Fiches_Stat` ; à défaut, une table de travail propre à l'écran, avec `qtefac`/`nethtfac`
  numériques et une clé incluant le numéro de ligne (pour ne pas perdre les lignes répétées).
