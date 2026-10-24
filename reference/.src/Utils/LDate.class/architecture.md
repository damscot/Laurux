# LDate — Architecture

> Source : `.src/Utils/LDate.class`

## Vue d'ensemble

`LDate` est l'**objet date de référence** de Laurux. Il encapsule une `Date` Gambas privée (`Dte`)
et expose des propriétés de format :

| Propriété | Format | Usage |
|---|---|---|
| `L` / `LT` | `dd.mm.yyyy` / `dd.mm.yyyy hh:nn` | affichage Laurux (lecture/écriture) |
| `D` / `DT` | `yyyy-mm-dd` / `yyyy-mm-dd hh:nn:ss` | base de données (lecture/écriture) |
| `G` / `GnT` | `Date` Gambas / `Date` sans heure | calculs (lecture/écriture) |
| `F` / `FT` | `yyyymmdd` / `yyyymmdd-hhnnss` | noms de fichiers (lecture) |
| `Day`, `Week`, `Month`, `Year`, `Year2`, `WeekDay(3)`, `MonStr(3)` | composants | lecture |
| `FinMois`, `FinJour` | dernier jour du mois / dernière milliseconde du jour | lecture |
| `PDeb`, `PFin` | début / fin de période (mois) | lecture |
| `EDeb`, `EFin`, `EInd` | début, fin et index (0…5) de l'exercice comptable contenant la date | lecture, **requête SQL** |

L'objet est `Export` et `Create Static` : `LDate(…)` passe par `_call` (fabrique) ; les méthodes
statiques `LDate.DateFilterDB(…)` sont appelées sur l'auto-instance. Le constructeur accepte une
`Date`, une chaîne (analysée par `Parse`, formats Laurux, DB et `yyyymmddHHMMSS`), une année et
ses composants, ou rien (`Now`).

Les écritures de propriétés lèvent l'événement `change` ; seul `TextReg` l'observe
(`Public dte As New LDate As "dte"`, `TextReg.class:11`, handler `dte_change`).

Les propriétés d'exercice (`EDeb`, `EFin`, `EInd`) et `Exercice_Cloture` lisent les dates de
clôture `dteclec`, `dteclec1` … `dteclec5` de `Fiches_Parametres` (via `Cbase.Table("TabParam")`)
**à chaque appel**.

