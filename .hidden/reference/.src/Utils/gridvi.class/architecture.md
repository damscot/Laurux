# gridvi — Architecture

> Source : `.src/Utils/gridvi.class`

## Vue d'ensemble

`gridvi` construit **dynamiquement** un onglet « Statistiques » dans le `TabStrip` d'une fiche
(article, client, famille, main d'œuvre, tournée) et y affiche un **tableau comparatif annuel** :
12 lignes de mois (dans l'ordre de l'exercice, à partir du mois qui suit la clôture `dteclec`) +
1 ligne TOTAL, et 4 exercices × 3 colonnes (C.A HT, Quantité, Marge), soit 12 colonnes.

Le type de statistique est fixé à la construction (`New Gridvi(TabStrip, type)`) :

| Type | Appelant | Critère SQL (factures / BL) | Marge sommée |
|---|---|---|---|
| `A` | `Articles` | `code_ligfac` / `code_ligbl`, lignes `A` (factures) | `mrgart` |
| `M` | `Movr` | `code_ligfac` / `code_ligbl`, lignes `M` (factures) | `mrgmo` |
| `F` → `S` | `Famille` | `fam_ligfac = code` (F) ou `LOCATE(code, fam) = 1` (S, sous-familles) | `mrgart + mrgmo` |
| `C` | `FClient` | `cdclifac` / `cdclibl` | `mrgart + mrgmo` |
| `T` | `Ttourne` | `tour_ligfac` / `tour_ligbl` | `mrgart + mrgmo` |

Le code de la fiche (`code`) et le format des quantités (`dec`, ex. `"0.000"`) sont fournis par
l'appelant via deux propriétés. Le calcul est déclenché par le bouton « Calcul » créé dans
l'onglet (`bouton_Click`) ou directement par l'appelant. Pour le type `C`, une sélection de mois
à la souris ouvre une **fenêtre modale de détail par article** (`grdv_MouseUp`).

Les données sont lues dans 8 tables documentaires (factures et BL, archives `…M` comprises) :
`Fiches_HistoFac`/`HistoLigfac`, `Fiches_HistoFacM`/`HistoLigfacM`, `Fiches_Bl`/`Ligbl`,
`Fiches_BlM`/`LigblM`, plus `Fiches_Parametres` (dates d'exercice), `Fiches_Art` et `Fiches_Mo`
(désignations). Tous les noms de tables sont **écrits en dur** (pas de `Cbase.Table`).

Nature globale : **mixte**, avec un fort couplage entre le SQL, les calculs de dates et
l'écriture directe dans les cellules du `GridView`. Aucune écriture en base.

Variantes : [`gridvi2`](../gridvi2.class/architecture.md) (ancienne version, code mort) et
[`gridv`](../gridv.module/architecture.md) (module, code mort) dupliquent une grande partie du code
(voir « Commonalisation »).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `$grdv` | var | Private |  | GridView | 3 |
| `$tab` | var | Private |  | TabStrip | 4 |
| `$lab` | var | Private |  | Label | 5 |
| `$sdec` | var | Private |  | String | 6 |
| `$scode` | var | Private |  | String | 7 |
| `$stype` | var | Private |  | String | 8 |
| `$ideb` | var | Private |  | Integer | 9 |
| `$ifin` | var | Private |  | Integer | 10 |
| `code` | property | Public |  | String | 12 |
| `dec` | property | Public |  | String | 13 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 15-93 | Public | 7 | 65 | 0 | méthode spéciale |
| `bouton_Click` | 96-245 | Public | 25 | 130 | 3 | handler GUI |
| `sousfam_click` | 247-262 | Public | 2 | 14 | 0 | handler GUI |
| `requete` | 264-279 | Private | 2 | 13 | 0 |  |
| `affent` | 281-311 | Private | 7 | 27 | 0 |  |
| `razcol` | 313-330 | Public | 5 | 15 | 4 |  |
| `grdv_MouseUp` | 332-517 | Public | 15 | 161 | 0 | handler GUI |
| `affdon` | 519-559 | Private | 10 | 35 | 0 |  |
| `calcanne` | 561-574 | Private | 3 | 11 | 0 |  |
| `code_Read` | 576-580 | Private | 1 | 3 | 0 |  |
| `code_Write` | 582-586 | Private | 1 | 3 | 0 |  |
| `dec_Read` | 588-592 | Private | 1 | 3 | 0 |  |
| `dec_Write` | 594-598 | Private | 1 | 3 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_new(TabStrip1, type)`** [portée : nécessaire] [nature : GUI + lecture `Fiches_Parametres`].
  Ajoute un onglet si le `TabStrip` en a déjà plus d'un (sinon réutilise l'onglet courant), le
  renomme « Statistiques », crée un `Panel` (label titre, bouton « Calcul » `As "bouton"`, et pour
  le type `F` un bouton « Familles » `As "sousfam"` qui bascule le type en `S`), puis le `GridView`
  `As "grdv"` (sélection multiple pour le type `C`). Lit `Fiches_Parametres` (`dteclec`, `dtepec`),
  calcule l'année de fin d'exercice (`calcanne`), dessine les en-têtes (`affent`) et les libellés de
  mois (`Utils.mois`). Remet l'onglet 0 actif.
  SQL : `SELECT * FROM Fiches_Parametres`. ⚠️ `dteclec` est une colonne `date` : `Split(res!dteclec, "/")`
  repose sur la conversion implicite Date → String (`MM/JJ/AAAA …`), d'où `sdte[0]` = mois et
  `Left$(sdte[2], 4)` = année.

### Calcul du tableau

- **`bouton_Click()`** [portée : nécessaire, handler GUI du bouton « Calcul » **et** appelé par
  `Articles`, `Famille`, `Movr`] [nature : mixte, CC 25, max du fichier]. Ne fait rien si l'onglet
  courant n'est pas « Statistiques ». Remet la grille à zéro (`razcol`, appelé deux fois), passe le
  curseur en attente, relit `Fiches_Parametres`, reconstruit la date de clôture via `LDate`, puis
  parcourt 4 exercices × 12 mois. Pour chaque mois, il construit un couple (`req`, `cond`) selon
  `$stype` et appelle `requete` quatre fois : factures, factures archivées (`…M`), BL, BL archivés.
  Enfin il totalise chaque colonne (`Utils.totobs`) dans la ligne 12.
  SQL (par mois et par source) :
  `SELECT SUM(CASE … REPLACE(mrgart_…, ',', '.') …) AS marge, SUM(… netht_…) AS ht, SUM(… qte_…) AS qte
  FROM <lignes>,<entêtes> WHERE <critère> AND num… AND typel_… IN ('A','M') AND date… BETWEEN &2 AND &3`.
  Les BL sont filtrés sur `type IN ('A','B','F')`. Soit **192 requêtes** par calcul (4 × 12 × 4).
  Code mort : `smoiscour`, `smoisprec`, `scle`, `k` (sauf boucle), `datesup` calculé deux fois
  (ligne 149 écrasée ligne 150), test `IsNull($grdv[j, i].Text)` toujours faux après `razcol`.
  ⚠️ `If Not respar.Available Then Return` laisse le curseur en attente et le titre « CALCUL EN COURS ».
  ⚠️ Type `S` : `LOCATE()` n'est pas traduit par `DB_Connection` pour SQLite.
- **`sousfam_click()`** [portée : nécessaire, handler GUI] [nature : GUI]. Bascule `Last.Tag`
  0/1, le texte et l'icône du bouton, et `$stype` entre `S` et `F`, puis relance `bouton_Click`.
- **`requete(tab, tab1, req, cond, dateinf, datesup, i, j)`** [privé] [nature : mixte].
  Exécute `SELECT req FROM tab, tab1 WHERE cond` avec `$scode`, `dateinf`, `datesup` et ajoute
  `ht`, `qte`, `marge` aux cellules `[j, i..i+2]` (`Utils.totobs`, formats `-#######0.00`,
  `-######<dec>`, `-#####0.00`). Les noms de tables et les fragments SQL sont concaténés (valeurs
  paramétrées par `&1..&3`).
- **`razcol()`** [portée : nécessaire, appelée par `Articles`, `FClient`, `Famille`, `Movr`]
  [nature : GUI]. Met toutes les cellules (13 × 12) à `"0"`, alterne la couleur de fond par ligne
  (`Color.Background - 100` pour les lignes impaires), aligne à droite et colore la ligne TOTAL
  (`&HDFBFFF`).

### Fenêtre de détail (type `C`)

- **`grdv_MouseUp()`** [portée : nécessaire, handler GUI] [nature : mixte, CC 15, 186 lignes].
  Hors type `C` : `Stop Event`. Sinon, borne la sélection de mois (`$ideb`, `$ifin`, la ligne TOTAL
  ramène à 0..11), crée une `Window` + `GridView`, relit `Fiches_Parametres` (⚠️ sans test
  `Available`), calcule la période sélectionnée sur les 4 exercices (`dateinf`, `datesup`,
  `d1`..`d6`) puis :
  1. liste les articles mouvementés par le client (`UNION ALL` des 4 sources, `GROUP BY art_code`) ;
  2. pour chaque article, cherche la désignation dans `Fiches_Art` puis `Fiches_Mo`
     (« INCONNU » sinon) : **2 requêtes par article** (N+1) ;
  3. pour chaque article et chaque exercice, exécute la même requête `UNION ALL` des 4 sources
     (4 copies quasi identiques du SQL, lignes 451-508) et cumule via `affdon`.
  Affiche la fenêtre en modal. ⚠️ Il manque un espace entre `&4` et `"UNION ALL"` (lignes 460,
  475, 490, 505) : la requête produite contient `… AND '<date>'UNION ALL …`, accepté par MySQL.
- **`affdon(grdv1, resbl, i, j)`** [privé] [nature : mixte]. Initialise 3 cellules (`0.00`,
  `0.000`, `0.00`, couleurs alternées), puis cumule `ht`, `qte` et `marge` (ou `margem`) de chaque
  ligne du résultat. ⚠️ Comme le filtre SQL ne garde que les lignes `A`/`M`, la branche `margem`
  n'est jamais prise : pour les lignes de main d'œuvre, c'est `mrgart_*` qui est cumulé (à confirmer).

### En-têtes et dates

- **`affent(grdv, sdte)`** [privé] [nature : GUI]. Dessine les 12 en-têtes : pour chaque exercice
  `i` (0..3), « AAAA/AAAA-1 C.A » (ou « AAAA C.A » si l'exercice finit en décembre), « Quantité »,
  « Marge », avec des largeurs fixes 110/90/80. Le paramètre s'appelle `$grdv` et masque le membre.
- **`calcanne(dte, dtem)`** [privé] [nature : calcul pur]. Compare la période en cours `dtepec`
  (`MM.AAAA`) à la date de clôture ; renvoie l'année de fin de l'exercice courant (année + 1 si la
  période en cours est dans l'année de clôture). Candidate idéale à un test unitaire après extraction.
- **`code_Read`/`code_Write`, `dec_Read`/`dec_Write`** [privé] : accesseurs des propriétés `code`
  (`$scode`) et `dec` (`$sdec`).

## État global utilisé

- `Utils.db` (toutes les requêtes), `Utils.mois`, `Utils.lastday`, `Utils.totobs` (somme de
  chaînes, dépendante de la locale française : remplace `.` par `,` puis `IsNumber`).
- `LDate` (`DT`, `FinMois`, `FinJour`, `Month`, `Day`, `Year`).
- Icônes `Icones/find.png`, `Icones/down2.png`, `Icones/up2.png`.
- `Last` dans `sousfam_click`.

## Propositions d'amélioration

### Réécriture / refactorisation

- **Table de critères** : les 12 couples (`req`, `cond`) de `bouton_Click` ne diffèrent que par
  l'expression de marge (`mrgart`, `mrgmo` ou somme), le critère (`fam`, `LOCATE`, `code`,
  `cdcli`, `tour`), le suffixe de colonnes (`ligfac`/`ligbl`) et le filtre BL. Une fonction privée
  `CritereStat(stype, source) As String[]` produirait les mêmes chaînes (CC 25 → ≤ 8).
- **Requête de détail** : les 4 copies du `UNION ALL` de `grdv_MouseUp` deviennent une fonction
  privée `DetailArticle(code, art, deb, fin) As Result` (−45 lignes environ), en ajoutant l'espace
  manquant avant `UNION ALL` (sans effet sur le résultat MySQL).
- **Désignations** : remplacer la boucle N+1 (`Fiches_Art` puis `Fiches_Mo`) par une requête
  unique ou un cache `Collection` local, avec le même repli « INCONNU ».
- Supprimer le code mort de `bouton_Click` (variables inutilisées, `datesup` ligne 149, second
  `razcol`, test `IsNull` toujours faux).
- Remplacer les noms de tables en dur par `Cbase.Table("TabHisFac")`, `("TabHisFacm")`,
  `("TabHisLigFac")`, `("TabHisLigFacm")`, `("TabBl")`, `("TabLigbl")`, `("TabBlM")`, `("TabLigblM")`,
  `("TabParam")`, `("TabArt")`, `("TabMo")` : le mapping est l'identité, le SQL émis est inchangé.

### Commonalisation avec d'autres fichiers

Duplication mesurée (comparaison ligne à ligne, espaces de fin ignorés) :

| Fonction | `gridvi` | [`gridvi2`](../gridvi2.class/architecture.md) | [`gridv`](../gridv.module/architecture.md) |
|---|---|---|---|
| `affent` (31 l.) | référence | **identique** | boucle d'en-têtes **identique** (25 l., inline dans `ajoustat`) |
| `razcol` (18 l.) | référence | **identique** | — |
| `calcanne` (14 l.) | référence | **identique** | — |
| accesseurs `code`/`dec` (23 l.) | référence | identiques (casse de `Value` seule) | — |
| `affdon` (41 l.) | référence | 6 lignes sur 41 diffèrent (`CFloat` au lieu de `totobs`, types `A`/`E`) | — |
| libellés de mois de `_new` (10 l.) | référence | identiques | **identiques** |
| `_new` (79 l.) | référence | 28 lignes de diff (bouton Familles, `Prxdec`) | ~60 % commun |
| `bouton_Click`, `grdv_MouseUp`, `requete` | référence | même squelette, SQL différent (ancien) | — |

Soit **86 lignes strictement identiques** entre `gridvi` et `gridvi2` et 35 lignes identiques avec
`gridv`. Comme `gridvi2` et `gridv` n'ont **aucun appelant** (vérifié par `grep -rni`), la
commonalisation la plus simple est leur **suppression** (GRIDVI2-001, GRIDV-001), qui ne touche pas
`gridvi`.

Autre candidat inter-fichiers : [`Tregie`](../../Gestion/option/Tregie.class/architecture.md)
(`affent`, lignes 42-96) reproduit le même dessin de grille (12 mois + TOTAL, en-têtes par
exercice « AAAA/AAAA-1 ») avec 4 sous-colonnes (S.I, Entrées, Sorties, S.F). Un helper commun
`StatGrille.Entetes(grdv, sdte, libellés[], largeurs[], suffixe)` et `StatGrille.Mois(grdv, sdte)`
(module à créer en phase 3) servirait aux deux fichiers. `calcanne` pourrait rejoindre `LDate`
(calcul d'exercice, voir [`LDate`](../LDate.class/architecture.md)).

### Réduction de portée

- Aucune : `razcol` et `bouton_Click` sont appelés par les fiches, `sousfam_click`/`grdv_MouseUp`
  sont des handlers, `code`/`dec` sont utilisés par les 5 appelants. `bouton_Click` est un handler
  appelé directement : son nom ne peut pas changer.

### Séparation traitement / GUI

- `calcanne` et le calcul des bornes `dateinf`/`datesup`/`d1`..`d6` de `grdv_MouseUp` →
  fonction pure `BornesDetail(dteclec, dtepec, ideb, ifin) As Date[]`, testable en gb.test.
- `requete` et `affdon` : séparer la lecture (renvoyer `ht`, `qte`, `marge` en `Float[]`) de
  l'écriture dans la grille ; le cumul reste dans le handler.
- Le titre et le curseur d'attente restent dans `bouton_Click`.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les montants (`netht_*`, `qte_*`, `mrgart_*`, `mrgmo_*`) sont stockés en texte avec virgule, d'où
  les `REPLACE(…, ',', '.')` et `CASE WHEN … IS NULL` systématiques : des colonnes `DECIMAL`
  non nulles simplifieraient toutes les sommes.
- Une table ou vue d'agrégats mensuels (par article, client, famille, tournée) éviterait les
  192 requêtes par calcul ; une vue `UNION ALL` des 4 sources (factures, BL, archives) éviterait de
  dupliquer chaque requête quatre fois.
- Index composites `(cdclifac, datefac)`, `(code_ligfac)`, `(fam_ligfac)` sur les tables
  d'historique, à vérifier avec `DB_Sanity`.
