# Listextcpt — Architecture

> Source : `.src/Compta/Utils/Listextcpt.class`

## Vue d'ensemble

`Listextcpt` construit et exécute l'**extrait de compte multi-exercices** : la liste des écritures
d'un compte entre deux dates, réparties dans les six tables `Fiches_Mvt` (exercice en cours) et
`Fiches_Mvt1` … `Fiches_Mvt5` (exercices clôturés N-1 à N-5). Elle sert aussi de point d'accès
aux opérations de **lettrage** (`letcpt`, `letgroupe`, `Controle`, `rechechelot`) et de
**pointage** (`totalpointe`, `enregistrepointage`, `litpointee`) qui doivent toucher la bonne
table d'exercice.

La classe est déclarée `Create Static`. L'usage courant est `New Listextcpt(cpt, dtei, dtes, ltr,
tri, origin, dteech)` (ou la fabrique `Listextcpt(…)` via `_call`), puis la lecture de
`.resext` (le `Result` de la requête) ou de `.requete` (le texte SQL). Le constructeur :

1. lit `Fiches_Parametres` (journal des à-nouveaux `jdr`, dates de clôture `dteclec`…`dteclec5`) ;
2. construit le tableau `$brn` des **bornes d'exercice** (`Borne` : nom de table, date de début,
   date de fin) pour chaque table `Fiches_Mvt<N>` non vide, de la plus ancienne (`$brn[0]`) à
   l'exercice en cours (`$brn.Max`, toujours présent) ;
3. détermine l'exercice de la date de début (`prms`) et de fin (`der`) ;
4. construit une requête `SELECT … UNION …` sur les exercices concernés, avec en option une ligne
   « Report a nouveau » (somme des mouvements antérieurs) quand `ltr = "t"` et que la date de
   début tombe en cours d'exercice ;
5. termine par `ORDER BY <tri>` et stocke le texte dans `$req` (propriété `requete`).

La requête n'est exécutée qu'à la lecture de `resext` (chaque lecture la ré-exécute).

Nature globale : **traitement/calcul (SQL)**. Seul contact avec l'IHM : `Application.Busy` dans
`enregistrepointage`. Couleur de fond des lignes calculée en SQL par `LCoul.Ecr_DB_bgcolor`.

⚠️ **Contrat textuel** : `Pointage.class:128` exploite `Left($lst.requete, -14)` pour retirer
`" ORDER BY  dte"` (14 caractères avec le tri par défaut `" dte"`). Le texte exact de la requête
fait donc partie de l'API : tout rework du constructeur doit le reproduire **à l'octet près**.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `resext` | property | Public |  | Result | 5 |
| `Ecart` | var | Public |  | Float | 7 |
| `$resext` | var | Private |  | Result | 9 |
| `$dtei` | var | Private |  | LDate | 10 |
| `$dtes` | var | Private |  | LDate | 11 |
| `$scpt` | var | Private |  | String | 12 |
| `$jouran` | var | Private |  | String | 13 |
| `nomfich` | var | Private |  | String | 16 |
| `dteinf` | var | Private |  | LDate | 17 |
| `dtesup` | var | Private |  | LDate | 18 |
| `$brn` | var | Private |  | Borne[] | 21 |
| `requete` | property | Public |  | String | 23 |
| `champ` | const | Private |  |  | 25 |
<!-- /AUTO:declarations -->

`Borne` est une `Struct` publique (`nomfich`, `dteinf`, `dtesup`) utilisée seulement en interne.
`champ` liste les 20 colonnes renvoyées par l'extrait (dont `parse_having_P` calculée et, ajoutée
à chaque `SELECT`, la colonne `bgcolor` de `LCoul`).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_call` | 27-34 | Public | 1 | 5 | 0 | méthode spéciale |
| `_new` | 36-134 | Public | 28 | 88 | 0 | méthode spéciale |
| `dtsup` | 136-147 | Private | 3 | 10 | 0 |  |
| `litleres` | 149-160 | Public | 2 | 9 | 1 |  |
| `cherche` | 162-186 | Private | 8 | 23 | 0 |  |
| `letcpt` | 188-208 | Public | 5 | 18 | 3 |  |
| `letgroupe` | 210-218 | Public | 2 | 6 | 2 |  |
| `ctrl` | 220-238 | Private | 3 | 16 | 0 |  |
| `Controle` | 240-266 | Public | 5 | 23 | 2 |  |
| `rechechelot` | 268-285 | Public | 2 | 14 | 2 |  |
| `rechedoc` | 287-305 | Public | 2 | 14 | 1 |  |
| `totalpointe` | 308-328 | Public | 4 | 17 | 1 |  |
| `enregistrepointage` | 330-346 | Public | 5 | 14 | 1 |  |
| `litpointee` | 348-371 | Public | 4 | 20 | 0 | portée réductible ? |
| `resext_Read` | 373-378 | Private | 2 | 4 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction

