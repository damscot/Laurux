# HitCarte — Architecture

> Source : `.src/Statistiques/HitCarte.class`

## Vue d'ensemble

`HitCarte` est l'écran de **paramétrage du hit-parade des cartes de fidélité** (ouvert en modal par
`Fmenu.class:2008`, `HitCarte.ShowModal()`). L'utilisateur saisit une période (`dteN0`/`dteN1`,
défaut 01.01.2006 → aujourd'hui), le nombre de cartes à afficher (groupe `Rb` : 10, 20, 50, 100) et le
critère de tri (`RadioButton1` « CA » → tri par **points**, `RadioButton2` « Visites »). Le bouton
**Traitement** (`Btn`, tag 1) remplit la table de travail `Total` à partir des tickets archivés, puis
ouvre [`VisHitCartes`](../VisHitCartes.class/architecture.md) qui affiche et imprime le classement.

Nature globale : **mixte** (calcul SQL dans `Traitement`, saisie des dates dans les autres méthodes).
L'écran appelle `Utils.Observers(Me)` une fois dans `_New`.

### Table de travail `Total` (hors `db_control.csv`)

`DROP TABLE IF EXISTS Total` puis `CREATE TABLE Total (carte Char(13) NOT NULL, nom Char(35), visite
Integer(5), points Decimal(12,2), PRIMARY KEY (carte))` + `Utils.db.Engine()`. Une ligne par carte :
nombre de tickets (`visite`) et somme des points des tickets (`points`). Même nom que la table de
travail de [`TBord`](../TBord.class/architecture.md), `StatClimo`, `StatComm`, `StatComArt`,
`StatFour`, `StatTypCli` et [`Statcai`](../../Caisse/Statcai.class/architecture.md), avec une autre
structure (STATCAI-A04). Elle reste en base après le traitement et est relue par `VisHitCartes`.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `hForm` | var | Private |  | VisHitCartes | 27 |
| `Filename` | var | Private |  | String | 28 |
| `Tot` | var | Private |  | Integer | 29 |
| `son` | var | Private |  | Integer | 30 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 32-46 | Public | 1 | 11 | 0 | méthode spéciale |
| `dte_KeyPress` | 48-69 | Public | 9 | 18 | 0 | handler GUI |
| `Btn_Click` | 71-82 | Public | 3 | 8 | 0 | handler GUI |
| `Rb_Click` | 84-101 | Public | 5 | 12 | 0 | handler GUI |
| `dte_GotFocus` | 106-112 | Public | 1 | 5 | 0 | handler GUI |
| `dteN0_LF` | 117-130 | Public | 3 | 12 | 0 | portée réductible ? |
| `dteN1_LF` | 135-155 | Public | 6 | 19 | 0 | portée réductible ? |
| `Traitement` | 157-229 | Public | 16 | 70 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`, `Tot = 10`,
  son, `filename = ~/tmp/Sinv.kud` (jamais utilisé), dates par défaut. `Frmt` (couleurs) est calculé
  sans être utilisé.
- **`dte_KeyPress()`** [portée : nécessaire (handler du groupe `Dte`)] [nature : GUI]. Entrée/Retour/Tab
  sur `DteN0` (tag 1) → `dteN0_LF` puis focus `dteN1` ; sur `Dten1` (tag 2) → `dteN1_LF` puis focus
  `dteN0`.
- **`Btn_Click()`** [portée : nécessaire (handler du groupe `Btn`)] [nature : GUI]. Tag 1 →
  `Traitement`, tag 2 → `Me.Close`.
- **`Rb_Click()`** [portée : nécessaire (handler du groupe `Rb`)] [nature : GUI]. Fixe `Tot` à 10, 20,
  50 ou 100.
- **`dte_GotFocus()`** [portée : nécessaire (handler)] [nature : GUI]. `Utils.SetEditColor`.
- **`dteN0_LF()` / `dteN1_LF()`** [portée : réductible] [nature : GUI]. Normalisent la saisie
  (`Utils.Cdate_calc` puis `Cdate_aff`, `"00.00.0:00"` → aujourd'hui) ; `dteN1_LF` signale par son et
  `Message.Warning` une fin antérieure au début (comparaison `aaaammjj` en `Val`). Les `Catch`
  remettent le focus. Ce sont des méthodes ordinaires (les zones sont dans le groupe `Dte`), copies
  quasi identiques de celles d'[`Histovmo`](../Histovmo.class/architecture.md).
- **`Traitement()`** (CC 16) [portée : réductible] [nature : mixte].
  1. Recrée `Total`.
  2. Si au moins une date est saisie : `SELECT * FROM Fiches_HisEntTickets` (`Cbase.Table("TabHEntTck")`)
     `where date >= &1 and date <= &2 order by carte` (dates `aaaammjj` : la borne de fin exclut les
     tickets du dernier jour postérieurs à minuit ; les tickets **supprimés** `suppr = 1` sont
     comptés).
  3. Pour chaque ticket avec `carte` non nulle : `SELECT * FROM Fiches_Carte` (`Cbase.Table("TabCarte")`)
     `Where code = &1` (une requête par ticket ; `code` est la clé primaire, la boucle interne ne
     tourne qu'une fois) ; puis `SELECT * FROM Total Where carte = &1` → `UPdate Total set carte = &1,
     points = &2, visite = &3 Where carte = &1` (points cumulés, visites + 1) ou `INSERT INTO Total
     (carte, nom, points, visite)` (nom de la carte, points du ticket, 1 visite). Les cartes inconnues
     de `Fiches_Carte` sont ignorées.
  4. Sinon : son + « Veuillez saisir une date SVP ! ».
  5. Lit le tri (`RadioButton1` → `"P"`, sinon `"V"`), vérifie que `Total` n'est pas vide, puis
     `hForm = New VisHitCartes(Me, Tot, son, tri, dteN0.Text, dteN1.Text)` et `hForm.Show()` (non
     modal) ; sinon « Aucune donnée pour cette période ! ».
  Variables mortes : `Tab = "Fiches_HistoFac"`, deuxième affectation de `Tab2`. Le couple
  `carte`/`TotA` (remise à 0 de `TotA` au changement de carte) est sans effet utile, `TotA` étant
  réaffecté juste après dans un `Try`.
  Partie extractible : étapes 1 à 3 (`RemplitHitParade(d0, d1) As Boolean`).

## État global utilisé

- `Start.Son`, `Start.Musique`, `Start.LocalSettings["/Coul/Fnets"]` (lu pour rien).
- `Utils.Observers`, `Utils.SetEditColor`, `Utils.Cdate_calc`, `Utils.Cdate_aff`, `Utils.Cdate_Dbase`,
  `Utils.cpoint`, `Utils.FColr`, `Utils.db`, `Cbase.Table("TabHEntTck" | "TabCarte")`.
- Table de travail partagée `Total`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Supprimer les variables mortes (`Tab`, `Frmt`, `filename`, double `Tab2`, couple `carte`/`TotA`).
- Remplacer la boucle « un `SELECT Fiches_Carte` + un `SELECT Total` par ticket » par une seule requête
  d'agrégat `SELECT carte, COUNT(*), SUM(points) FROM Fiches_HisEntTickets JOIN Fiches_Carte … GROUP BY
  carte` suivie des `INSERT` (**SQL modifié, dump identique** à vérifier : arrondis des sommes
  `Decimal(12,2)` identiques).

### Commonalisation avec d'autres fichiers

- **Lecture de `Fiches_Carte`** : la même table est lue, chacun avec sa requête, par
  [`FClientcarte`](../../Caisse/FClientcarte.class/architecture.md) (`Maj_Zones`),
  [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md),
  [`Caisse.RecupClientd`](../../Caisse/Caisse.class/architecture.md) et
  [`EmailingCarte`](../../Gestion/Mails/EmailingCarte.class/architecture.md). Le helper `LitCarte(code)
  As Result` prévu par FCLIENTCARTE-008 sert ici à lire le nom de la carte.
- **Saisie des dates** (`dteN0_LF`/`dteN1_LF`) : même code dans
  [`Histovmo`](../Histovmo.class/architecture.md), [`RelvMo`](../RelvMo.class/architecture.md),
  [`RelMoprod`](../RelMoprod.class/architecture.md), `StatClimo`, `StatComm`, `StatComArt`,
  `StatTypCli` : un helper `StatCommun.DateSaisie` (socle proposé dans [`StatComm`](../StatComm.class/architecture.md)) (même principe qu'EXPORTJDV-004)
  et un contrôle `DatesOrdonnees(d0, d1) As Boolean` ; les messages restent dans l'écran.
- **Table `Total`** : même motif que [`TBord`](../TBord.class/architecture.md) ; création à faire passer
  par `StatCommun.TotalCree` (socle proposé dans [`StatComm`](../StatComm.class/architecture.md)),
  nommage commun à traiter avec STATCAI-A04.
- **Handlers de date** : `dte_GotFocus` est identique au caractère près dans 7 écrans (dont `Histovmo`)
  et `dte_KeyPress` a 6 copies ; leurs corps délèguent au socle `StatCommun` (handlers conservés).

### Réduction de portée

- `dteN0_LF`, `dteN1_LF`, `Traitement` : aucun appelant externe (`grep`) → `Private`. Les handlers
  `dte_KeyPress`, `Btn_Click`, `Rb_Click`, `dte_GotFocus` restent `Public`.

### Séparation traitement / GUI

- `Traitement` → `RemplitHitParade(d0, d1)` (SQL seul) ; le handler garde le message de date,
  `Me.Mouse`, le choix du tri et l'ouverture de `VisHitCartes`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une vue ou une requête d'agrégat par carte remplacerait la table physique `Total`.
- Un index sur `Fiches_HisEntTickets(carte, date)` accélérerait le hit-parade.
