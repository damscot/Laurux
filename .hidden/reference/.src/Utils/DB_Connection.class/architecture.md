# DB_Connection — Architecture

> Source : `.src/Utils/DB_Connection.class`

## Vue d'ensemble

`DB_Connection` hérite de `Connection` (gb.db). Une seule instance existe dans le projet : le
singleton global `Utils.db` (`Public db As New DB_Connection`, `Utils.module:9`, environ 7 000 usages).
`DB_Log` et `DB_Sanity` reçoivent cette même instance par leur constructeur.

La classe remplit quatre rôles distincts dans un seul fichier :

1. **Façade SQL** : `Exec`, `Edit`, `Create9` surchargent ou enveloppent les méthodes de `Connection`.
   Elles appliquent la substitution des paramètres `&1, &2…` (via `Connection.Subst`, méthode native
   de gb.db, **non redéfinie** ici), la journalisation, la réécriture MySQL → SQLite et la gestion
   d'erreur.
2. **Dialecte** : `Engine`, `IsType`, `AutoIncrement`, `CopieTable`, `Prepare`/`Set`/`Execute`.
3. **Journalisation applicative** (log/replay) : logger `ComplexLogger` avec un `FileHandler` local et,
   en option, un `NetHandler` distant ; filtres par regex ; points d'entrée `GUI_Event` (appelé par
   `ReplayObserver`) et `Log_Event` (appelé par `LLog`). C'est le **socle du harnais log/replay** de la
   phase 2.
