# TBord — Architecture

> Source : `.src/Statistiques/TBord.class`

## Vue d'ensemble

`TBord` est l'écran **« Tableau de bord »** de la gestion commerciale, ouvert par le menu
(`Fmenu.class:2068`, `TBord.Show()` sur l'auto-instance) ou par le dispatcher `Prgm` (nom saisi
`Tbord`, `Prgm.class:70`). Tout le calcul est lancé **dans le constructeur** (`_new` → `Traitement`) :
l'écran n'a ni saisie ni paramètre, seulement un bouton **Quitter**.

Il affiche trois blocs :

| Bloc | Indicateur (contrôle) | Source | Calcul |
|---|---|---|---|
| Histogramme (`drwChart`) | CA HT mensuel sur 12 mois glissants, en milliers (`K` + initiale de la devise) | table de travail `Total`, colonne `totfac` | une barre par ligne de `Total` (un mois), libellés de mois à partir du mois de `dte1` |
| Statistiques ventes période (HT) | Total CA (`CAHT`) | somme de `Total.brutfac` | brut = net (`totfac`/`totalht`) + remises article et MO |
| | Panier moyen (`Panier`) | `Total CA / Σ Total.nb` | `nb` = nombre de documents (factures + BL facturés) |
| | Marge articles / MO (`Mrgart`, `Mrgmo`) | somme `marge_art` / `marge_mo` | valeurs stockées dans les en-têtes de facture/BL |
| | Taux de marge (`TMrgart`, `TMrgmo`, `Totmarge`) | marge / **Total CA brut** × 100 | |
| | Total marge (`Totmrg`) | marge articles + marge MO | |
| Documents clients en cours (HT) | Nombre et montant par type : Proforma `P`, Devis `D`, Commande `C`, BL `B`, Facture `F` (`Npro`/`Tpro` … `Nfac`/`Tfac`) | `Fiches_Bl` (via `Cbase.Table("TabBl")`), **toutes dates**, `totalht IS NOT NULL` | parcours trié par `type`, cumul par rupture (`Aff_Mois`) |
| | Total commandes, BL, factures (`Tdocs`) | `Tcom + Tbl + Tfac` relus depuis les libellés | |

La période est fixe : `dte1` = 1ᵉʳ jour du mois M-11 (`DateAdd(Now, an, -1)` puis +1 mois), `dte2` =
aujourd'hui. Les sources de la période sont :
- `Fiches_HistoFac` (factures historisées, colonne `datefac`) et, si `/Soc<XX>/Materiel` est actif,
  `Fiches_HistoFacM` (même structure, `UNION`) ;
- `Fiches_Bl` de type `F` imprimées (`imp = 1`, factures non encore historisées, colonne `dtefac`) et,
  si matériel, `Fiches_BlM`.

Nature globale : **mixte** ; le calcul (SQL + cumul dans `Total`) et l'affichage (labels, dessin)
sont entremêlés dans `Traitement`. Aucun `Utils.Observers(Me)` : l'écran n'est pas instrumenté pour
le log/replay.

### Table de travail `Total` (hors `db_control.csv`)

`Traitement` exécute `DROP TABLE IF EXISTS Total` puis `CREATE TABLE Total (brutfac, rmfac, totfac,
marge_art, marge_mo, margepart, margepmo Decimal(12,2), date Datetime, nb integer, PRIMARY KEY(date))`
\+ `Utils.db.Engine()`. Une ligne par **mois** (clé logique `MONTH(date)`, la clé physique est la date
du premier document rencontré dans le mois). Cette table :
- n'est pas déclarée dans `db_control.csv` ni dans `Cbase` (nom en dur, pas de préfixe société) ;
- porte le **même nom** que les tables de travail de `StatClimo`, `StatComm`, `StatComArt`, `StatFour`,
  `StatTypCli`, `HitCarte` (Statistiques) et `Statcai` (Caisse), avec des **structures différentes**
  (voir STATCAI-A04) ; elle est partagée entre postes sur MySQL ;
