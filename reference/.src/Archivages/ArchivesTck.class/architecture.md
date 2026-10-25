# ArchivesTck — Architecture

> Source : `.src/Archivages/ArchivesTck.class`

## Vue d'ensemble

`ArchivesTck` est l'écran **« Tickets archivés »** (`Fmenu.Menu218`, modal) : consultation et
réimpression A4 des tickets de caisse déjà moulinés, stockés par
[`Moulinage`](../../Caisse/Moulinage.class/architecture.md) dans `Fiches_HisEntTickets` (en-têtes) et
`Fiches_HisLigTickets` (lignes), à partir des tickets saisis par
[`Caisse`](../../Caisse/Caisse.class/architecture.md). Les mêmes tables sont purgées par
[`RazHistoTk`](../RazHistoTk.class/architecture.md).

Organisation de l'écran :

- une grille paginée `Coltk` (GridView, 9 colonnes : numéro, date-heure, HT, TVA, TTC, caisse,
  règlement, vendeur, client), remplie par `Deb2` (tri décroissant) ou `Deb3` (croissant) avec
  `LIMIT NbEnreg, lg` ;
- une rangée de `TextBox` d'en-tête (`Nm`, `Date`, `Mt`, `Ca`, `Ve`, `Cli`) qui servent à la fois de
  sélecteur de tri (prise de focus), de filtre (frappe : `LIKE "%…%"`) et d'inversion du tri
  (double-clic) ; `Mtht`, `Mttva`, `Re` n'ont pas de handler ;
- un détail (`Detk`, ColumnView, et `Panel1`) affiché au clic sur une ligne (`Coltk_Click`) ;
- la réimpression (`Button4_Click`) : PDF A4 `~/tmp/Hticket.pdf` par la classe `Htickets`
  (`Inherits PdfWriter`, lot Reports), ouvert par `Visualiseur.Prog`.

Lecture seule sur les données métier, **sauf** la table de travail permanente `Tottva`, supprimée et
recréée à chaque réimpression (`TabTva`) : c'est la même table que la caisse utilise pour son bas de
ticket (CAISSE-A17), d'où un risque d'interférence entre postes (ARCHIVESTCK-A04).