4. **Métier égaré** : `Lockstock` (stock et PMP d'un article), `LockIncrement` (compteur verrouillé),
   `RecArt` (recherche d'article). Ces fonctions n'ont rien à faire dans la couche connexion.

Nature globale : **traitement**, avec un couplage GUI ponctuel (`Message.Error`, curseur souris via
`Utils.MouseProcessing`/`MouseDefault`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `log` | var | Private |  | ComplexLogger | 5 |
| `logh` | var | Private |  | Collection | 6 |
| `hFile` | var | Private |  | File | 7 |
| `hFilePath` | var | Private |  | String | 8 |
| `level` | var | Private |  | Integer | 9 |
| `user_name` | var | Private |  | String | 11 |
| `process_id` | var | Private |  | Integer | 12 |
| `machine_id` | var | Private |  | String | 13 |
| `host_id` | var | Private |  | String | 14 |
| `AllFilters` | var | Private |  | String | 15 |
| `Filtering` | var | Private |  | Boolean | 16 |
| `Filter_Error` | var | Private |  | String | 17 |
| `Filters` | var | Private |  | Collection | 19 |
| `Show_Backtrace` | var | Private |  | Boolean | 20 |
| `$req` | var | Private |  | New Collection | 22 |
| `$context` | var | Private |  | New Collection | 23 |
| `type_mysql` | enum | Public | oui |  | 25 |
| `type_sqlite3` | enum | Public | oui |  | 25 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 28-45 | Public | 1 | 11 | 0 | méthode spéciale |
| `Start` | 48-97 | Public | 12 | 45 | 0 | portée réductible ? |
| `Clear` | 100-110 | Public | 2 | 8 | 1 |  |
| `Refresh` | 113-123 | Public | 2 | 8 | 1 |  |
| `Set_Log` | 125-129 | Public | 1 | 3 | 1 |  |
| `Set_Level` | 131-137 | Public | 2 | 5 | 0 | portée réductible ? |
| `Enable_Log` | 139-143 | Public | 1 | 3 | 0 | portée réductible ? |
| `Disable_Log` | 145-149 | Public | 1 | 3 | 0 | portée réductible ? |
| `Get_Log` | 151-155 | Public | 1 | 3 | 1 |  |
| `Backtrace` | 157-161 | Public | 1 | 3 | 1 |  |
| `Get_Filter` | 163-172 | Public | 3 | 7 | 1 |  |
| `Set_Filter` | 175-182 | Public | 1 | 6 | 1 |  |
| `Refresh_Filter` | 184-222 | Public | 6 | 34 | 0 | portée réductible ? |
| `Get_Filter_Error` | 225-229 | Public | 1 | 3 | 1 |  |
| `Get_Localfile_Path` | 232-236 | Public | 1 | 3 | 1 |  |
| `Get_Remotefile_Path` | 239-253 | Public | 3 | 12 | 1 |  |
| `Is_Filtered` | 256-277 | Public | 8 | 17 | 0 | portée réductible ? |
| `Engine` | 279-287 | Public | 2 | 7 | 68 |  |
| `IsType` | 289-301 | Public | 5 | 11 | 2 |  |
| `AutoIncrement` | 303-314 | Public | 3 | 10 | 11 |  |
| `Exec` | 317-450 | Public | 42 | 101 | 338 |  |
| `Prepare` | 452-481 | Public | 5 | 25 | 1 |  |
| `Set` | 483-506 | Public | 6 | 20 | 1 |  |
| `Execute` | 508-519 | Public | 2 | 9 | 1 |  |
| `Lockstock` | 521-551 | Public | 6 | 27 | 1 |  |
| `LockIncrement` | 553-592 | Public | 10 | 36 | 4 |  |
| `RecArt` | 594-615 | Public | 7 | 19 | 1 |  |
| `Create9` | 617-644 | Public | 5 | 21 | 26 |  |
| `CopieTable` | 646-654 | Public | 2 | 7 | 1 |  |
| `Edit` | 656-702 | Public | 7 | 34 | 23 |  |
| `GUI_Event` | 705-724 | Public | 4 | 15 | 1 |  |
| `Log_Event` | 726-735 | Public | 3 | 7 | 1 |  |
| `Print` | 737-756 | Public | 4 | 16 | 0 | portée réductible ? |
| `Close` | 759-764 | Public | 2 | 4 | 6 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et cycle de vie du logger

- **`_new()`** [portée : nécessaire] [nature : calcul]. Lance trois commandes shell **synchrones**
  (`cat /etc/machine-id`, `hostname`, `hostid`) pour remplir `machine_id` et `host_id` (tronqués à
  50 caractères), crée `Filters`, puis appelle `Start(Start.Arg_Log, Start.Arg_Log, Start.ConsoleLogLevel)` :
  le log est actif et le fichier vidé si `-l` est passé en ligne de commande. Exécuté au chargement du
  module `Utils` (très tôt) : il dépend de `Start.LocalSettings` et `Start.Societe` déjà initialisés
  (ordre d'initialisation à confirmer).
- **`Start(Enabling, Clear, iLevel)`** (CC 12) [portée : réductible, appelée seulement par `_new`,
  `Clear`, `Refresh`] [nature : calcul]. Recharge les filtres (`Get_Filter` + `Refresh_Filter`) ;
  choisit le fichier de log : `Start.Arg_LogFile` (option `--logfile`) ou
  `~/tmp/Debug/Laurux.log` ; **en mode replay (`-r`) le suffixe `.out` est ajouté**, ce qui évite
  d'écraser le log rejoué et produit le log à comparer. Supprime le fichier si `Clear`. Crée un
  `ComplexLogger` au format `"$(now);$(levelname);$(message)"` avec le handler `"local"`. Ajoute un
  `NetHandler` `"remote"` si `/Soc<XX>/ServerLogIP` est renseigné **ou** si `/Soc<XX>/ServerLogPort`
  est valide (1024–65535).
  ⚠️ Condition `Or` au lieu de `And` (ligne 84) : `Prefs` initialise `ServerLogIP` à `127.0.0.1` par
  défaut, donc un `NetHandler` est créé et une connexion TCP est tentée (port 0 possible) à chaque
  démarrage. `NetHandler.Open` boucle en `Wait 0.1` tant que la socket est en cours de connexion.
  ⚠️ Le nom de méthode `Start` masque le module global `Start` dans la classe ; les expressions
  `Start.Arg_Log`… fonctionnent (résolution vers le module), mais la lecture est trompeuse.
- **`Clear()` / `Refresh()`** [portée : nécessaire, `DB_Log`] : ferment le logger et le recréent par
  `Start`, en conservant l'état actif ; `Clear` vide le fichier.
- **`Set_Log(boo)`**, **`Get_Log()`** [nécessaire, `DB_Log`] ; **`Enable_Log()`**, **`Disable_Log()`**,
  **`Set_Level(iLevel)`** [réductible : aucun appelant externe, `Set_Level` est appelé par `Start`].
  `Set_Level` modifie le niveau des handlers local et distant (`Try` sur le distant).
- **`Backtrace(Enable)`** [nécessaire, `Utils.module:127`] : fixe `Show_Backtrace`
  (paramètre `/dbase/backtrace`), qui conditionne le `Message.Error` de `Exec`.
- **`Close()`** [nécessaire, 6 appelants] : `Super.Close()` puis fermeture du logger.

### Filtres de journalisation

- **`Get_Filter()`** [nécessaire, `DB_Log`] : lit `Temp$("Laurux_filter")`.
  ⚠️ Ce fichier est dans le répertoire **temporaire du processus** Gambas : les filtres ne survivent
  pas à la fin de l'application. ⚠️ Réutilise la variable membre `hFilePath` (aussi utilisée pour le
  chemin du log), qui est donc écrasée ; `Start` la recalcule juste après, sans effet visible.
  Variable locale `filterlist` inutilisée.
- **`Set_Filter(filterlist)`** [nécessaire, `DB_Log`] : sauve le texte puis `Refresh()`.
- **`Refresh_Filter()`** (CC 6) [réductible] : chaque ligne `Clé:regex` compile une `RegExp` ajoutée à
  `Filters[Clé]` ; `Filter_Error` cumule les erreurs.
  ⚠️ Une ligne sans `:` est signalée mais **traitée quand même** : `Left$(filter, -1)` donne une clé
  tronquée et la ligne entière est compilée comme regex, et `Filtering` passe à `True`.
  Une ligne vide (fin de fichier) suit le même chemin (à confirmer selon `Split`).
- **`Is_Filtered(FilterName, Request)`** (CC 8) [réductible] : `False` si le log est inactif ; `True`
  si aucun filtre n'est défini ; sinon `True` si une regex de la clé correspond.
  ⚠️ Le test `regex.Count >= 0` (ligne 269) est vrai dès que `Exec` ne lève pas d'erreur : selon la
  sémantique de `RegExp.Count` (à confirmer), **toute** requête serait acceptée dès que la clé
  existe, et le contenu de la regex serait ignoré. Une clé absente donne `False` : définir un filtre
  pour `GUI` seulement coupe la journalisation SQL.
- **`Get_Filter_Error()`**, **`Get_Localfile_Path()`**, **`Get_Remotefile_Path()`** [nécessaires, `DB_Log`] :
  accesseurs d'affichage ; `Get_Remotefile_Path` ajoute une aide `nc -l -k -p` en cas d'échec.

### Dialecte

- **`Engine()`** [nécessaire, 68 appelants] : `" ENGINE = InnoDB"` (MySQL) ou `""`.
- **`IsType(type)`** [nécessaire] : compare `Super.Type`. Le `Default` est redondant avec le
  `Return False` final.
- **`AutoIncrement(Fld, Type, Size)`** [nécessaire, 11 appelants] : `Fld Type(Size) NOT NULL
  AUTO_INCREMENT, PRIMARY KEY (Fld)` ou `Fld INTEGER PRIMARY KEY AUTOINCREMENT`.

### `Exec(Request, ...)` : cœur du projet (CC 42)

[portée : nécessaire, 338 fichiers appelants] [nature : mixte ; la partie GUI se réduit aux
`Message.Error` et au curseur souris].

Étapes, dans l'ordre :

1. **Substitution** : si des paramètres sont passés, construction d'un `Variant[]` `[Request, args…]`
   puis `Object.Call(Me, "Subst", aArg)`. `Subst` est la méthode **native** `Connection.Subst` : elle
   remplace `&1`, `&2`, `&{10}`… par les valeurs **quotées selon le pilote** (chaînes entre quotes et
   échappées, dates au format SQL, booléens, `NULL`). Le même bloc est dupliqué dans `Prepare` et
   `Edit` (appel dynamique, lignes 342, 467, 677).
2. **Journalisation** : si `Is_Filtered("Exec_SQL", Request)`, écriture d'une ligne
   `Exec_SQL;<user>;<hostname(hostid)>;<machine-id>;<pid>;<backtrace>;<SQL>` (voir « Format du log »).
   Le SQL journalisé est le SQL **après substitution et avant réécriture SQLite** : un log capturé
   sous MySQL est donc rejouable tel quel sur les deux moteurs.
3. **Réécriture MySQL → SQLite** (seulement si `Super.Type = "sqlite3"`), appliquée **sur toute la
   chaîne, littéraux compris** :

   | Ordre | Déclencheur (`UCase(Request) Match`) | Regex (insensible à la casse sauf mention) | Remplacement | Remarques |
   |---|---|---|---|---|
   | 0 | `LOCK TABLES`, `UNLOCK TABLES` | – | `Return Null` | verrous neutralisés ; l'appelant reçoit `Null` |
   | 1 | `YEAR` | `YEAR *\(([()'. a-zA-Z0-9_-]+)\)` | `strftime('%Y',&1) ` | pas de virgule ni de `"` dans l'argument |
   | 2 | `MONTH` | `MONTH *\(…\)` | `strftime('%m',&1) ` | idem |
   | 3 | `DAY` | `DAY *\(…\)` | `strftime('%d',&1) ` | touche aussi `WEEKDAY(`, `DAYOFWEEK (`… |
   | 4 | `NOW` | `NOW *\(\)` | `strftime('%Y-%m-%d','now') ` | perd l'heure (MySQL renvoie date + heure) |
   | 5 | `CONCAT` | `CONCAT\((…) *, *(…)\)` | `&1 \|\| &2 ` | **2 arguments seulement** ; accents `éèàêâù` et `%` admis |
   | 6 | `LEFT` | `left\(([().' a-zA-Z0-9_-]+) *, *([0-9-]+)\)` | `substr(&1,0,&2) ` | ⚠️ `substr(x,0,n)` SQLite renvoie **n-1** caractères |
   | 7 | `RIGHT` | `right\((…) *, *([0-9-]+)\)` | `substr(&1,-&2) ` | |
   | 8 | `MID` | `mid\((…) *, *([0-9-]+) *, *([0-9-]+)\)` | `substr(&1,&2,&3) ` | |
   | 9 | `ISNULL` | `isnull\(([()' .a-zA-Z0-9_-]+)\)` | `&1 IS NULL` | |
   | 10 | toujours | `lpad[(]([^,]+)[,]+([^,]+)[,]+([^,]+)[)]` (**sensible à la casse**) | `substr('<remplissage>' \|\| x, -n, n)` | 1re occurrence ; remplissage = 2e caractère du 3e argument (`'0'` → `0`) répété n fois |
   | 11 | toujours | `left[(]([^,]+)[,]+([^,]+)[)]` (sensible à la casse) | `substr(x,0,n+1)` | ne s'applique qu'aux `left(` non convertis en 6 (arguments hors de la classe de caractères) |
   | 12 | toujours | `right[(]([^,]+)[,]+([^,]+)[)]` (sensible à la casse) | `substr(x,length(x)-(n-1))` | idem pour `right(` |
   | 13 | `ABS` | `abs\(([()'.,\|a-zA-Z0-9_ -]+)\) ` | `CAST(&1) AS INTEGER) ` | ⚠️ SQL invalide et sémantique fausse (voir anomalies) |
   | 14 | `WHERE` | `InStr(UCase, "ORDER")` | insère ` COLLATE NOCASE ` avant la 1re occurrence de `ORDER`, sinon l'ajoute en fin | voir ci-dessous |

   Effets non évidents du point 14 :
   - `COLLATE NOCASE` ne porte que sur **le dernier terme** avant `ORDER` (ou de la requête) : seule la
     dernière comparaison du `WHERE` devient insensible à la casse.
   - La recherche de `ORDER` est textuelle : **`Fiches_Bordereaux`, `Fiches_BordereauxC`, la colonne
     `bordereau`, ou un littéral `'BORDEREAU'`** contiennent `ORDER`. La clause est alors insérée au
     milieu d'un identifiant ou d'une chaîne, ce qui casse la requête ou **corrompt silencieusement
     une valeur écrite** (anomalie DB_CONNECTION-A01).
   - Une requête `GROUP BY` / `LIMIT` sans `ORDER` reçoit la clause en fin de requête.
   - Les erreurs de compilation/exécution des regex `lpad/left/right` et un nombre de sous-groupes
     inattendu ouvrent un `Message.Error` (GUI) puis l'exécution continue.
   - Les tests `regex.Count >= 1` / `<> 3` / `<> 2` dépendent de la sémantique de `RegExp.Count`
     (sous-groupes avec ou sans la correspondance entière) : **à confirmer** par les tests de
     caractérisation (DB_CONNECTION-T03).
4. **Exécution** : si `Utils.db.Opened` (⚠️ test sur le **singleton global** et non sur `Me`),
   `Utils.MouseProcessing()`, `Super.Exec(Request)`, `Utils.MouseDefault()` ; sinon `Return Null`
   silencieux.
5. **Erreur** (`Catch`) : `Message.Error` avec le SQL et la backtrace **seulement si** `Show_Backtrace`,
   puis `Error.Propagate()` dans tous les cas. ⚠️ Le curseur reste en attente si `Super.Exec` échoue
   (`MouseDefault` sauté).

Variable locale `patrn` inutilisée.

### Requêtes préparées

- **`Prepare(Nom, Request, ...)`** [nécessaire, `commande1.class:83-84`] : substitution identique à
  `Exec`. SQLite : mémorise la requête dans `$req[Nom]`. MySQL : `PREPARE nom FROM '<requête>'`.
  ⚠️ Les quotes de la requête ne sont pas échappées : une requête contenant un littéral (produit par
  `Subst`, ici `&1` = `GesTar.TarCli`, une chaîne) casse le `PREPARE` (à confirmer, dépend du type de
  `GesTar.TarCli`).
- **`Set(Var, value)`** [nécessaire, `VarMajTar.class:77`] : SQLite : stocke dans `$context`. MySQL :
  `SET @var = …` selon le type (`String`/`Date` via `Subst`, `Float`/`Integer` via `Str`, `Null`).
  ⚠️ Pour un autre type (Boolean, Long), `Request` est vide et `Exec("")` est appelé.
- **`Execute(Nom)`** [nécessaire, `VarMajTar.class:79,82`] : MySQL : `EXECUTE nom`. SQLite :
  `Eval("Me.Exec(" & $req[Nom] & ")", $context)`. ⚠️ Le SQL brut est évalué comme une **expression
  Gambas** : ce chemin ne peut pas fonctionner (anomalie DB_CONNECTION-A05) ; `VarMajTar` est donc
  inutilisable sous SQLite.

### Fonctions métier

- **`Lockstock(nart, nb, signe, pmp, paht)`** [nécessaire, `Achat.class:818,902,907`] [nature : calcul].
  `Begin`, `LOCK TABLES Fiches_Art WRITE`, `Edit("Fiches_Art", "art_code = &1 And art_stocke = &2")`,
  calcule le PMP pondéré si `pmp` (`(pmp*qte + nb*paht)/(qte+nb)`, sinon `paht` si le stock est ≤ 0 ou
  s'annule), met à jour `art_qte`, `Update`, `Commit`, `UNLOCK`. Renvoie la nouvelle quantité, ou 0 si
  l'article n'est pas stocké. Table **en dur** (`Fiches_Art`, pas `Cbase.Table("TabArt")`) ; aucun
  `Rollback` en cas d'erreur ; sous MySQL, `LOCK TABLES` valide implicitement la transaction ouverte
  par `Begin` (à confirmer, comportement documenté de MySQL).
- **`LockIncrement(Field, Table, p_form)`** (CC 10) [nécessaire, `Caisse:455`, `Moulinage:786`,
  `EcrAuto:272,279,351`, `commande1:904,917`] : verrouille, lit le compteur, l'incrémente (Integer ou
  chaîne formatée `p_form`), relit et vérifie l'écart de 1, sinon `Message.Error`. Renvoie le résultat
  relu. ⚠️ Ligne 574 : `rResult.Available And rResult.Available` (doublon ; `rResult2` n'est pas
  testé). Champ et table concaténés (non paramétrables, valeurs internes). Bloc `With utils` inutile ;
  variable `ctx` inutilisée.
- **`RecArt(art, four)`** [nécessaire, `Achat.class:185`] : un `*` en tête déclenche
  `Utils.Find_cbarre` ; cherche successivement sur `art_code`, `art_cfour`, `art_refcentrale`, avec
  jointures `Fiches_Tvaav` et `Fiches_regie` (option boissons `B`/`T`). Tables **en dur**.

### Création, copie et édition

- **`Create9(Table)`** [nécessaire, 26 appels] : enveloppe `Super.Create` avec journalisation
  (`Create <table>`) et `Message.Error` + `Propagate` en cas d'erreur. Nom historique peu parlant.
- **`CopieTable(SrcTable, DstTable)`** [nécessaire, `FClotureAn.class:357,364,371`]. MySQL :
  `CREATE TABLE dst LIKE src`. SQLite : envoie à `Exec` une suite de `PRAGMA` / `SELECT replace(sql…)`
  qui **génère** le DDL sans l'exécuter ; de plus `Exec` y ajoute ` COLLATE NOCASE` (présence de
  `WHERE`). ⚠️ Sous SQLite la table n'est pas créée (anomalie DB_CONNECTION-A04).
- **`Edit(Table, Request, ...)`** [nécessaire, 23 fichiers] : substitution, journalisation
  `Edit <table> : <where>`, `Super.Edit`. Test `Super.Opened` (contrairement à `Exec`). Pas de
  réécriture SQLite du filtre.

### Journalisation GUI et applicative

- **`GUI_Event(hCont, Source, Act, Value)`** [nécessaire, `ReplayObserver` : 10 appels] [nature : calcul].
  Construit `<Act>=<CStr(Value)>@<hCont.Name>#<Source[0].Name>#…#<Source[n].Name>#`, `Source` étant la
  hiérarchie fenêtre → contrôle construite par `Utils.Recursive_Observers`. Si
  `Is_Filtered("GUI", …)`, journalise `GUI;<user>;<host>;<machine>;<pid>;<backtrace>;<requête>`
  (backtrace amputée des 2 premiers cadres).
  ⚠️ Aucun échappement : une valeur contenant `;`, `#`, `@`, `=` ou un saut de ligne (touche `;`
  tapée, clé de `ColumnView`…) rend la ligne illisible pour `ReplayObserver.Replay_Event`.
- **`Log_Event(sMessage, level)`** [nécessaire, `LLog.class:59`] : `Log;<user>;<host>;<machine>;<pid>;<message>`
  au niveau demandé.
- **`Print()`** [réductible : aucun appelant, débogage] : affiche tables, clés et champs sur la
  console. Variable `$user` inutilisée.

### Format du log (référence pour la phase 2)

Une ligne par événement, séparateur `;`, préfixe produit par `ComplexLogger` :

```
<now>;<levelname>;Exec_SQL;<user>;<hostname(hostid)>;<machine-id>;<pid>;<cadre1,cadre2,…>;<SQL substitué>
<now>;<levelname>;Exec_SQL;…;Edit <table> : <filtre substitué>
<now>;<levelname>;Exec_SQL;…;Create <table>
<now>;<levelname>;GUI;…;<Act>=<valeur>@<contrôle>#<fenêtre>#<conteneur>#…#<contrôle>#
<now>;<levelname>;Log;…;<backtrace LLog>;[<module>]<message>
```

- `<now>` : format texte de gb.logging ; `Replay_Event` le relit comme `MM/JJ/AAAA HH:MM:SS.mmm`
  (à confirmer selon la locale).
- Les champs `user`, `host`, `machine`, `pid`, la date et la backtrace doivent être **normalisés**
  avant toute comparaison entre deux exécutions (clone de référence et clone reworké).
- Le SQL peut contenir `;` et des sauts de ligne : le découpage par `Split(…, ";")` de `DB_Log` et de
  `Replay_Event` n'est fiable que pour les champs de tête. Un outil Python de comparaison doit couper
  au plus 8 fois (`split(';', 8)`).
- En replay (`-r`), le log produit est `<logfile>.out` ; `Start.module` ne rejoue que les lignes
  `*;GUI;*`.

## État global utilisé

- `Start.Arg_Log`, `Start.Arg_Replay`, `Start.Arg_LogFile`, `Start.ConsoleLogLevel`,
  `Start.LocalSettings["/Soc<XX>/ServerLogIP|ServerLogPort"]`, `Start.Societe`.
- `Utils.db` (lui-même, dans `Exec`, `Lockstock`, `LockIncrement`, `RecArt`), `Utils.MouseProcessing`,
  `Utils.MouseDefault`, `Utils.Option`, `Utils.Find_cbarre`.
- Fichiers : `~/tmp/Debug/Laurux.log[.out]`, `Temp$("Laurux_filter")`, `/etc/machine-id`.
- Commandes externes : `cat`, `hostname`, `hostid` (au constructeur).

## Propositions d'amélioration

### Réécriture / refactorisation

- Factoriser le bloc « Param → Variant[] → `Object.Call(Me, "Subst")` » (dupliqué 3 fois) dans un
  helper privé `SubstParam(Request, Param)`.
- Factoriser l'écriture d'une ligne de log (`log.Log("<type>;" & user_name & … )`, 5 copies) dans
  `LogLine(sType, sBacktrace, sMessage, level)`.
- Extraire la réécriture SQLite d'`Exec` dans une fonction **pure** `SqliteRewrite(Request) As String`
  (sans `Message.Error`, erreurs renvoyées par un paramètre ou une variable d'état). Elle devient
  testable en gb.test sans base (DB_CONNECTION-T03) et réduit la CC d'`Exec` de 42 à environ 8.
  Comportement **identique**, anomalies comprises.
- Table de règles `[déclencheur, regex, remplacement]` parcourue en boucle pour les règles 1 à 9.
- Supprimer `With utils … End With` et les variables inutilisées (`patrn`, `ctx`, `filterlist`, `$user`).
- Séparer la variable `hFilePath` en deux (chemin du log, chemin des filtres).

### Commonalisation avec d'autres fichiers

- `Lockstock`, `LockIncrement`, `RecArt` relèvent du métier article / compteurs ; à terme, les
  déplacer vers une classe dédiée (hors périmètre : changement d'API pour
  [`Achat`](../../Gestion/Entrées/Achat.class/architecture.md),
  [`Caisse`](../../Caisse/Caisse.class/architecture.md),
  [`Moulinage`](../../Caisse/Moulinage.class/architecture.md),
  [`EcrAuto`](../../Compta/Utils/EcrAuto.class/architecture.md),
  [`commande1`](../../Gestion/Stock/commande1.class/architecture.md)). En phase 4, seulement
  remplacer les noms de tables en dur par `Cbase.Table`.
- Le format de ligne de log est relu par [`DB_Log`](../DB_Log.class/architecture.md) (affichage) et
  [`ReplayObserver`](../ReplayObserver.class/architecture.md) (rejeu) : définir les positions des
  champs dans une `Public Enum` partagée (`log_date, log_level, log_type, …`) utilisée par les trois
  fichiers.
- [`LLog`](../LLog.class/architecture.md) et `DB_Connection` créent chacun un `ComplexLogger` +
  `FileHandler` sous `~/tmp/Debug` : chemin de base commun à factoriser (`Utils.DebugDir()`).

### Réduction de portée

- `Start` (à renommer en `Demarrer_Log`, confusion avec le module `Start`), `Set_Level`,
  `Refresh_Filter`, `Is_Filtered` → `Private` : vérifié par `grep`, aucun appelant externe.
- `Enable_Log`, `Disable_Log`, `Print` : aucun appelant → code mort (suppression) ou `Private`.
- Variables : toutes déjà `Private`.

### Séparation traitement / GUI

- `Exec` : la réécriture SQLite et la substitution deviennent pures ; le `Message.Error` et le curseur
  restent dans `Exec`.
- `LockIncrement` : renvoyer un code d'erreur et garder le `Message.Error` à la fin de la fonction
  (même message).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Les compteurs incrémentés par `LockIncrement` (stockés parfois en chaîne formatée) gagneraient à
  être des colonnes `INT` ou des séquences `AUTO_INCREMENT`, ce qui supprimerait le verrou de table.
- `Fiches_Art.art_stocke` booléen stocké en `tinyint` comparé à `True` : un type `BOOLEAN` explicite
  et une contrainte simplifieraient `Lockstock`.
- Sous SQLite, déclarer les colonnes texte en `COLLATE NOCASE` dans le schéma rendrait inutile
  l'injection textuelle de `COLLATE NOCASE` (source de l'anomalie A01).
