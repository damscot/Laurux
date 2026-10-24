# DB_Sanity — Architecture

> Source : `.src/Utils/DB_Sanity.class` (+ `DB_Sanity.form`)

## Vue d'ensemble

`DB_Sanity` est la fenêtre **Admin → Contrôle de la base** (`Fmenu.Menu142_Click`, protégée par le
mot de passe admin si `/Soc<XX>/Admin`). Elle compare la structure réelle de la base à la référence
`db_control.csv` (10 colonnes `Table;Engine;Champ;Type;Long.;Def.;Null;Collation;Clée;Valid.`, lue
dans le **répertoire courant**), affiche le résultat dans une `GridView` colorée et sait :

- exporter la structure réelle ou attendue en CSV (`~/tmp/db_control.csv`) ;
- **corriger** la base (`Corriger_Click`) : `ALTER TABLE … MODIFY/CHANGE/ADD`, `CREATE TABLE`, puis
  resynchronisation des clés par table (`SyncKeys`) : clé primaire, `AUTO_INCREMENT`, index secondaires ;
- **nettoyer** la base (`Nettoyer_Click`) : `DROP COLUMN` / `DROP TABLE` des champs absents de la
  référence.

L'instance de connexion est passée au constructeur (`New DB_Sanity(Utils.db)`), mais le code utilise
aussi directement `Utils.db` ; les deux désignent le même objet.

Nature globale : **mixte**. La comparaison (`Refresh_Data`) mélange lecture du schéma, comparaison et
préparation de l'affichage ; la correction est entièrement dans un handler de bouton. Les opérations
de correction et de nettoyage sont **spécifiques à MySQL** (`SHOW INDEX`, `information_schema`,
variables `@counter`, `IFNULL`) ; seule la comparaison fonctionne sous SQLite (`PRAGMA table_info`).