L'écran appelle `Utils.Observers(Me)` une fois dans `_New` : il est journalisé et rejouable.
Nature : **mixte** (SQL construit et exécuté dans les handlers).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Tri` | var | Private |  | String | 3 |
| `sel` | var | Private |  | String | 4 |
| `Dbl` | var | Private |  | String | 5 |
| `Totht` | var | Private |  | String | 6 |
| `Tottva` | var | Private |  | String | 7 |
| `TotTk` | var | Private |  | String | 8 |
| `DateTk` | var | Private |  | String | 9 |
| `sRegch` | var | Private |  | String | 10 |
| `sRegca` | var | Private |  | String | 11 |
| `sReges` | var | Private |  | String | 12 |
| `sRegce` | var | Private |  | String | 13 |
| `NbEnreg` | var | Private |  | Integer | 14 |
| `lg` | var | Private |  | Integer | 15 |
| `pdf` | var | Private |  | Htickets | 16 |
| `Tkresult` | var | Private |  | Result | 17 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 19-43 | Public | 1 | 23 | 0 | méthode spéciale |
| `cpoint` | 45-49 | Public | 1 | 3 | 0 | portée réductible ? |
| `Form_Open` | 51-62 | Public | 2 | 10 | 0 | handler GUI |
| `Tris` | 64-86 | Public | 1 | 21 | 0 | portée réductible ? |
| `Deb2` | 88-93 | Public | 1 | 4 | 0 | portée réductible ? |
| `Deb3` | 95-100 | Public | 1 | 4 | 0 | portée réductible ? |
| `affiche` | 102-143 | Public | 14 | 40 | 0 | portée réductible ? |
| `Refresh` | 145-149 | Public | 1 | 3 | 0 | portée réductible ? |
| `Dbclk` | 151-161 | Public | 2 | 9 | 0 | portée réductible ? |
| `Nm_GotFocus` | 163-172 | Public | 1 | 8 | 0 | handler GUI |
| `Nm_Dblclick` | 174-183 | Public | 1 | 8 | 0 | handler GUI |
| `Nm_KeyPress` | 185-192 | Public | 3 | 6 | 0 | handler GUI |
| `Date_GotFocus` | 194-203 | Public | 1 | 8 | 0 | handler GUI |
| `Date_Dblclick` | 205-214 | Public | 1 | 8 | 0 | handler GUI |
| `Date_KeyPress` | 216-225 | Public | 3 | 8 | 0 | handler GUI |
| `Mt_GotFocus` | 227-236 | Public | 1 | 8 | 0 | handler GUI |
| `Mt_Dblclick` | 238-247 | Public | 1 | 8 | 0 | handler GUI |
| `Mt_KeyPress` | 249-256 | Public | 3 | 6 | 0 | handler GUI |
| `Ca_GotFocus` | 258-267 | Public | 1 | 8 | 0 | handler GUI |
| `Ca_Dblclick` | 269-278 | Public | 1 | 8 | 0 | handler GUI |
| `Ca_KeyPress` | 280-287 | Public | 3 | 6 | 0 | handler GUI |
| `Ve_GotFocus` | 289-298 | Public | 1 | 8 | 0 | handler GUI |
| `Ve_Dblclick` | 300-309 | Public | 1 | 8 | 0 | handler GUI |
| `Ve_KeyPress` | 311-318 | Public | 3 | 6 | 0 | handler GUI |
| `Cli_GotFocus` | 320-329 | Public | 1 | 8 | 0 | handler GUI |
| `cli_Dblclick` | 331-340 | Public | 1 | 8 | 0 | handler GUI |
| `cli_KeyPress` | 342-349 | Public | 3 | 6 | 0 | handler GUI |
| `KeyPress` | 351-364 | Public | 5 | 12 | 0 | portée réductible ? |
| `dKeyPress` | 366-383 | Public | 5 | 15 | 0 | portée réductible ? |
| `init_Tk` | 385-394 | Public | 1 | 8 | 0 | portée réductible ? |
| `Button2_Click` | 396-400 | Public | 1 | 3 | 0 | handler GUI |
| `Button3_Click` | 402-411 | Public | 1 | 8 | 0 | handler GUI |
| `Coltk_MouseWheel` | 413-422 | Public | 2 | 8 | 0 | handler GUI |
| `Coltk_KeyPress` | 424-448 | Public | 9 | 21 | 0 | handler GUI |
| `Descendre_Click` | 450-460 | Public | 5 | 9 | 0 | handler GUI |
| `Remonter_Click` | 462-470 | Public | 4 | 7 | 0 | handler GUI |
| `Deplacement` | 472-482 | Public | 3 | 8 | 0 | portée réductible ? |
| `Descendre_KeyPress` | 484-492 | Public | 5 | 7 | 0 | handler GUI |
| `Remonter_KeyPress` | 494-502 | Public | 5 | 7 | 0 | handler GUI |
| `Coltk_Click` | 504-544 | Public | 10 | 38 | 0 | handler GUI |
| `TabTva` | 546-556 | Public | 1 | 8 | 0 | portée réductible ? |
| `Button4_Click` | 558-696 | Public | 46 | 132 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_New()`** [portée : nécessaire (spéciale)] [nature : GUI]. `Utils.Observers(Me)`, calcul de
  `lg` (lignes visibles − 1), libellés des en-têtes, colonnes de `Detk`.
- **`Form_Open()`** [portée : nécessaire (handler)] [nature : GUI]. Tri `numero`, filtre vide,
  `Tris`, `Deb2`, focus sur la 1re ligne.
- **`Tris()`** [portée : réductible] [nature : GUI]. Largeur et alignement des 9 colonnes de `Coltk`
  calés sur les `TextBox` d'en-tête.
- **`init_Tk()`** [portée : réductible] [nature : GUI]. Remet les libellés des en-têtes (« Montant »
  pour `Mt`, alors que `_New` écrit « Montant ttc »).

### Chargement de la liste

- **`Deb2()` / `Deb3()`** [portée : réductible] [nature : mixte]. `select * from <TabHisEntTck> Left
  join <TabCli> on client = cli_code where <Tri> like "%<sel>%" order by <Tri> [Desc] limit
  <NbEnreg>, <lg>` : le texte saisi est **concaténé** entre guillemets doubles (un `"` saisi casse la
  requête, A06). Puis `affiche`. Les deux fonctions ne diffèrent que par `Desc`.
- **`affiche()`** (CC 14) [portée : réductible] [nature : GUI]. Remplit `Coltk` depuis le `Result`
  membre `Tkresult` : date formatée (repli `Utils.Cdate_Carte(Utils.Cdate_Comp(…))`), libellé du
  mode de règlement (le dernier indicateur trouvé l'emporte : `V` chèque, `U` carte, `N` espèces,
  `W` crédit, `savoir = "1"` avoir, `R` chèque entreprise), nom du ticket ou nom/prénom du client ;
  ticket supprimé (`suppr = True`) en italique barré (sous SQLite, `tinyint` lu comme entier : test
  `= True` probablement toujours faux, à confirmer). Variable locale `d` inutilisée.