Nature globale : **calcul**, avec trois couplages : `Message.Error` dans `_New` et `Parse`, et
accès SQL dans les fonctions d'exercice.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Dte` | var | Private |  | Date | 5 |
| `change` | event | Public |  |  | 7 |
| `L` | property | Public |  | String | 9 |
| `LT` | property | Public |  | String | 10 |
| `G` | property | Public |  | Date | 11 |
| `GnT` | property | Public |  | Date | 12 |
| `D` | property | Public |  | String | 13 |
| `DT` | property | Public |  | String | 14 |
| `FinMois` | property | Public |  | LDate | 15 |
| `FinJour` | property | Public |  | LDate | 16 |
| `Day` | property | Public |  | Integer | 17 |
| `WeekDay` | property | Public |  | String | 18 |
| `WeekDay3` | property | Public |  | String | 19 |
| `Week` | property | Public |  | Integer | 20 |
| `Month` | property | Public |  | Integer | 21 |
| `MonStr` | property | Public |  | String | 22 |
| `MonStr3` | property | Public |  | String | 23 |
| `Year` | property | Public |  | Integer | 24 |
| `Year2` | property | Public |  | Integer | 25 |
| `F` | property | Public |  | String | 26 |
| `FT` | property | Public |  | String | 27 |
| `EDeb` | property | Public |  | LDate | 29 |
| `EFin` | property | Public |  | LDate | 30 |
| `EInd` | property | Public |  | Integer | 31 |
| `PDeb` | property | Public |  | LDate | 33 |
| `PFin` | property | Public |  | LDate | 34 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_New` | 43-68 | Public | 8 | 22 | 0 | méthode spéciale |
| `_call` | 70-77 | Public | 1 | 5 | 57 | méthode spéciale |
| `DateFilterDB` | 79-185 | Public | 20 | 99 | 2 |  |
| `Parse` | 192-290 | Private | 20 | 94 | 0 |  |
| `prd` | 292-297 | Private | 2 | 4 | 0 |  |
| `L_Read` | 303-307 | Private | 1 | 3 | 0 |  |
| `LT_Read` | 309-313 | Private | 1 | 3 | 0 |  |
| `L_Write` | 315-322 | Private | 2 | 6 | 0 |  |
| `LT_Write` | 324-331 | Private | 2 | 6 | 0 |  |
| `D_Read` | 333-337 | Private | 1 | 3 | 0 |  |
| `D_Write` | 339-346 | Private | 2 | 6 | 0 |  |
| `DT_Read` | 348-353 | Private | 1 | 3 | 0 |  |
| `DT_Write` | 355-362 | Private | 2 | 6 | 0 |  |
| `G_Read` | 364-368 | Private | 1 | 3 | 0 |  |
| `G_Write` | 370-377 | Private | 2 | 6 | 0 |  |
| `GnT_Read` | 379-383 | Private | 1 | 3 | 0 |  |
| `GnT_Write` | 386-393 | Private | 2 | 6 | 0 |  |
| `EDeb_Read` | 395-399 | Private | 1 | 3 | 0 |  |
| `EFin_Read` | 401-405 | Private | 1 | 3 | 0 |  |
| `EInd_Read` | 407-411 | Private | 1 | 3 | 0 |  |
| `PDeb_Read` | 413-417 | Private | 1 | 3 | 0 |  |
| `PFin_Read` | 419-423 | Private | 1 | 3 | 0 |  |
| `FinMois_Read` | 425-429 | Private | 1 | 3 | 0 |  |
| `FinJour_Read` | 431-435 | Private | 1 | 3 | 0 |  |
| `Day_Read` | 437-441 | Private | 1 | 3 | 0 |  |
| `WeekDay_Read` | 443-450 | Private | 1 | 5 | 0 |  |
| `WeekDay3_Read` | 452-459 | Private | 1 | 5 | 0 |  |
| `Week_Read` | 461-465 | Private | 1 | 3 | 0 |  |
| `Month_Read` | 467-471 | Private | 1 | 3 | 0 |  |
| `MonStr_Read` | 473-478 | Private | 1 | 4 | 0 |  |
| `MonStr3_Read` | 480-485 | Private | 1 | 4 | 0 |  |
| `Year_Read` | 487-491 | Private | 1 | 3 | 0 |  |
| `Year2_Read` | 493-497 | Private | 1 | 3 | 0 |  |
| `F_Read` | 499-503 | Private | 1 | 3 | 0 |  |
| `FT_Read` | 505-509 | Private | 1 | 3 | 0 |  |
| `Apres` | 515-537 | Public | 4 | 18 | 7 |  |
| `Avant` | 540-562 | Public | 4 | 18 | 5 |  |
| `Fin_Mois` | 564-573 | Public | 1 | 7 | 0 | portée réductible ? |
| `Fin_Jour` | 575-584 | Public | 1 | 7 | 1 |  |
| `Exercice_Debut` | 587-591 | Public | 1 | 3 | 0 | portée réductible ? |
| `Exercice_Fin` | 594-621 | Public | 7 | 23 | 0 | portée réductible ? |
| `Exercice_Index` | 623-646 | Public | 6 | 20 | 0 | portée réductible ? |
| `Exercice_Cloture` | 648-672 | Public | 6 | 21 | 0 | portée réductible ? |
| `Periode_Debut` | 674-678 | Public | 1 | 3 | 0 | portée réductible ? |
| `Periode_Fin` | 681-685 | Public | 1 | 3 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Méthodes spéciales

- **`_New(DateOrYear, Month, Day, Hour, Minute, Second, Millisecond)`** [portée : nécessaire]
  [nature : mixte]. Valeur fausse (Null, "", 0) → `Now`. `Date` → copiée. `String` → `Parse`, avec
  `Message.Error` si le résultat est Null. `Integer`/`Long` → `Date(année, mois, jour…)`. Autre →
  `Date(DateOrYear)`.
  ⚠️ La branche `String` teste `Param.Count = 0` : `_New` n'étant pas déclarée avec `...`,
  `Param.Count` vaut toujours 0 (à confirmer avec `gbx3`) ; la branche `Date(DateOrYear, Month, …)`
  pour une année passée en chaîne est donc inatteignable : `LDate("2024", 3, 1)` analyse « 2024 »
  comme une année avec le mois et le jour courants.
  ⚠️ Si `Parse` échoue par exception, l'utilisateur voit deux messages (« Erreur grave… » puis
  « Erreur, impossible d'interpréter… »).
- **`_call(…)`** [portée : nécessaire] [nature : calcul]. Fabrique `New LDate(…)` ; forme dominante
  `LDate(x).L`, `LDate(rResult!dte).D`, etc.

### Analyse et filtres

- **`Parse(Sdate, ParseTime)`** (privé, CC 20) [nature : mixte].
  - `".."` → `Now` (cas spécial Laurux : « aujourd'hui »).
  - Longueur 14 → format `yyyymmddHHMMSS` imposé. ⚠️ Une date saisie `dd/mm/yy hh:nn` fait aussi
    14 caractères : elle est mal découpée, l'exception est rattrapée par `Catch` et la fonction
    renvoie `Null` (anomalie LDATE-A01).
  - Sinon trois expressions régulières successives : `j.m.a` (année en tête si 4 chiffres, en
    queue sinon ; année sur 1 à 3 chiffres complétée par l'année courante), `a.m` / `m.a` / `j.m`
    (le jour ou l'année manquant pris dans `Now`), un seul nombre (année si 4 chiffres, sinon jour
    du mois courant). ⚠️ `a.m` et `m.a` utilisent `Day(Now)` : le 29, 30 ou 31 du mois, « 2024.02 »
    provoque une date invalide, donc `Null`.
  - Heure : `hh:nn:ss` ou `hh:nn` après un espace, si `ParseTime`.
  - Aucun motif reconnu : `Message.Error` puis `Now` (ou `Date(Now)`).
  - `Catch` : `Message.Error` (sauf chaîne vide) et `Null`.
  Partie GUI extractible : les trois `Message.Error`.
- **`DateFilterDB(Sdate, HasTime)`** (CC 20, max du fichier avec `Parse`) [portée : nécessaire]
  [nature : calcul]. Transforme une saisie partielle avec jokers (`*` ou `%`) en motif `LIKE` au
  format base : `"12.*.2024"` → `"2024-%-12"`, `"2024"` → `"2024-%-%"`, avec heure optionnelle.
  Appelée de façon statique par `Facture.class:11691` et `ArchivesTck.class:375`. Le traitement
  « `Right(x, n)` puis `Replace(*, %)` » est répété 18 fois. Variables `cvdate` et `time`
  inutilisées.
- **`prd(compdate)`** (privé) : renvoie `gb.Second` si les deux dates sont dans la même année
  (`DateDiff` en années nul), sinon `gb.Year`. Dans les deux cas, le signe de `DateDiff` est celui
  de la comparaison à la seconde : la distinction est superflue (à confirmer par tests aux bornes
  d'année).

### Propriétés de format et composants (privé)

- `L_Read`, `LT_Read`, `D_Read`, `DT_Read`, `F_Read`, `FT_Read` : `Format(Dte, …)`.
- `L_Write`, `D_Write` : `Parse(x, False)` ; `LT_Write`, `DT_Write` : `Parse(x)` (avec heure).
  `G_Write`, `GnT_Write` : affectation directe. Toutes lèvent `change` si la date n'est pas Null.
  ⚠️ Si `Parse` renvoie `Null`, la date précédente est perdue (`Dte = Null`) sans événement.
- `G_Read`, `GnT_Read` (minuit), `Day_Read`, `Week_Read`, `Month_Read`, `Year_Read`,
  `Year2_Read` (`Val(Right(année, 2))`, donc **Integer** sans zéro de tête : 2005 → 5).
- `WeekDay_Read` / `WeekDay3_Read` : nom du jour en français (complet / 3 lettres).
- `MonStr_Read` : ⚠️ tableau incohérent : `"janvier"`, `"fevrier"` (sans accent) … `"mai"`, puis
  `"jun"`, `"jui"`, `"aou"`, `"sep"`, `"oct"`, `"nov"`, `"dec"` (abrégés). `MonStr3_Read` :
  abréviations à 3 lettres. Seul consommateur : `LVar.AddDate` (variables `$moistr`, `$moistr3`
  des libellés automatiques).
- `FinMois_Read`/`FinJour_Read` → `Fin_Mois()`/`Fin_Jour()`.
- `PDeb_Read`/`PFin_Read` → `Periode_Debut(Me)`/`Periode_Fin(Me)`.
- `EDeb_Read`/`EFin_Read`/`EInd_Read` → `Exercice_Debut(Me)`/`Exercice_Fin(Me)`/`Exercice_Index(Me)`.
  Chaque lecture exécute une requête SQL.

### Méthodes publiques

- **`Apres(compdate, strict)` / `Avant(compdate, strict)`** [portée : nécessaire] [nature : calcul].
  Comparaison à la seconde (via `prd`) ; `strict` exclut l'égalité. `Select Case` sur un booléen
  avec branches dupliquées. ~29 appels externes (Extrait, VerifDate, Moulinage…).
- **`Fin_Mois()`** [portée : réductible, usage interne seulement] : premier jour du mois + 1 mois − 1 jour
  (minuit).
- **`Fin_Jour()`** [portée : nécessaire] : lendemain minuit − 1 ms. Appel externe non vu par
  `deps.py` : `Histocliart.class:342` (`dteN1.dte.Fin_Jour().DT`).
- **`Exercice_Debut(Annee)`** [portée : réductible] [nature : calcul + SQL] :
  `Exercice_Fin(Annee) − 1 an + 1 ms`. ⚠️ Suppose un exercice de 12 mois (anomalie LDATE-A02) ;
  `EcrM.exercice` calcule au contraire `dteclec(n+1) + 1 jour`.
- **`Exercice_Fin(Annee)`** [portée : réductible] [nature : calcul + SQL]. Lit `Fiches_Parametres`
  (`SELECT *`), compare la date aux clôtures `dteclec5` → `dteclec` (fin de journée, 23:59:59.999) et
  renvoie la première clôture postérieure ou égale. Au-delà de `dteclec` : année de la date avec le
  jour/mois de `dteclec`. ⚠️ Pour un exercice décalé (clôture au 30/06), une date du 01/08/N renvoie
  le 30/06/N, antérieur à la date (anomalie LDATE-A03). Pas de test `Available` ; `With utils`
  inutile.
- **`Exercice_Index(Annee)`** [portée : réductible] : même cascade, renvoie 5 … 0 (0 pour
  l'exercice courant et au-delà).
- **`Exercice_Cloture(Index)`** [portée : réductible] : date de clôture n° `Index` (0 = `dteclec`,
  ≥ 5 = `dteclec5`), en fin de journée. **Aucun appelant** (interne ou externe) : code mort
  aujourd'hui, mais c'est exactement la fonction dont ont besoin les 20+ fichiers qui lisent
  `dteclec*` à la main (voir commonalisation) : à conserver.
- **`Periode_Debut(Mois)` / `Periode_Fin(Mois)`** [portée : réductible] : premier jour du mois à
  minuit / dernier jour à 23:59:59.999. Utilisées via `PDeb`/`PFin` (`Moulinage.class:1035`).

## État global utilisé

- `Utils.db` + `Cbase.Table("TabParam")` → `Fiches_Parametres` (colonnes `dteclec`, `dteclec1` …
  `dteclec5`) dans `Exercice_Fin`, `Exercice_Index`, `Exercice_Cloture`.
- `Now` (valeurs par défaut, compléments de `Parse`).
- Auto-instance statique (`Create Static`) : utilisée par `LDate.DateFilterDB` et par les valeurs
  par défaut `LDate(Now)` des paramètres.

## Propositions d'amélioration

### Réécriture / refactorisation

- `DateFilterDB` : helper privé `Joker(txt, n) As String` (`Replace(Right(txt, n), "*", "%")`),
  puis une seule construction du résultat (CC 20 → ≤ 8 visé). Supprimer `cvdate`/`time`.
- `Parse` : séparer l'analyse pure (renvoie `Null` + code d'erreur) des `Message.Error`.
- `Exercice_Fin` / `Exercice_Index` / `Exercice_Cloture` : helper privé
  `Clotures() As Date[]` (une requête, 6 dates en fin de journée), puis boucle ; les trois
  cascades `If … Else If` disparaissent. Comportement identique (une requête par appel, comme
  aujourd'hui).
- `Apres`/`Avant` : `Return DateDiff(compdate.G, Dte, gb.Second) > 0` (ou `>=`, `<`, `<=`) ;
  `prd` devient inutile. À valider par tests aux bornes d'année et à la milliseconde.

### Commonalisation avec d'autres fichiers (candidats `LDate`)

Le code manipule beaucoup de dates « à la main ». Candidats recensés par `grep` (pour la phase 3,
chaque bascule se fait dans le rework du fichier appelant, avec ses propres tests) :

| Idiome manuel | Volume | Équivalent `LDate` | Exemples |
|---|---|---|---|
| [`Utils.Cdate_Dbase`](../Utils.module/architecture.md) (`yyyymmdd`) | 51 fichiers | `LDate(x).F` | Facture, Journaux… |
| `Utils.Cdate_Aff` (`dd.mm.yyyy`) | 50 fichiers | `LDate(x).L` | Journaux, Balance… |
| `Utils.Cdate2_Dbase` (`yyyy-mm-dd`) | 3 usages | `LDate(x).D` | |
| `Utils.Cdate_Comp` / `Cdate_Comp2` (`yyyymmdd` depuis divers formats) | 22 fichiers | `LDate(x).F` | |
| `Utils.Cdate_calc` (saisie `jj[.mm[.aa]]` → `Date`) | 34 fichiers | `LDate(x).G` (`Parse` gère les mêmes formats, à comparer par tests : `Cdate_calc` fixe l'heure à 12:00) | Saisecrit, Tresor… |
| `Utils.Calc_mois` (1er du mois suivant) | 22 fichiers | `LDate(x).FinMois` + 1 jour, ou `PFin` + 1 ms | Journaux, Balance… |
| `Utils.lastday(d)` (boucle d'essais `Try Date(…)`) | 6 fichiers | `LDate(d).FinMois.Day` | |
| `Format$(Now, "dd.mm.yyyy")` | 215 occurrences, 88 fichiers | `LDate().L` | Saisecrit (l. 1013, 1067, 1524)… |
| `Format$(x, "dd.mm.yyyy")` (autres) | ~310 occurrences, 112 fichiers | `LDate(x).L` | Moulinage, Bordereaux, Edsdepots… |
| `Format$(x, "yyyy-mm-dd")` | 26 occurrences, 11 fichiers | `LDate(x).D` | [`Agenda`](../Agenda.class/architecture.md) (7), Moulinage (6), TriHistos (3), Fmenu (2) |
| `Format$(x, "yyyymmdd…")` | 47 occurrences | `LDate(x).F` / `.FT` | |
| Lecture manuelle `rResult!dteclec*` (bornes d'exercice) | ~245 occurrences, 30 fichiers | `LDate.Exercice_Cloture(i)`, `.EDeb`, `.EFin`, `.EInd` | RubImp (25), Journaux, JournauxA, Jourcent, Editcompte, EditcompteA, EcrM, Balance (13 chacun), ExportA47 (12), FClotureAn (7), Parametre (7), Anomalies (6), Verbal, Epurjdv, gridvi, gridvi2, ExportJdv |
| `Anomalies.Exercice_Begin/Exercice_End` | 1 fichier | duplication directe de `Exercice_Debut/Fin` | `Compta/Impressions/Anomalies.class:91-110` |
| `DateAdd(…, gb.Month, …)` pour des fins de mois | 18 occurrences, 10 fichiers | `FinMois`, `PDeb`, `PFin` | |

Remarques :
- `Utils.Cdate_Comp` utilise déjà `LDate` mais de façon erronée (`ld = LDate(…).L` affecte une
  String à une variable `LDate` ; `Lsl(dte, 8) & 65535` concatène au lieu de masquer) : à signaler
  dans la documentation d'`Utils.module`.
- Les helpers `Cdate_*` acceptent aussi des chaînes de formats variés ; la bascule vers `LDate` doit
  être couverte par des tests de caractérisation de chaque helper (phase 2, lot Utils).
- [`VerifDate`](../VerifDate.class/architecture.md) hérite de `LDate` et
  [`LVar.AddDate`](../LVar.class/architecture.md) consomme ses composants.

### Réduction de portée

- `Fin_Mois`, `Exercice_Debut`, `Exercice_Fin`, `Exercice_Index`, `Periode_Debut`, `Periode_Fin` :
  aucun appel externe (vérifié par `grep`) ; utilisées via les propriétés. Passage en `Private`
  possible si les propriétés `FinMois`, `EDeb`, `EFin`, `EInd`, `PDeb`, `PFin` sont couvertes.
- `Fin_Jour` : **nécessaire** (`Histocliart.class:342`), faux positif de `deps.py`.
- `Exercice_Cloture` : garder `Public` (cible de commonalisation).

### Séparation traitement / GUI

- `Parse` et `_New` : renvoyer un statut d'erreur depuis une analyse pure ; les `Message.Error`
  restent dans `_New` et dans un wrapper de `Parse`, avec les mêmes textes et le même ordre.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les clôtures d'exercice sont stockées en 6 colonnes `dteclec`…`dteclec5` de `Fiches_Parametres`
  (et les écritures en 6 tables `Fiches_Mvt`…`Mvt5`). Une table `Fiches_Exercices(index, debut,
  fin)` donnerait aussi la **date de début** réelle de chaque exercice (corrige A02 sans
  hypothèse de 12 mois) et supprimerait les cascades.
- Stocker toutes les dates en `DATE`/`DATETIME` natif (certaines colonnes sont en texte, par ex.
  `dtepec` au format `mm.yyyy` lu par `VerifDate`) rendrait `Parse` inutile pour les lectures base.