- reste en base après fermeture (elle apparaît dans le dump, ce qui sert au replay).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `son` | var | Private |  | Integer | 3 |
| `dte1` | var | Private |  | String | 4 |
| `dte2` | var | Private |  | String | 5 |
| `value` | var | Private |  | Float[] | 6 |
| `TotM` | var | Private |  | Integer | 7 |
| `nb` | var | Private |  | Integer | 8 |
| `Periode` | var | Private |  | String | 9 |
| `Mat` | var | Private |  | String | 10 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 12-26 | Public | 1 | 12 | 0 | méthode spéciale |
| `Traitement` | 28-251 | Public | 49 | 220 | 0 | portée réductible ? |
| `Aff_Mois` | 253-276 | Public | 6 | 22 | 0 | portée réductible ? |
| `Draw_Chart` | 278-359 | Public | 10 | 74 | 0 | portée réductible ? |
| `Button1_Click` | 361-365 | Public | 1 | 3 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new()`** [portée : nécessaire (spéciale)] [nature : mixte]. Centre la fenêtre, lit
  `Fiches_Parametres` (`Cbase.Table("TabParam")`) **sans utiliser le résultat** (requête morte),
  calcule `dte1`/`dte2`/`Periode`, écrit le titre `Label28`, charge le son (`Variables.Musique`,
  `Variables.son`) puis appelle `Traitement()`. Note : `son` est initialisé à `Start.Son` puis
  remplacé par `Variables.son`.
- **`Traitement()`** (CC 49, LOC 220) [portée : réductible] [nature : mixte].
  1. Recrée `Total` (voir ci-dessus).
  2. Test `If dte1 <> "" Or … Or dte2 <> "" …` **toujours vrai** (les dates sont fixées dans `_new`) :
     la branche `Else` (son + « Veuillez saisir une date SVP ! ») est morte.
  3. Factures historisées : `SELECT * FROM Fiches_HistoFac where datefac >= &1 and datefac <= &2 order by
     datefac` (+ `union SELECT * FROM Fiches_HistoFacM …` si `Mat <> 0`). Pour chaque facture : remises
     `remmofac`/`remartfac` (varchar, `Val` puis repli sur l'affectation brute), `Total = Val(cpoint(totfac))`,
     `Brut = Total + Remise`, marges et taux (dans des `Try`). Puis `SELECT * FROM Total where
     MONTH(date) = MONTH(&1)` : si le mois existe, cumul et `UPdate Total set … nb = &9 Where
     MONTH(date) = MONTH(&8)`, sinon `INSERT INTO Total … VALUES (&1 … &9)`.
  4. BL facturés : `SELECT * FROM Fiches_Bl where dtefac >= &1 and dtefac <= &2 and type = 'F' and imp = 1
     order by dtefac` (+ `Fiches_BlM` si matériel) ; même cumul dans `Total` (bloc **dupliqué** des
     lignes 103-121 → 161-179, sans `Try` sur les divisions des lignes 168 et 172).
  5. Agrégats : `SELECT * FROM Total` **sans `ORDER BY`** ; remplit `value[1..n]` (`totfac`), cumule `nb`,
     marges, `margepart`/`margepmo` (cumulés mais jamais affichés) et `Totca` (somme `brutfac`) ;
     appelle `Draw_Chart()` puis écrit les 8 libellés du bloc ventes (divisions par `Totca` et `nb`
     non protégées).
  6. Documents en cours : `SELECT * FROM Fiches_Bl where totalht is not NULL order by type`, cumul par
     rupture de `type`, `Aff_Mois(n, type, total)` à chaque rupture et à la fin, puis `Tdocs`.
     ⚠️ À la rupture, la ligne courante (premier document du nouveau type) est **comptée** (`Inc n`) mais
     son `totalht` n'est **pas ajouté** (le test `type = rResult!type` de la ligne 236 est évalué avant
     la mise à jour de `type`) : tous les montants sauf ceux du premier type sont sous-évalués d'un
     document (anomalie TBORD-A01).
  Tables : `Total` (DDL + DML), `Fiches_HistoFac`, `Fiches_HistoFacM`, `Fiches_Bl`, `Fiches_BlM` (noms
  en dur sauf le dernier `SELECT` via `Cbase.Table("TabBl")`). État global : `Start.LocalSettings
  ["/Soc<XX>/Materiel"]` (lu dans le membre `Mat`, String comparée à `0` : comportement si la clé est
  absente à confirmer), `Utils.Cdate_Dbase`, `Utils.cpoint`, `Utils.PointBase`, `Utils.db.Engine`.
  Partie extractible : tout le calcul des étapes 1 à 5 (remplissage de `Total` et agrégats) et le
  cumul des documents en cours ; la partie GUI se limite à `Me.Mouse`, au message et aux libellés.
- **`Aff_Mois(n, type, total)`** [portée : réductible] [nature : GUI]. Malgré son nom, écrit le nombre
  et le montant (`Format$(…, "0.00")`) d'un **type de document** dans les libellés `Npro/Tpro`,
  `Ndev/Tdev`, `Ncom/Tcom`, `Nbl/Tbl`, `Nfac/Tfac` (5 `If` successifs, un `Select Case` suffirait).
- **`Draw_Chart()`** [portée : réductible] [nature : mixte]. Relit `Fiches_Parametres` (devise ;
  `If rResult Then` teste l'objet et non `Available`), divise `value[i]` par 1000 (ou par **100 000**
  si `/Soc<XX>/Prxdec` est vrai : facteur à confirmer), puis dessine sur `drwChart` (API `Draw`) :
  axe Y gradué par pas de `Floor(max/10)+1` en « K<devise> », 12 barres colorées
  `color.RGB(i*100, i*10, i*50)` (composantes > 255 pour i ≥ 3), libellés de mois incrémentés depuis
  `Mid$(Periode, 4, 2)`. `colors[]` et `sumdata` sont calculés sans être utilisés ; `Wait 0.1` dans le
  `Draw.Begin/End`.
- **`Button1_Click()`** [portée : nécessaire (handler)] [nature : GUI] : `Me.Close`.

## État global utilisé

- `Start.Son`, `Start.Societe`, `Start.LocalSettings["/Soc<XX>/Materiel"]`, `["/Soc<XX>/Prxdec"]`.
- `Variables.Musique`, `Variables.son` (et non `Start.Musique` comme les autres écrans du lot).
- `Utils.db`, `Utils.Cdate_Dbase`, `Utils.cpoint`, `Utils.PointBase`, `Cbase.Table("TabParam"|"TabBl")`.
- Table de travail partagée `Total`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser le cumul mensuel dupliqué (factures / BL) dans un helper privé
  `CumuleMois(Dte, Brut, Remise, Total, MargeArt, MargeMo, bTry)` : `SELECT` du mois, puis `UPdate`
  ou `INSERT` dans `Total`. Le paramètre `bTry` conserve la différence actuelle (divisions protégées
  ou non).
- Supprimer la requête morte de `_new`, la condition toujours vraie et sa branche `Else`, `colors`,
  `sumdata`, le cumul de `margepart`/`margepmo` non affiché.
- `Aff_Mois` → `Select Case`, renommé à terme (le nom actuel est trompeur ; renommage interne sans
  appelant externe).
- Noms de tables via `Cbase.Table("TabHisFac" | "TabHisFacm" | "TabBl" | "TabBlM")` (texte SQL identique).

### Commonalisation avec d'autres fichiers

- `Draw_Chart` (histogramme sur `DrawingArea`, routine « Yudi Astira ») est recopié avec des variantes
  dans [`VisHitCartes`](../VisHitCartes.class/architecture.md) : un helper commun
  `Histogramme(drw, valeurs, libelles, echelle)` dans un module graphique (emplacement à décider en
  phase 3) éviterait les deux copies. Les deux variantes divergent (échelle en K€ ici, en dixièmes du
  total là-bas) : fusion seulement après tests de rendu.
- Création de la table de travail `Total` : le même motif `DROP`/`CREATE` existe dans
  [`HitCarte`](../HitCarte.class/architecture.md), `StatClimo`, `StatComm`, `StatComArt`, `StatFour`,
  `StatTypCli` et [`Statcai`](../../Caisse/Statcai.class/architecture.md) avec des structures
  différentes. Le socle `StatCommun.module` proposé dans [`StatComm`](../StatComm.class/architecture.md)
  prévoit `TotalCree`, point unique de création de `Total` à partager avec `HitCarte` et `Statcai` ;
  le renommage ou la séparation des structures relève de STATCAI-A04 (anomalie, changement du dump).
- Lecture des factures de la période : `StatCommun.Factures`/`Documents` (même socle) couvrent la
  lecture `Fiches_HistoFac` (+ `M`) et `Fiches_Bl` de `Traitement`.
- Lecture de la devise (`Fiches_Parametres.devise`) : à mutualiser avec les autres lecteurs de
  `TabParam` si un accesseur est créé côté `Utils` (phase 3).

### Réduction de portée

- `Traitement`, `Aff_Mois`, `Draw_Chart` : aucun appelant externe (vérifié par `grep -rn`) →
  `Private`. Le comportement reste couvert par le replay d'ouverture.

### Séparation traitement / GUI

- `Traitement` → `RemplitTotal(dte1, dte2, bMateriel)` (étapes 1 à 4, SQL seul),
  `LitAgregats() As Float[]` (étape 5, sans contrôle), `DocsEnCours() As Collection` (étape 6, nombre
  et montant par type) ; le handler garde `Me.Mouse`, `Draw_Chart` et l'écriture des libellés.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Remplacer la table physique `Total` par une requête d'agrégat (`GROUP BY YEAR(datefac),
  MONTH(datefac)` sur l'union factures/BL) ou par une table temporaire de session : plus de collision
  entre écrans ni entre postes.
- `remmofac`/`remartfac` sont des `varchar(10)` (valeurs avec virgule possibles) : un type `DECIMAL`
  supprimerait les `Val`/`Try` de conversion.
- `Fiches_Bl.totalht` est un `double` alors que `totfac` est `decimal(12,2)` : harmoniser.