- **`Dbclk()`** [portée : réductible] [nature : GUI]. Bascule `Dbl` et recharge en croissant
  (`Deb3`) ou décroissant (`Deb2`).
- **`Deplacement()`** [portée : réductible] [nature : GUI]. Borne `NbEnreg` à 0 et recharge selon
  `Dbl`.
- **`Refresh()`** [portée : réductible] — **code mort** (signal `unused` vérifié : aucun appel,
  aucun appel dynamique). Elle **masque** la méthode héritée `Control.Refresh` ; aucun code
  n'appelant `ArchivesTck.Refresh` ni `.Refresh` sur cette fenêtre (vérifié par grep), sa
  suppression ne change rien.

### En-têtes de tri et de filtre

- **`Nm_GotFocus`, `Date_GotFocus`, `Mt_GotFocus`, `Ca_GotFocus`, `Ve_GotFocus`, `Cli_GotFocus`**
  [portée : nécessaire (handlers)] [nature : GUI]. Même séquence : `sel = ""`, `init_Tk`, vide la
  zone, `NbEnreg = 0`, `Tri` = `numero` / `date` / `mttc` / `caisse` / `vendeur` / `cli_nom`, `Deb2`.
- **`Nm_Dblclick`, `Date_Dblclick`, `Mt_Dblclick`, `Ca_Dblclick`, `Ve_Dblclick`, `cli_Dblclick`**
  [portée : nécessaire (handlers)] [nature : GUI]. Même séquence puis `Dbclk`.
- **`Nm_KeyPress`, `Mt_KeyPress`, `Ca_KeyPress`, `Ve_KeyPress`, `cli_KeyPress`** [portée :
  nécessaire (handlers)] [nature : GUI]. Hors Entrée, délèguent à `KeyPress`.
- **`Date_KeyPress`** [portée : nécessaire (handler)] [nature : GUI]. `Print Key.Text` (trace de
  débogage sur la sortie standard), `dKeyPress`, `Stop Event`.
- **`KeyPress()`** [portée : réductible] [nature : GUI]. Ajoute ou retire un caractère à `sel` puis
  `Deb2` ; `Catch` vide (erreurs ignorées).
- **`dKeyPress()`** [portée : réductible] [nature : mixte]. Construit la saisie dans la zone `Date`,
  la convertit par `LDate.DateFilterDB(Date.text, True)` en motif SQL, met à jour l'infobulle, `Print`
  de débogage, `Deb2` ; `Catch` vide.

### Pagination

- **`Coltk_MouseWheel`, `Descendre_Click`, `Remonter_Click`, `Coltk_KeyPress`,
  `Descendre_KeyPress`, `Remonter_KeyPress`** [portée : nécessaire (handlers)] [nature : GUI].
  Avance ou recule de `lg` lignes (`Descendre` seulement si la page est pleine) ; flèches en bord de
  grille, Page préc./suiv., Entrée = `Coltk_Click`, Échap/F2 sur les boutons ferment l'écran. Même
  logique que [`Tricartes`](../../Caisse/Affichages/Tricartes.class/architecture.md) et les `Tri*`.

### Détail d'un ticket

- **`Coltk_Click()`** (CC 10) [portée : nécessaire (handler, rejoué par `Object.Call`, doit rester
  `Public`)] [nature : mixte]. Lignes du ticket : `SELECT * FROM <TabHisLigTck> as l Left join
  <TabHisEntTck> as e on e.numero = l.numero Left join <TabCli> … where l.numero = &1 order by
  cast(numlig as unsigned)` (jointure par numéro seul : un numéro en doublon duplique les lignes,
  A08) ; mémorise les totaux de la ligne cliquée ; `Label3 = Left$(numero, 1)` affiché comme
  « Caisse n° » et `Label5 = Right$(numero, 6)` comme « Ticket n° » (A05) ; relit l'en-tête pour
  préparer les libellés de règlement (`sReges`, `sRegch`, `sRegca`, `sRegce`).