Codes de validité (`Valid[ligne][colonne]`) : `-1` non comparé, `0` écart (rouge, « ERR »), `1`
conforme (vert, « OK »), `2` absent de la base (rose, « ABS »), `3` en trop dans la base (orange,
« SUP »).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DB_Con` | var | Private |  | DB_Connection | 3 |
| `Data` | var | Private |  | String[][] | 5 |
| `Data_Expected` | var | Private |  | String[][] | 6 |
| `Valid` | var | Private |  | Integer[][] | 7 |
| `Datain` | var | Private |  | String[][] | 9 |
| `Found` | var | Private |  | Boolean[] | 10 |
| `tabl` | enum | Private | oui |  | 12 |
| `format` | enum | Private | oui |  | 12 |
| `name` | enum | Private | oui |  | 12 |
| `type` | enum | Private | oui |  | 12 |
| `long` | enum | Private | oui |  | 12 |
| `def` | enum | Private | oui |  | 12 |
| `ValNul` | enum | Private | oui |  | 12 |
| `collation` | enum | Private | oui |  | 12 |
| `PrimK` | enum | Private | oui |  | 12 |
| `Valide` | enum | Private | oui |  | 12 |
| `EntMysql` | var | Private |  | String[] | 13 |
| `$indexes` | var | Private |  | Object | 14 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 16-42 | Public | 2 | 21 | 0 | méthode spéciale |
| `Refresh` | 44-48 | Public | 1 | 3 | 0 | portée réductible ? |
| `Refresh_Data` | 50-254 | Public | 50 | 166 | 0 | portée réductible ? |
| `Refresh_Data_Missing` | 256-299 | Public | 5 | 39 | 0 | portée réductible ? |
| `Form_Open` | 303-307 | Public | 1 | 3 | 0 | handler GUI |
| `GridView1_Data` | 309-351 | Public | 15 | 40 | 0 | handler GUI |
| `Quitter_Click` | 354-358 | Public | 1 | 3 | 0 | handler GUI |
| `Export_CSV_Click` | 360-367 | Public | 2 | 6 | 0 | handler GUI |
| `Control_Click` | 369-378 | Public | 2 | 8 | 0 | handler GUI |
| `AllTab_Click` | 380-384 | Public | 1 | 3 | 0 | handler GUI |
| `Controlled_Click` | 386-390 | Public | 1 | 3 | 0 | handler GUI |
| `ControlledFailed_Click` | 392-396 | Public | 1 | 3 | 0 | handler GUI |
| `Supplem_Click` | 398-402 | Public | 1 | 3 | 0 | handler GUI |
| `Missing_Click` | 404-408 | Public | 1 | 3 | 0 | handler GUI |
| `Expected_Click` | 410-414 | Public | 1 | 3 | 0 | handler GUI |
| `Nettoyer_Click` | 416-448 | Public | 8 | 27 | 0 | handler GUI |
| `Corriger_Click` | 450-562 | Public | 30 | 94 | 0 | handler GUI |
| `DropKey` | 565-580 | Private | 4 | 12 | 0 |  |
| `DropPrimary` | 582-593 | Private | 2 | 8 | 0 |  |
| `SyncKeys` | 595-679 | Private | 29 | 73 | 0 |  |
| `RenumAI` | 681-697 | Private | 3 | 11 | 0 |  |
| `AddKeyCol` | 699-709 | Private | 3 | 7 | 0 |  |
| `KeyDef` | 711-722 | Private | 2 | 9 | 0 |  |
| `KeyCols` | 724-739 | Private | 4 | 12 | 0 |  |
| `SortKeys` | 741-749 | Private | 1 | 6 | 0 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Construction et rafraîchissement

- **`_new(dbconnection)`** [portée : nécessaire] [nature : GUI] : mémorise la connexion et configure
  les 10 colonnes de `GridView1` (titres `EntMysql`, largeurs).
- **`Refresh()`** [portée : réductible] : appelle `Refresh_Data()` sans fichier. Utilisé par
  `Form_Open`.
- **`Refresh_Data(csvin, csvout)`** (CC 50, max du fichier) [portée : réductible, aucun appelant
  externe] [nature : mixte ; extractible : lecture du schéma et comparaison].
  - Si `csvout` : écrit `Data_Expected` (case **Attendu** cochée) ou `Data` en CSV, `Message.Info`,
    et sort. ⚠️ La colonne « Valid. » de `Data` ne contient `OK`/`ERR`/`ABS`/`SUP` **que pour les lignes
    déjà affichées** : ces libellés sont écrits par `GridView1_Data` au moment du dessin (sinon `?` ou
    `0`). Le contenu du CSV exporté dépend donc du défilement de la grille.
  - Si `csvin` : charge `Datain` (lignes du CSV) et réinitialise `Found`.
  - Pour chaque table de `DB_Con.Tables` : `DESCRIBE <table>` (MySQL) ou `PRAGMA table_info(<table>)`
    (SQLite). Pour chaque champ, construit la ligne réelle ; sous MySQL, `SHOW INDEXES FROM <table>
    WHERE Column_name = &1` alimente la colonne clé (`PRI_AI`, `PRI(n)`, `idx_xxx(n)`, séparés par
    `,`). Sous SQLite, moteur et collation sont simulés (`InnoDB`, `utf8mb4_unicode_ci`) et
    `PRI_AI` n'est jamais détecté (`$res!Extra` n'existe pas dans `PRAGMA table_info`, à confirmer :
    erreur ou `Null`).
  - Comparaison avec chaque ligne de `Datain` de même table et même champ (insensible à la casse) :
    colonne par colonne, `?` joue le rôle de joker, les clés sont comparées après tri (`SortKeys`),
    `integer` SQLite accepte tout type `*int*`.
  - Filtres d'affichage selon les boutons radio : `Controlled` (champs référencés seulement),
    `Supplem` (champs en trop seulement), `ControlledFailed` (écarts seulement), `AllTab` (tout).
  - ⚠️ `Datain` et `Found` persistent entre deux appels : après une correction, `Refresh_Data()` sans
    fichier compare encore à l'ancien `Datain`, sans réinitialiser `Found`.
  - Variables locales inutilisées : `$indexes`, `$index`, `$user`, `$field`, `obj`.
- **`Refresh_Data_Missing()`** [portée : réductible] [nature : mixte] : affiche les lignes de
  `Datain` jamais trouvées (`Found = False`), code 2. ⚠️ Ligne 267 : `Valid = New Integer[]` alors que
  `Valid` est déclaré `Integer[][]` (erreur de type à l'exécution probable, à confirmer) ; la valeur de
  retour n'est jamais lue.

### Handlers GUI

- **`Form_Open`** → `Refresh()`. **`Quitter_Click`** → `Me.Close`.
- **`GridView1_Data(Row, Column)`** (CC 15) [nature : GUI] : couleur selon le code de validité (seulement
  si un contrôle a été fait) et **écriture du libellé dans `Data`** (effet de bord sur les données) ;
  affiche `Data_Expected` ou `Data` selon **Attendu**.
- **`Export_CSV_Click`** : crée `~/tmp` et exporte vers `~/tmp/db_control.csv`.
- **`Control_Click`** : `Refresh_Data("db_control.csv", Null)` puis, si **Manquants**,
  `Refresh_Data_Missing()`. `AllTab_Click`, `Controlled_Click`, `ControlledFailed_Click`,
  `Supplem_Click`, `Missing_Click` rappellent tous `Control_Click` (5 handlers identiques).
- **`Expected_Click`** → `GridView1.Refresh`.
- **`Nettoyer_Click`** (CC 8) [nature : mixte] : après confirmation, pour chaque ligne de code 3 :
  `SHOW COLUMNS FROM <table>` ; si c'est le dernier champ, `DROP TABLE`, sinon `DropKey` puis
  `ALTER TABLE … DROP COLUMN`. Barre de progression `ProgBar`. ⚠️ Si une table a plusieurs champs en
  trop dont tous ses champs, le dernier `DROP COLUMN` échoue (le décompte est fait avant chaque
  suppression, donc correct en pratique ; à confirmer) ; le `Catch` affiche `Data_Expected[i]`.
  MySQL uniquement.
- **`Corriger_Click`** (CC 30) [nature : mixte ; extractible : génération des requêtes de correction].
  Pour chaque ligne et chaque colonne en écart :
  - `format` : lit `information_schema.TABLES.ENGINE` pour le schéma `"Laurux" & Start.Societe` et
    lance `ALTER TABLE Laurux<XX>.<table>ENGINE=…`. ⚠️ **Espace manquant** avant `ENGINE` (ligne 487) :
    SQL invalide. ⚠️ Nom de schéma reconstruit en dur : faux si `/dbase/Prefixe` est utilisé
    (`Utils.module:99` construit `Prefixe & Name`).
  - `type` : `MODIFY`. `def` : `CHANGE` avec `NULL`/`NOT NULL` et `DEFAULT` (marque `ValNul` comme
    corrigé). `ValNul` : `MODIFY … NULL|NOT NULL`. `collation` : collation de table puis du champ.
  - code 2 (absent) : `CREATE TABLE` (une seule colonne, moteur attendu) si la table n'existe pas,
    sinon `ALTER TABLE … ADD`.
  - Les tables touchées sont ensuite passées à `SyncKeys` (sauf interruption).
  - `Finally` : ferme la barre, `Commit` (contournement d'un défaut de rafraîchissement de
    `DB_Con.Tables`), `Refresh_Data()`, avertissement « veuillez quitter Laurux ». `Catch` : message
    avec le contexte `ctx`.
  - Les valeurs du CSV (types, défauts, collations, noms) sont concaténées dans le DDL sans contrôle :
    le CSV de référence est considéré comme fiable.

### Gestion des clés (privé, MySQL)

- **`DropKey(NomTable, field)`** : supprime tous les index contenant le champ (clé primaire via
  `DropPrimary`).
- **`DropPrimary(NomTable)`** : `DROP PRIMARY KEY` en retirant dans la même requête l'attribut
  `AUTO_INCREMENT` de la colonne concernée.
- **`SyncKeys(NomTable)`** (CC 29) : construit les index attendus (`wanted`) à partir de la colonne
  clé du CSV (`PRI_AI`, `PRI(n)`, `idx(n)`), les index réels (`actual`) par `SHOW INDEX`, compare la
  clé primaire et l'`AUTO_INCREMENT`, reconstruit la clé primaire si besoin (avec `RenumAI`), puis
  supprime et recrée les index secondaires différents, en une requête `ALTER TABLE` chacun.
- **`RenumAI(NomTable, fld, fldType)`** : si la colonne contient des doublons, des 0 ou des `NULL`,
  ajoute deux colonnes temporaires, conserve la première occurrence de chaque valeur et renumérote
  les autres au-delà du maximum (`@counter`), puis supprime les colonnes temporaires. **Modifie des
  données** (identifiants) : risque fonctionnel si ces identifiants sont référencés ailleurs.
- **`AddKeyCol`**, **`KeyDef`**, **`KeyCols`**, **`SortKeys`** : utilitaires purs de manipulation des
  listes de colonnes (`"seq:champ"` trié ; préfixe `(64)` pour `TEXT`/`BLOB`). [nature : calcul]

## État global utilisé

- `Utils.db` (en plus de `DB_Con`, même objet), `Start.Societe` (nom de schéma reconstruit).
- Fichiers : `db_control.csv` du **répertoire courant**, `~/tmp/db_control.csv` (export).
- Membres d'instance : `Data`, `Data_Expected`, `Valid`, `Datain`, `Found` ; `$indexes` (Object)
  déclaré et jamais utilisé.

## Propositions d'amélioration

### Réécriture / refactorisation

- Découper `Refresh_Data` (CC 50) : `LireStructure(table) As String[][]` (MySQL / SQLite),
  `ComparerLigne(curline, Datain) As Integer[]`, `FiltreAffichage(...)`, `ExporterCsv(...)`.
  `ComparerLigne` est pure et testable en gb.test.
- Déplacer l'écriture des libellés OK/ERR/ABS/SUP de `GridView1_Data` vers la comparaison (même
  rendu ; l'export CSV deviendrait indépendant du défilement : **changement de comportement**, donc
  anomalie A03).
- `Corriger_Click` : extraire `RequetesCorrection(i) As String[]` (génération pure des `ALTER`) ;
  le handler ne fait plus qu'exécuter et afficher.
- Les cinq handlers radio identiques peuvent partager un seul `Control_Click` via un groupe
  d'événements, mais cela impose de modifier le `.form` (`Group`) : **interdit**. On les garde.
- Supprimer `$indexes` (membre) et les variables locales inutilisées.

### Commonalisation avec d'autres fichiers

- Le nom de schéma devrait venir de la connexion (`DB_Con.Name`), comme dans
  [`Utils.module`](../Utils.module/architecture.md) ; même idiome à vérifier dans
  [`LauruxMaj`](../../Communs/LauruxMaj.module/architecture.md) (requêtes `information_schema`).
- La structure attendue (`db_control.csv`) et `Utils.db.AutoIncrement`/`Engine` de
  [`DB_Connection`](../DB_Connection.class/architecture.md) décrivent le même dialecte : un helper
  `DB_Connection.ColonneDDL(type, def, null, collation)` servirait à `Corriger_Click` et aux
  migrations de `LauruxMaj`.

### Réduction de portée

- `Refresh`, `Refresh_Data`, `Refresh_Data_Missing` → `Private` (aucun appelant externe, vérifié par
  grep ; `Fmenu` n'appelle que `New` et `ShowModal`). Couverture par replay uniquement (fenêtre).

### Séparation traitement / GUI

- Comparaison (`ComparerLigne`), lecture du schéma et génération des requêtes de correction sans
  accès aux contrôles ; handlers réduits à l'affichage, aux confirmations et à la barre de
  progression.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Une table de version de schéma par objet (ou un hash de structure par table stocké en base)
  permettrait un contrôle rapide sans relire tout `information_schema`.
- Le format de `db_control.csv` mélange plusieurs index dans une colonne (`PRI(1),idx_x(2)`) : un
  fichier d'index séparé (une ligne par index) simplifierait `SyncKeys`.