- **`_call(cpt, dtei, dtes, ltr, stri, origin, dteech)`** [portée : nécessaire — Extrait,
  Lettrage, Tresor, EcrAuto, SaiReg, Facture, Pointage…] [nature : calcul]. Fabrique : renvoie
  `New Listextcpt(…)` avec les mêmes arguments. Les valeurs par défaut (`dtei` = aujourd'hui − 8 ans,
  `dtes` = aujourd'hui + 8 ans, `ltr = "n"`, `stri = " dte"`) sont des expressions non constantes,
  acceptées par `gbc3` (à confirmer selon la version de Gambas).
- **`_new(…)`** (CC 28, max du fichier) [portée : nécessaire] [nature : calcul + SQL].
  - `SELECT * FROM Fiches_Parametres` (nom en dur, clé Cbase `TabParam` non utilisée) ;
    `$jouran = jdr`.
  - Filtre de lettrage `lett` : `"o"` → `lettree=1` ; `"n"` → `lettree=0 AND jour<>jdr` ; `"t"` →
    aucun filtre. Toute autre valeur laisse `lett = ""`.
  - Bornes : pour `i` de 5 à 0, `SELECT * FROM Fiches_Mvt<i> LIMIT 1` (6 requêtes) ; une table
    vide (hors `Fiches_Mvt`) est ignorée. `dtesup = dteclec<i>` (date à 00:00),
    `dteinf = dtesup − 12 mois + 1 jour` (suppose des exercices de 12 mois, comme
    `LDate.Exercice_Debut`).
  - Si `dtei` est antérieure au premier exercice, `$dtei` **devient la même instance** que
    `$brn[0].dteinf` (ligne 76) ; l'affectation `$dtei.L = dtei` (ligne 87) modifie alors aussi la
    borne inférieure de l'exercice le plus ancien (alias d'objet, anomalie A03).
  - ⚠️ Ligne 82 : `$dtes.Apres($brn[i].dteinf) And $dtes.Avant($brn[i].dteinf)` compare deux fois
    à `dteinf` (vrai seulement si `$dtes` tombe exactement sur un début d'exercice) : `der` reste
    en pratique `$brn.Max`, l'exercice en cours (anomalie A01, `dtesup` probablement voulu).
  - Si `cpt` est vide, la requête n'est pas construite (`$req` vide, `resext` renvoie `Null`) mais
    les bornes sont chargées : c'est l'usage de `EcrAuto`/`SaiReg` (`New Listextcpt(compte)` puis
    `rechechelot`).
  - Filtre compte : `compte=&3`, ou pour `origin = "relance"` `compte LIKE &3 AND collectif is
    null AND (dateech <= dteech Or dte <= dteech OR dateech is null)`.
  - Boucle `prms` → `der` : le premier exercice traité (le plus ancien) est lu avec ou sans
    report à nouveau et la couleur normale (`Ecr_DB_bgcolor(False)`) ; les exercices suivants
    (plus récents) sont ajoutés en `UNION (SELECT … AND jour<>jdr)`, à-nouveaux exclus, avec
    `Ecr_DB_bgcolor(True)`, c'est-à-dire la couleur « ancien exercice » (inversion apparente, à
    confirmer à l'écran Extrait).
  - Ligne 96 : `A Or B And ltr = "t"` ; en Gambas `And` et `Or` ont la même priorité et
    s'évaluent de gauche à droite (à confirmer), soit `(A Or B) And ltr = "t"` : le report à nouveau
    n'est calculé qu'en mode « toutes écritures ».
  - Ligne 107 : la ligne de report est un `SELECT SUM(montantd), SUM(montantc), …` dont l'ordre des
    colonnes diffère de `champ` (`numero` et `intitule` inversés) : en `UNION` positionnel, la ligne
    de report a `intitule = 0` et `numero = ' '` (anomalie A02, à confirmer à l'écran Extrait).
  - Lignes 118 et 96 : `$dtei = $brn[i].dteinf` compare des **références d'objets** `LDate`
    (vrai seulement après l'alias de la ligne 76).
- **`dtsup(ind)`** [Private] [calcul] : fin effective de la plage pour l'exercice `ind` :
  `$dtes.FinJour` si `$dtes` est avant la fin de l'exercice ou si c'est l'exercice en cours, sinon
  `dtesup.FinJour`.
- **`resext_Read()`** [Private, propriété `resext`] [SQL] : exécute `$req` si non vide et mémorise
  le résultat dans `$resext` (utilisé ensuite par `cherche`). Chaque lecture relance la requête.
- **`requete`** (propriété `Use $req`, lecture/écriture) : lue par `Pointage` (voir contrat
  textuel ci-dessus) ; jamais écrite de l'extérieur (grep).

### Recherche dans l'extrait

- **`cherche(num, chp)`** [Private] [calcul] : parcourt `$resext` depuis le début jusqu'à la ligne
  dont le champ `chp` vaut `num`, puis renvoie l'indice de l'exercice qui contient sa date (comparaison
  de chaînes `yyyymmdd`), ou -1. ⚠️ Suppose que `resext` a été lu et n'est pas vide : sinon erreur
  d'exécution (`MoveFirst` sur `Null`, champ sur un `Result` vide — anomalie A05). Laisse
  `$resext` positionné sur la ligne trouvée (effet de bord exploité par `letcpt`).
- **`litleres(num)`** [portée : nécessaire — `Extrait.class:1152`] [SQL] : `SELECT * FROM
  <table de l'exercice> WHERE numero=&1 AND provisoire=False`. Renvoie `Null` si non trouvé (pas de
  `Return` explicite).

### Lettrage

- **`letcpt(lind, value, numlot, choix)`** [portée : nécessaire — Lettrage, Tresor, EcrAuto]
  [SQL] : localise l'écriture (par `numero` pour `choix = "tresor"`, en reprenant alors son `lind`
  dans `$resext`, sinon par `lind`), puis `UPDATE <table> SET numlot=&1 [, lettree=&2] WHERE
  lind=…`. `choix` : `"numlot"`/`"tresor"` (numéro de lot seul) ou `"lettrage"` (lot + drapeau). La
  variable locale `dtes` est inutilisée.
- **`letgroupe(Nlot, Nlot2, ltr, numcpt)`** [portée : nécessaire — Tresor, EcrAuto] [SQL] : sur
  **chaque** table d'exercice, `UPDATE … SET lettree=&1, numlot=&3 WHERE numlot=&2 AND compte=&4
  AND provisoire=False` (sans borne de date : voir A04).
- **`ctrl(numlot, numcpt)`** [Private] [SQL] : `UNION` des lignes du lot sur tous les exercices
  (bornées par `dteinf`/`dtsup`). Utilise `$brn[i]` avec `i` non initialisé (= 0) pour le premier
  `SELECT`.
- **`Controle(numlot, numcpt)`** [portée : nécessaire — Tresor, EcrAuto] [calcul] : somme débit −
  crédit du lot (arrondi à 2 décimales par `Utils.arrondi`), mémorise l'écart dans `Ecart`
  (lu par `EcrAuto`), renvoie 1 si équilibré, sinon 0. Bloc `With Utils` inutile.
- **`rechechelot(numlot, numcpt = $scpt)`** [portée : nécessaire — EcrAuto, SaiReg] [SQL] :
  lignes `champ` du lot sur tous les exercices ; les paramètres `&1`/`&2` sont passés à `Exec`,
  les dates par `Subst`. Valeur par défaut `$scpt` (variable d'instance) acceptée par le
  compilateur (à confirmer).
- **`rechedoc(numdoc, egal = " = ")`** [portée : nécessaire — `SaiReg.class:419`] [SQL] : lignes
  des comptes clients/fournisseurs (`Fiches_Comptes.type_cc` C ou F) dont `numdoc` vérifie
  l'opérateur `egal` (concaténé, ex. `" like "`).

### Pointage

- **`totalpointe(selected, cpt)`** [portée : nécessaire — `Pointage.class:605`] [SQL] : totaux
  débit/crédit des écritures dont le `numero` figure dans `selected` (liste **concaténée** dans
  `IN (…)`), via `SELECT SUM … FROM (… UNION …) AS a GROUP BY compte`. Renvoie `Null` si la liste
  est vide.
- **`enregistrepointage(selected, point, cpt, nrel)`** [portée : nécessaire — `Pointage.class:664`,
  `699`] [mixte : `Application.Busy`] : sur chaque table d'exercice, `pointee = 1, nrlv = nrel`
  (ou `0`/`NULL`) pour les numéros listés, **sans borne de date** (A04).
- **`litpointee(cpt, nrel)`** [portée : réductible — **aucun appelant** (grep)] [SQL] : numéros
  pointés d'un relevé. Code mort.

### Points transverses

- **SQLite** : `UNION (SELECT …)` (ligne 127) n'est pas une syntaxe SQLite (sélection composée
  entre parenthèses), et `DB_Connection` ne la réécrit pas : extrait sur plusieurs exercices en
  échec sous SQLite (anomalie A06, à confirmer). `pointee=True`/`provisoire=False` supposent
  SQLite ≥ 3.23.
- **Concaténations SQL** : `selected.Join(",")` dans `IN (…)` (`totalpointe`,
  `enregistrepointage`) et l'opérateur `egal` de `rechedoc` (anomalie A07, valeurs internes
  aujourd'hui).
- Aucun `If Not r.Available` sur la lecture de `Fiches_Parametres` dans `cherche`/`ctrl` ; seul
  `_new` le teste.

## État global utilisé

- `Utils.db` (`Exec`, `Subst`), `Utils.arrondi`.
- `LDate` (construction, `Apres`, `Avant`, `FinJour`, formats `.D`, `.DT`, `.G`, `.L`).
- `LCoul.Ecr_DB_bgcolor` : fragment SQL `CASE … END as bgcolor` (couleurs `/Coul/*`).
- Tables (en dur, sans `Cbase.Table`) : `Fiches_Parametres` (`jdr`, `dteclec*`), `Fiches_Mvt`,
  `Fiches_Mvt1`…`Fiches_Mvt5` (noms construits `"Fiches_Mvt" & si`), `Fiches_Comptes`.
- État d'instance : `$brn`, `$dtei`, `$dtes`, `$scpt`, `$jouran`, `$req`, `$resext`, `Ecart`.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `_new` (CC 28) en trois fonctions privées : `ChargeBornes()` (lignes 50-85, lecture des
  paramètres et des 6 tables), `FiltreLettrage(ltr)` et `ConstruitRequete(cpt, ltr, origin, dteech,
  stri)`. Le texte SQL produit doit rester identique (test T01 bloquant, à cause de `Pointage`).
- Factoriser l'idiome « `SELECT <colonnes> FROM $brn[i].nomfich WHERE <filtre> AND dte BETWEEN
  dteinf AND dtsup(i)` joint par `UNION` » répété dans `ctrl`, `rechechelot`, `rechedoc`,
  `totalpointe` et `litpointee` : helper privé `UnionExercices(sColonnes, sFiltre) As String`.
- Remplacer les `Format(…, "yyyymmdd")` de `cherche` par une comparaison `LDate`
  (`Apres`/`Avant` non stricts), à comportement identique.
- Supprimer les variables inutilisées (`dtes` de `letcpt`, `With Utils` de `Controle`).

### Commonalisation avec d'autres fichiers

- Les bornes d'exercice sont relues à la main (`dteclec<i>`) : [`LDate.Exercice_Cloture`](../../../Utils/LDate.class/architecture.md)
  (rework LDATE-008) est l'API cible. Attention : `Exercice_Cloture` renvoie 23:59:59.999 alors que
  `$brn.dtesup` est à 00:00 ; la bascule doit conserver l'heure actuelle (comparaisons `Apres`/`Avant`).
- La liste des tables d'exercice (`"Fiches_Mvt" & si`, i = 0…5) est reconstruite dans de nombreux
  fichiers (`Anomalies`, `Extrait`, `Sha1Calc`…) : un helper `Cbase.TableMvt(i)` ou
  `LDate.Exercice_Table(i)` éviterait les noms en dur (proposition transverse).
- Le recalcul d'équilibre d'un lot (`Controle`) existe aussi dans `Lettrage.class` (à vérifier lors
  du lot Lettrages).

### Réduction de portée

- `litpointee` : aucun appelant → suppression (code mort) plutôt que `Private`.
- `Borne` (Struct `Public`) : uniquement interne ; une `Struct` ne peut pas être `Private` en
  Gambas 3 (à confirmer), on la laisse.
- `Ecart` reste `Public` (lu par `EcrAuto`), comme `requete` (lu par `Pointage`).

### Séparation traitement / GUI

- `enregistrepointage` : déplacer `Application.Busy` dans l'appelant `Pointage` (deux appels,
  lignes 664 et 699), la classe devient purement traitement.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les six tables `Fiches_Mvt`…`Fiches_Mvt5` de structure identique imposent les `UNION` et les
  `UPDATE` répétés : une table unique avec une colonne `exercice` (et des vues par exercice pour la
  compatibilité) simplifierait toute la classe et supprimerait la détection des bornes.
- Un index `(compte, numlot)` et `(compte, nrlv)` sur chaque table accélérerait `ctrl`,
  `rechechelot` et `litpointee` (aujourd'hui `idx_numlot` et `idx_compte` séparés).