- **`Button3_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Masque le détail.
- **`Button2_Click()`** [portée : nécessaire (handler)] [nature : GUI]. Ferme.

### Réimpression

- **`TabTva()`** [portée : réductible] [nature : calcul (DDL)]. `DROP TABLE IF EXISTS Tottva` puis
  `CREATE TABLE Tottva (code, mtva, PRIMARY KEY(code))` + `Utils.db.Engine()` : table **permanente**
  et partagée (A04).
- **`Button4_Click()`** (CC 46, max du fichier) [portée : nécessaire (handler)] [nature : mixte].
  1. `Shell "cd ~"` sans effet, première affectation de `Filename` inutile (l. 580-581).
  2. `New Htickets("Portrait", "mm", "A4")`, `TabTva`, en-tête société (`<TabSoc>` lu sans test
     `Available`, SIRET, TVA intracommunautaire, téléphone, ligne « Caisse n° … Ticket n° … du …
     Caissier(e) … »).
  3. Cumul de TVA par taux dans `Tottva` sur les lignes `type <> 'M'` : ⚠️ le filtre « pas une ligne
     `C` » teste `rntck!type` (1re ligne du ticket) au lieu de `rtva2!type` (A02) ; `ttvam` n'est
     recalculé que pour les types `A` et `S` (valeur précédente réutilisée sinon, A03) ; ⚠️ le cumul
     `ttva2` est **commun à tous les taux** : dès qu'un taux réapparaît après un autre, son montant
     reçoit le cumul de l'autre taux (A01).
  4. Impression des lignes (hors type `K`) ; `BC`/`BH` fournissent le total TTC/HT déjà calculé par
     la caisse (`tckwithtotal`) ; sinon pied : HT recalculé (`TTC − ΣTVA` si incohérent), une ligne
     par taux, TTC, modes de règlement. La variable `Total` est cumulée mais jamais imprimée.
  5. `pdf.Output("~/tmp/Hticket.pdf")` puis `Visualiseur.Prog` (le répertoire `~/tmp` doit exister).

### Divers

- **`cpoint(mtt)`** [portée : réductible] — **code mort** (signal `unused` vérifié) : copie locale
  de la conversion `.`→`,` ; le fichier utilise partout `Utils.cpoint`. Une des 6 copies locales
  relevées (notes transverses).

## État global utilisé

- `Utils.db`, `Utils.Observers`, `Utils.cpoint`, `Utils.Cdate_Carte`, `Utils.Cdate_Comp` ;
  `LDate.DateFilterDB` ; `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Siret"]` ;
  `Visualiseur.Prog` ; table de travail `Tottva` (partagée avec `Caisse`, `Facture`, `Archives`…).
- État d'instance : `Tri`, `sel`, `Dbl`, `NbEnreg`, `lg`, `Tkresult`, totaux et libellés de
  règlement du ticket sélectionné.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Deb2`/`Deb3` → une fonction `Charge(bDesc)` ; requête construite par une fonction pure
  `RequeteTickets(sTri, sSel, bDesc, iDebut, iNb) As String` (texte identique).
- Les 18 handlers d'en-tête → deux aides privées `ChoisirTri(hZone, sTri)` et `InverserTri(hZone,
  sTri)` ; les handlers restent (noms intouchables) et deviennent des appels d'une ligne.
- `Button4_Click` (CC 46) : découper en `ImprimeEntete`, `CumulTva`, `ImprimeLignes`,
  `ImprimePied` (SQL identique, `Tottva` conservée tant que A04 n'est pas tranchée).
- Supprimer les traces `Print` (l. 220, 376), `Shell "cd"`, la variable `Total` et `d`.

### Commonalisation avec d'autres fichiers

- Pagination tactile → classe d'aide `PaginationListe` (TRICARTES-005), partagée avec `Tricartes`,
  `TriclientsD`, [`Archives`](../Archives.class/architecture.md) et les `Tri*` du lot Affichages.
- Cumul de TVA du bas de ticket : même algorithme (et même table `Tottva`) que
  `Caisse.TabTva`/`Aff_bastk` (CAISSE-A17) ; après correction de A01/A04, une fonction commune
  `TvaTicket(numero) As Collection` servirait aux deux.
- Libellé du mode de règlement (indicateurs `V`/`U`/`N`/`W`/`R`) : même décodage dans `Caisse`,
  `Moulinage` et `FClientcarte` (à factoriser avec le lot Caisse).
- `cpoint` local → `Utils.cpoint` (suppression, code mort).

### Réduction de portée

- `Tris`, `Deb2`, `Deb3`, `affiche`, `Dbclk`, `KeyPress`, `dKeyPress`, `init_Tk`, `Deplacement`,
  `TabTva` : aucun appelant externe (vérifié : seul `Fmenu` référence la classe, par `ShowModal`) →
  `Private`. `Coltk_Click` reste `Public` (rejeu, `replay_dynamic`).

### Séparation traitement / GUI

- `RequeteTickets` (pure) pour la liste ; lecture de l'en-tête société et des lignes du ticket dans
  des fonctions sans contrôle (`LitTicket(numero) As Result`), appelées par `Coltk_Click` et
  `Button4_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Montants des tickets stockés en `char(12)` : un type `DECIMAL` supprimerait les `Val(cpoint(…))`.
- Unicité `(caisse, numero)` ou identifiant d'en-tête dans les lignes (voir RazHistoTk).
- Supprimer la table permanente `Tottva` (cumul en mémoire).
