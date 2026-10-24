# Stockmvt — Architecture

> Source : `.src/Gestion/Stockmvt.class` · Formulaire : `.src/Gestion/Stockmvt.form`

## Vue d'ensemble

`Stockmvt` est l'écran d'**analyse des mouvements de stock par critères** (`Fmenu.mvst_Click`,
`Stockmvt.Show`). L'utilisateur choisit :

- une période (`Textdtinf`–`Textdtsup`, par défaut début d'exercice → fin du mois courant) ;
- des filtres : marque, centrale d'achat, client, fournisseur, un article (`Radioart`) ou des
  familles (`Radiofam`, arbre `TreeView1` à sélection multiple, avec ou sans détail article
  `Checkart`) ;
- le sens : entrées, sorties ou tout (`Radioentre`/`Radiosortie`/`Radiotouta`) ;
- les **sources** à interroger (cases à cocher) ;
- le regroupement : détail, jour, mois ou année (`Radiodetail`/`Radiojour`/`Radiomens`/
  `Radioanuel`) et le détail par source (`Checkdetf`) ;
- les colonnes : C.A. (`Checkca`) et marge (`Checkmarge`).

`Buttrait_Click` construit alors **dynamiquement** une requête `UNION ALL` de 10 sous-requêtes (une
par source), l'exécute, affiche le résultat dans une `GridView` virtuelle (`GridView1_Data`) avec
totaux, et permet l'édition PDF (`Butedit_Click`, gb.report) et l'export CSV (`Butexp_Click`).
Un double-clic en mode détail ouvre le document d'origine (facture ou réception).

Nature globale : **mixte**, à dominante calcul (construction SQL) mais entièrement pilotée par
les contrôles du formulaire.

### Sources de mouvements de stock : comparaison avec les autres calculs

| Source | `Stockmvt` (cette classe) | [`Cstock.Calc_stock`](../../Utils/Cstock.module/architecture.md) (recalcul de `art_qte`) | [`DB_Connection.Lockstock`](../../Utils/DB_Connection.class/architecture.md) | `Validinv` (inventaire annuel) |
|---|---|---|---|---|
| Stock de départ | `Fiches_Art.art_stkdep`, daté de `Fiches_Parametres.dteinv` (`Checksdp`) | `art_stkdep`, ou `Fiches_HisInvT.inv_qtestock` (inventaire tournant) | — | écrit `art_stkdep = art_qte = qté inventoriée`, `dteinv` |
| Stock théorique | `Fiches_Art.art_qte`, daté de `Now` (`Checkstth`) | résultat écrit dans `art_qte` | `art_qte` ± quantité reçue | écrit |
| BL / factures en cours | `Fiches_Bl`/`Ligbl`, types **A, B, F** | types **B, F** seulement | — | — |
| Idem « entretien » | `Fiches_BlM`/`LigblM`, types A, B, F | types B, F | — | — |
| Factures archivées | `Fiches_HistoFac[M]`/`HistoLigfac[M]` | idem | — | — |
| Réceptions fournisseurs | `Fiches_Entrecpt`/`Ligrecpt`, **`qte` brute** | `qte × art_txconv` | appelé par `Achat` à la validation | — |
| Mouvements exceptionnels | `Fiches_Mvtexp`, `Fiches_Mvtexpdc` (produits composés) | idem | — | — |
| Tickets de caisse | **`Fiches_HisEntTickets`/`HisLigTickets`** (`Checktck`) | **exclus** (code commenté : supposés repris par le moulinage) | — | — |
| Transferts de dépôts | **absents** | `Fiches_Sdepots` (dépôt `01`) | — | — |
| Inventaire tournant | absent | `Fiches_HisInvT` | — | vidé (`TRUNCATE`) |

Divergences à trancher pour une **définition unique des mouvements de stock** (commonalisation de
phase 3, notée dans les notes transverses : Cstock ↔ Lockstock ↔ Validinv ↔ Stockmvt) : type `A`
des BL, facteur de conversion des réceptions, tickets de caisse (double comptage possible si le
moulinage a déjà produit des BL/factures et que `Checktck` et `Checkbl`/`Checkfac` sont cochés,
à confirmer), dépôts et inventaire tournant. Toute convergence modifie les chiffres affichés :
anomalie STOCKMVT-A05, pas un rework.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$familles` | var | Private |  | Trifam | 3 |
| `$rpt` | var | Private |  | Report | 4 |
| `$res` | var | Private |  | Result | 5 |
| `$entre` | var | Private |  | Float | 6 |
| `$sortie` | var | Private |  | Float | 7 |
| `$ca` | var | Private |  | Float | 8 |
| `$marge` | var | Private |  | Float | 9 |
| `$soption` | var | Private |  | String | 10 |
| `Bsel` | var | Public |  | Boolean | 12 |
| `Bval` | var | Public |  | String | 13 |
<!-- /AUTO:declarations -->

`$soption` est déclaré mais jamais utilisé ; `$rpt` (rapport) n'est utilisé que dans
`Butedit_Click` (pourrait être local). `Bsel`/`Bval` sont `Public` car `TriCpt` et `TriArticles`
les écrivent via `Object.SetProperty` : leur portée ne doit pas être réduite.

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-44 | Public | 1 | 23 | 0 | méthode spéciale |
| `TriArticles` | 46-62 | Private | 4 | 15 | 0 |  |
| `Buttrait_Click` | 64-504 | Public | 75 | 409 | 0 | handler GUI |
| `aff_click` | 506-510 | Public | 1 | 3 | 0 | handler GUI |
| `affiche` | 512-583 | Private | 11 | 69 | 0 |  |
| `mab` | 585-592 | Private | 1 | 6 | 0 |  |
| `GridView1_Data` | 594-662 | Public | 18 | 66 | 0 | handler GUI |
| `GridView1_Activate` | 664-684 | Public | 5 | 18 | 0 | handler GUI |
| `dtinv` | 686-697 | Private | 2 | 9 | 0 |  |
| `Butedit_Click` | 700-837 | Public | 23 | 128 | 0 | handler GUI |
| `nlab` | 839-850 | Private | 1 | 9 | 0 |  |
| `btn_Click` | 854-880 | Public | 6 | 24 | 0 | handler GUI |
| `ColumnView1_Activate` | 882-893 | Public | 3 | 10 | 0 | handler GUI |
| `Butcli_Click` | 896-906 | Public | 2 | 8 | 0 | handler GUI |
| `Butfour_Click` | 908-918 | Public | 2 | 8 | 0 | handler GUI |
| `Butquit_Click` | 921-925 | Public | 1 | 3 | 0 | handler GUI |
| `Butart_Click` | 927-938 | Public | 2 | 9 | 0 | handler GUI |
| `Butexp_Click` | 940-959 | Public | 5 | 16 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Initialisation

- **`_new()`** [spéciale] [nature : GUI] (l. 16-44) : `Utils.Observers`, `Music.Load`, largeur des
  totaux, chaînage des champs (`Chainage`), expressions régulières de saisie client (`411…`) et
  fournisseur (`401…`), dates par défaut (`LDate(Now).EDeb.L`, `FinMois.L`), arbre des familles
  (`New Trifam("1")` puis `TriArticles`).
- **`TriArticles(fam As Trifam)`** [Private] [GUI] (l. 46-62) : remplit récursivement `TreeView1`
  (parcours `precedant`/`parent`) puis sélectionne le premier nœud. ⚠️ Même nom que la classe
  `TriArticles` (utilisée dans `Butart_Click`) : homonymie source de confusion.

### Construction et exécution de la requête

- **`Buttrait_Click()`** [handler, CC 75, ~410 lignes] [nature : mixte] (l. 64-504). Pour chacune
  des 10 sources, quatre fragments `champ*`, `fichier*`, `cond*` et `lib*` :
  1. conditions de période `BETWEEN dtinf.DT AND dtsup.FinJour.DT` (via `Utils.db.Subst`) ;
  2. libellés de source (« Factures en cours », « Entrées fournisseurs »…) si détail ;
  3. marque / centrale : jointure sur `Fiches_Art`. ⚠️ Pour les factures archivées la jointure est
     `art_code = num_ligfac` (**numéro de facture**) au lieu de `code_ligfac` (l. 159, 161) : ces
     sources ne renvoient rien (ou des lignes erronées) dès qu'un filtre marque/centrale est saisi
     (STOCKMVT-A01) ;
  4. client (`cdclibl`, `cdclifac`, `client`) et fournisseur (`Fiches_Entrecpt.four`,
     `art_four`) ;
  5. article (`Radioart`, obligatoire : `Balloon.Warning`) ou familles (`Radiofam` :
     `Utils.fam(champ, TreeView1)`, qui produit `" AND champ IN)"` — SQL invalide — si aucun nœud
     n'est sélectionné, UTILS-A02) ; colonnes `code`, `libelle`, `dte` selon le cas ;
  6. sens : filtres `qte > '0'`, `< '0'` ou `<> '0'` (comparaisons de **chaînes** avec `'0'`,
     les quantités étant stockées en texte) ;
  7. quantités `qtem` (sorties) / `qtep` (entrées), `ca`, `mrgart`, `mrgmo`, avec
     `REPLACE(x, ',', '.')`, détaillées ou agrégées (`SUM`) ; stock départ/théorique valorisés au
     PMP ou au prix d'achat (`Radiodeptmp`, `Radiothepmp`) ;
  8. regroupement `GROUP BY dte` / `CONCAT(MONTH(dte), YEAR(dte))` / `YEAR(dte)`, plus
     `,code,libelle` hors détail ;
  9. assemblage par `UNION ALL` des sources cochées ; règles d'exclusion : mouvements
     exceptionnels et produits composés retirés si un client ou un fournisseur est saisi ;
     réceptions retirées si seul un client est saisi ; si seul un fournisseur est saisi, seules
     les réceptions restent et le préfixe `" UNION ALL "` est retiré de `reqfo` (l. 474). ⚠️ Si le
     stock de départ ou théorique est aussi coché, la requête devient `SELECT … SELECT …`
     (UNION supprimé à tort) : erreur SQL probable (STOCKMVT-A02) ;
  10. exécution : en détail (ou `Checkdetf`), l'union triée `ORDER BY dte,code` ; sinon une
      requête englobante `SELECT code, libelle, dte, SUM(…) FROM (<union>) AS a <groupage> ORDER BY
      dte,code` ; affichage par `affiche` ou vidage par `mab`.
  Tables en dur (aucun `Cbase.Table`). `CAST(&2 AS DATE)` et `CONCAT(MONTH(), YEAR())` reposent
  sur les traductions SQLite de `DB_Connection` ; le `CAST … AS DATE` n'est pas traduit (affinité
  numérique sous SQLite, à confirmer).
- **`aff_click()`** [handler du groupe `aff`] [GUI] : désactive l'édition quand un critère
  d'affichage change.
- **`affiche()`** [Private] [mixte] (l. 512-583) : colonnes de la grille selon les options,
  totaux `$entre`, `$sortie`, `$ca`, `$marge` (via `Utils.totobs`), `Rows.Count`.
- **`mab()`** [Private] [GUI] : vide la grille et désactive édition/export.
- **`dtinv()`** [Private] [calcul] (l. 686-697) : `SELECT dteinv FROM Fiches_Parametres`, à défaut
  début d'exercice.

### Affichage et navigation

- **`GridView1_Data(Row, Column)`** [handler, CC 18] [GUI] : remplit toute la ligne quand
  `Column = 0` (date formatée selon le regroupement, zébrage, colonnes optionnelles).
- **`GridView1_Activate()`** [handler] [mixte] : en détail, ouvre `ObjFacB(…).visualisation` pour
  une ligne « Factures… » (`ObjFac.bl` si « en cours », sinon `ObjFac.archive`) ou
  `Commande1(…, Achat.Validee)` pour une « Entrées fournisseurs ». ⚠️ Le test `Match "en cours"`
  vaut aussi pour « Factures en cours entretien » (`Fiches_BlM`) et le cas « archives entretien »
  ouvre `ObjFac.archive` : un document « entretien » est cherché dans la mauvaise table (à
  confirmer, STOCKMVT-A03).
- **`btn_Click()`** [handler du groupe `btn` : `Butmarque`, `Butcenta`] [mixte] : liste
  `Fiches_Marques` ou `Fiches_Centrales` dans `ColumnView1`.
- **`ColumnView1_Activate()`** [handler] [GUI] : reporte la marque ou la centrale choisie.
- **`Butcli_Click()`, `Butfour_Click()`** [handlers] [GUI] : `TriCpt(Client|Fournisseur,
  Sans_Solde, Me)` → `Bsel`/`Bval`.
- **`Butart_Click()`** [handler] [GUI] : `TriArticles(…, Me)` → `Textart`.
- **`Butquit_Click()`** [handler] [GUI] : fermeture.

### Sorties

- **`Butedit_Click()`** [handler, CC 23] [mixte] (l. 700-837) : construit un `Report` (titre,
  en-têtes depuis la grille, une `ReportHBox` par ligne de `$res`, ligne de total), l'imprime dans
  `~/tmp/stockmvt.pdf` et l'ouvre (`Visualiseur.Prog`). Totaux tous formatés `0.000` (C.A. et
  marge compris, alors que la grille affiche `0.00`).
- **`nlab(hb)`** [Private] [GUI] : fabrique de `ReportLabel` (3 mm, bordure droite, 20 mm).
- **`Butexp_Click()`** [handler] [mixte] (l. 940-959) : écrit `~/tmp/Stockmvt.csv` (code ; libellé ;
  date ; nom ; qtem ; qtep ; ca ; mrgart). ⚠️ Lit `$res!nom`, colonne présente **uniquement en mode
  détail** : en mode regroupé l'export échoue (STOCKMVT-A04). `mrgmo` n'est pas exporté.

## État global utilisé

- `Utils.db` (`Exec`, `Subst`), `Utils.Observers`, `Utils.fam`, `Utils.totobs`,
  `Start.Musique`, `Start.R/G/B` (couleur des en-têtes PDF).
- Classes : `LDate`, `Trifam`, `Chainage`, `TextReg`, `ProgBar`, `TriCpt`, `TriArticles`,
  `ObjFacB`/`ObjFac`, `Commande1`/`Achat`, `Visualiseur`, `Editeur`, gb.report.
- Tables (en dur, lecture seule) : `Fiches_Art`, `Fiches_Fam`, `Fiches_Bl`, `Fiches_Ligbl`,
  `Fiches_BlM`, `Fiches_LigblM`, `Fiches_HistoFac[M]`, `Fiches_HistoLigfac[M]`, `Fiches_Entrecpt`,
  `Fiches_Ligrecpt`, `Fiches_Mvtexp`, `Fiches_Mvtexpdc`, `Fiches_HisEntTickets`,
  `Fiches_HisLigTickets`, `Fiches_Parametres`, `Fiches_Marques`, `Fiches_Centrales`.
- Fichiers : `~/tmp/stockmvt.pdf`, `~/tmp/Stockmvt.csv`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **`Buttrait_Click` (CC 75)** : remplacer les 40 variables `champ*/fichier*/cond*/lib*` par une
  petite structure par source (tableau de descripteurs : table d'en-tête, table de lignes, colonne
  date, colonne code, colonne famille, colonne quantité, sens du signe, libellé) et des boucles.
  Le SQL produit doit rester **identique à l'octet près** (diff `Exec_SQL` bloquant) : à découper
  en plusieurs étapes (filtres, champs, assemblage).
- Renommer la méthode privée `TriArticles` (homonyme de la classe) en `RemplitArbreFamilles`.
- Supprimer `$soption`, rendre `$rpt` local.

### Commonalisation avec d'autres fichiers

- Définition des sources de mouvements partagée avec
  [`Cstock`](../../Utils/Cstock.module/architecture.md) (voir tableau) : une description commune des
  sources (tables, colonnes, signe) servirait aux deux, **sans** aligner les règles divergentes
  (anomalie A05).
- `Utils.fam` : corriger UTILS-A02 côté `Utils` profite aussi à `Histocliart`.
- Édition PDF « grille → Report » : motif réutilisable (`Butedit_Click`, `nlab`) avec les autres
  écrans statistiques (`gridvi`, `Tregie`) : à évaluer en phase 3.
- Export CSV : socle `ImpExp` des notes transverses.

### Réduction de portée

- Aucune fonction `Public` réductible : toutes sont des handlers (`deps.py` : `scope_reducible`
  vide). `Bsel`/`Bval` restent `Public`.

### Séparation traitement / GUI

- Extraire `ConstruitRequete(criteres) As String` (pur, testable en gb.test) : les handlers lisent
  les contrôles dans une structure de critères, la fonction renvoie le SQL. C'est le levier
  principal pour tester l'écran sans GUI.
- Extraire le calcul des totaux d'`affiche` et la génération CSV de `Butexp_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les quantités et montants stockés en texte avec virgule imposent `REPLACE(…, ',', '.')` et des
  comparaisons de chaînes (`qte > '0'`) : des colonnes `DECIMAL` rendraient les filtres exacts et
  indexables.
- Une table unique des mouvements de stock (journal alimenté à chaque BL, facture, réception,
  ticket, mouvement exceptionnel, transfert) remplacerait les 10 sous-requêtes et unifierait
  `Stockmvt`, `Cstock` et `Validinv`.
