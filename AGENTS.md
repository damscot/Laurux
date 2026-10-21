# AGENTS.md — Laurux

Fichier d'instructions pour les agents de codage travaillant sur ce dépôt.

## Introduction au projet Laurux

**Laurux** est un PGI (progiciel de gestion intégré) français écrit en **Gambas 3** : comptabilité
générale, gestion commerciale, gestion des stocks, point de vente (caisse), facturation, reporting
statistique et GED. Il fonctionne sur **MySQL/MariaDB** (principal) ou **SQLite 3** (portable), sous
Linux, et se déploise aussi en conteneur Docker (Work In Progress).

La version courante se trouve dans le fichier (`.project`, `.version`)
- Auteur historique : Jacky Tripoteau — maintenu par Damien COTTIER et PatrickMag
- Licence : **GPL**
- Site : http://www.laurux.fr

La **Langue de codage** et de **l'interface** sont en **FRANÇAIS**.
Il n'est pas nécessaire de traduire les quelques références en anglais.
L'Internationalisation de Laurux n'est pas prévu, aucun développement ne doit etre fait dans ce sens.

## Layout du dépôt

Analyse et maintient à jour le fichier STRUCTURE.md presentant les répertoires, les fichiers
et leur description associés.

### Composant Gambas et dépendances externes

Analyse et maintient à jour le fichier DEPENDANCES.md presentant uniquement les dépendances externes
du projet, les fichiers sources qui les utilises et leur description associés:
- les modules et executable gambas.
- les librairies et sevices système.
- les utilitaires CLI et programmes.

## Build & Test & Run

Analyse et maintient à jour le fichier README.md presentant les modes d'usage (commande line / gui).
Analyse et maintient à jour le fichier TESTING.md presentant les modes de test unitaire et scripté.

## Gambas 3 — le minimum à connaître

Le langage est proche de BASIC/Pascal. Points critiques :

| Sujet | Règle Gambas 3 |
|---|---|
| Indices | Base **0** (`For i = 0 To n.Max`) |
| Chaînes | `"..."` ; concaténation `&` (jamais `+`) |
| Comparaisons | `=` pour l'égalité, `<>` pour l'inégalité (`==` n'existe pas) |
| Fin de bloc | `End` (fonction/sous) — `Endif`, `End For`, `Next`, `Wend`, `End Select` |
| `If` multi-ligne | `If cond Then` … `Else` … `Endif` (**obligatoire** si > 1 ligne) |
| `Select Case` | `Case x` / `Case 1 To 5` / `Default` |
| Booléens | `True` / `False` (pas de `1`/`0`) — mais voir §6 pour les drapeaux DB |
| Nombres | `&` concaténation vs `/` division réelle vs `\` division entière |
| Passage d'args | `Exec("... &1 ...", val1, val2)` — **placeholder `&N`**, jamais de concaténation directe |
| Collections | `New Collection`, `Col.Add(item, "clef")`, `Col["clef"]`, `Col.Clear` |
| Tableaux | `Dim a As String[]` / `New String[10]` / `New String[][]` |
| Objets | `New Classe(args)`, `If Object.IsValid(x) Then` |
| Erreurs | `Try` / `If Error Then` / `Catch` / `Error.Text` / `Error.Propagate()` |
| Instanciation | `Public Sub _new(args)` (constructeur) — `Create Static` pour une classe sans état d'instance |

⚠️ **Les fichiers `.class` / `.form` sont du texte UTF-8, mais l'outil `Read` les refuse
comme « binary »** (lignes très longues). **Lis-les avec Bash** : `sed -n '10,40p' fichier`,
`cat -n`, `grep -n`. Ne « corrige » pas ce comportement.

**Le typage est statique mais laxiste** : `Dim x As Integer` puis `x = "texte"` ne provoque pas
d'erreur de compilation, seulement un comportement indéfini. Sois rigoureux sur les types. Les classes
`LPrix` et `LDate` donne de bon exemples de gestion d'objet propre à Laurux permettant d'eviter un 
certain nombre d'éceuil lié au conversion de type non controlé en utilisant des propriétés de la classe.
Ex affichage utilisateur `.L/.Q/.QD`, format gambas natif `.G` et base de données `.D/.DT` ou
d'operation spécifique `.PuBHT`.

### Gestion d'erreurs — le style du dépôt

- `Try` / `If Error Then` : 262 fichiers l'utilisent. C'est le mécanisme standard pour les
  opérations risquées (conversion, `Val()`, accès fichier).
- `Catch` : 382 occurrences — utilisé pour le contrôle de flux, notamment dans `DB_Connection.Exec`
  qui affiche un `Message.Error` avec le SQL et la backtrace.
- `Message.Error(...)` : 320 occurrences dans 101 fichiers. C'est **la** way de signaler une erreur
  à l'utilisateur dans ce projet — messages en français, souvent avec le contexte (table, SQL).
- `Error.Propagate()` : seulement 3 occurrences — à utiliser avec parcimonie.

```gambas
' Style dominant : Try + message
Try Decm = Format$(Val(Utils.cpoint(Decm)), "0")
If Error Then
  Message.Error("Valeur numérique invalide : " & Decm)
  Return
Endif
```

## Conventions de nommage (respecter le voisinage)

Analyse statistique sur `.src/**/*.class` (404 classes, 313 forms) :

| Élément | Convention | Exemples |
|---|---|---|
| Classe (fichier `.class`) | `PascalCase` majoritaire, mais **mélange historique** avec `camelCase` | `DB_Connection`, `DB_Sanity`, `FComptes`, `TextReg` **et** `chainage`, `gridvi`, `barselection` |
| Module (`.module`) | `PascalCase` ou `camelCase` | `Utils.module`, `Cbase.module`, `gridv.module` |
| Méthodes | `PascalCase` (6593 occurrences) vs `snake_case` (1561) — **le nouveau code suit PascalCase** | `Form_Open`, `Refresh_Data`, `Maj_Zones` |
| Événements Gambas | `Objet_Evenement` | `Form_Open`, `Button1_Click`, `GridView1_Data`, `ComboBoxYear_Click` |
| Constructeur | `_new` (majuscule ou minuscule selon l'auteur : 191 `_New` / 171 `_new`) | |
| Membres privés | `Private` en tête ; **préfixe `$` dans le style moderne** (125 fichiers, 697 déclarations) | `Private $grdv As GridView`, `Private $soption As String` |
| Membres publics | `Public` pour l'état exposé à la fenêtre appelante | `Public Bsel As Boolean = False` |
| Variables locales | **notation hongroise** : `h` pour les objets (`hFile`, `hCtrl`, `hForm`), `r`/`rr` pour les `Result`, `c` pour les compteurs, `s`/`txt` pour les chaînes | `Dim rResult As Result`, `Dim hCtrl As Object` |
| Tables SQL | `Fiches_*`, `Docs_*`, `Mails_*`, `Corsage` | `Fiches_Art`, `Fiches_Mvt`, `Docs_Ged` |
| Noms de table en variable | `Tab`, `Tab2`, `Tab3` | `Tab = "Fiches_Comptes"` |
| Constantes / énumérations | `Public Enum` + `Public Const` | `Public Enum type_mysql, type_sqlite3` |

### Préfixes de noms de classes — ils sont sémantiques, suis-les

| Préfixe | Signification | Exemples |
|---|---|---|
| `F*` | **F**enêtre (écran) | `Fmenu`, `Fsoc`, `FClient`, `FCloture` |
| `L*` | ob**L**jet valeur / bibliothèque | `LDate`, `LPrix`, `LTaxe`, `LCoul`, `LTrans`, `LScript` |
| `Tri*` | liste triable (widget) | `TriBl`, `TriFac`, `TriArticles`, `TriGen` (classe de base) |
| `Ed*` | **É**dition (écran d'édition/impression) | `Edinv`, `Edbl`, `Edart4` |
| `Vis*` | vi**s**ualisation (lecture seule) | `Visimpayes`, `Visreglements` |
| `Imp*` | **Imp**ression | `ImpSage`, `ImpJdv`, `impfec` |
| `Sai*` | **Sai**sie (saisie de données) | `SaiTableau`, `Sailig` |
| `Raz*` | **Raz**age (purge / remise à zéro) | `RazHistoFac`, `RazDevis`, `RazClientd` |
| `DB_*` | couche base de données | `DB_Connection`, `DB_Sanity`, `DB_Log`, `DB_Desktop` |

Le nom de fichier d'un `.form` est **toujours identique** à celui de sa classe.

**Règle pratique : avant d'écrire, regarde la classe voisine et copie son style.** La cohérence
locale prime sur une règle globale.

### Portée : pas de `Use` en Gambas 3

Gambas 3 n'a pas d'instruction `Use` : **toutes les classes du projet sont visibles globalement**,
sans qualification. On écrit donc `Utils.db.Exec(...)`, `Cbase.Table(...)`, `LPrix(...)`
directement, sans `import`. Les seuls « namespaces » sont les modules globaux (§7).

## Structure d'une classe

`.class` + `.form` vont **toujours ensemble** (404 classes, 313 forms — un `.form` sans `.class`
n'existe pas). Le `.class` porte la logique, le `.form` porte les contrôles.

```gambas
' Gambas class file

Private rResult As Result          ' Privé par défaut : membres d'instance
Private son As Integer = Start.Son ' Initializer d'instance depuis un global

Public Bsel As Boolean = False      ' Public = état exposé à la fenêtre appelante
Public Bval As String

Public Enum tabl, format, name, type, long, def, ValNul, collation, PrimK, Valide

Public Sub _new()
  ' Constructeur
End

Public Sub Form_Open()             ' Événement : à l'ouverture de la form
  ...
End

Public Function MaMethode(x As String) As String
  Dim r As Result
  r = Utils.db.Exec("SELECT ... WHERE a = &1", x)
  If Not r.Available Then Return ""
  Return r!champ
End
```

- **`Private` par défaut pour tout** ; n'expose en `Public` que ce dont l'appelant a besoin.
- Un `Export` / `Create Static` (8 classes) = classe utilitaire sans état d'instance.
- `Inherits` est peu utilisé : `PdfWriter` (génération PDF, 23 classes), `UserControl`, `ScrollView`.
- **`Inherits PdfWriter`** → les méthodes sont en minuscules (`AddPage`, `SetXY`, `Cell`, `SetFont`).

## Base de données — le coeur du projet

### Connexion

La connexion est un **singleton global** déclaré dans `.src/Utils/Utils.module` :

```gambas
Public db As New DB_Connection     ' Utils.db
```

`.src/Utils/DB_Connection.class` hérite de `Connection` (gb.db) et :
- supporte **MySQL et SQLite 3** (`Public Enum type_mysql, type_sqlite3`) ;
- **réécrit le SQL MySQL en SQLite à l'exécution** via des regex (`YEAR()`→`strftime`, `LEFT()`→`substr`,
  `CONCAT()`→`||`, `ISNULL()`→`IS NULL`, `lpad()`→`substr`) ;
- journalise les SQL si `Exec_SQL` est activé (filtre `Is_Filtered`) ;
- interpole les paramètres `&1`, `&2`… via `Subst` (substitution littérale, quotes gérés).

**Paramétrage** : tout est dans `~/.config/gambas3/Laurux.conf`, section `[dbase]` :
`type` (`mysql`|`sqlite3`), `Name`, `Login`, `Password` (chiffré), `Port`, `Host`, `Maj`, `backtrace`.
Écrit par `.src/Communs/LauruxConf.class`.

### Écriture des requêtes

```gambas
' Paramètres : TOUJOURS &1, &2… — jamais de concaténation de valeurs
rResult = Utils.db.Exec("SELECT * FROM " & Cbase.Table("TabArt") & " WHERE art_code = &1", code)

' Lecture d'un champ — opérateur « ! » (3682 usages), pas « [] » (10 usages)
If rResult.Available Then sNom = rResult!art_design

' Parcours — l'idiome du dépôt est Repeat/Until (253 fichiers).
' Do While … MoveNext() n'existe nulle part dans le code.
If rResult.Available Then
  Repeat
    ...
  Until rResult.MoveNext()
Endif

' Test de disponibilité — TOUJOURS avant de lire un résultat
If Not rResult.Available Then Return
```

**Règles impératives** :
1. **`&1`, `&2`… pour toute valeur** — jamais de concaténation (injection SQL + quoting cassé).
2. `Cbase.Table("TabXxx")` pour les noms de tables (mapping `TabXxx` → `Fiches_Xxx` dans
   `.src/Utils/Cbase.module`, ~191 fichiers l'utilisent). N'écris pas `Fiches_Art` en dur dans une
   requête : passe par `Cbase.Table`. Le passage des noms des tables pour la requete passe par concaténation.
3. `If Not rResult.Available Then Return` avant tout accès aux champs.
4. `Result` est fragile : une seule ligne à la fois, `MoveNext()` avance.
5. **Le nombre de lignes se lit `rResult.Count`** (715 usages).
6. `UPdate` avec un **P majuscule** est l'habitude du dépôt (`"UPdate " & Tab & " SET ..."`).
   Ce n'est pas une faute de frappe : ne le « corrects » pas.
7. Il existe du SQL legacy par concaténation (ex. `TriBl.class` : `cdclibl = " & Clicode`).

### Surface d'API de `DB_Connection`

| Appel | Rôle |
|---|---|
| `Utils.db.Exec(sql, args...)` | exécute une requête, renvoie un `Result` (usage principal) |
| `Utils.db.Subst(sql, args...)` | construit un fragment SQL paramétré (`&1`, `&2`) |
| `Utils.db.Edit(table, sql, args...)` | met à jour une ligne |
| `Utils.db.Create(table)` | crée une table |
| `Utils.db.Engine()` | `" ENGINE = InnoDB"` sur MySQL, `""` sur SQLite — pour terminer un `CREATE TABLE` |
| `Utils.db.AutoIncrement("lind")` | `NOT NULL AUTO_INCREMENT, PRIMARY KEY(...)` (MySQL) vs `INTEGER PRIMARY KEY AUTOINCREMENT` (SQLite) |
| `Utils.db.Begin` / `.Commit` / `.Rollback` | transactions |
| `Utils.db.IsType(Utils.db.type_mysql)` | branchement de dialecte |
| `Utils.db.Lockstock` / `.LockIncrement` / `.CopieTable` | verrous et copie de table |

`Utils.db` est le **seul** handle de connexion du projet (7001 usages). Il n'existe pas de
`hDB` dans ce code.

### Les modules globaux (l'état partagé)

Gambas 3 n'a pas de classe `Globals` : les membres `Public` d'un `.module` sont des **singletons
globaux**, accessibles comme `ModuleName.Member` depuis n'importe où. Le projet en utilise cinq :

| Module global | Rôle |
|---|---|
| **`Start`** | état d'exécution applicatif : `Start.LocalSettings`, `Start.GlobalSettings`, `Start.Societe`, `Start.Musique`, `Start.R/G/B` (couleurs du thème), `Start.MainWindow`, `Start.Exit`, `Start.Success`, `Start.Restart`, `Start.version_sha1`, `Start.version_branch`, et tous les `Start.Arg_*` |
| **`Utils`** | fonctions utilitaires **et le handle BDD** `Utils.db`, plus `Utils.rs1..rs4`, l'état du tunnel SSH (`Utils.MysqlServeur`, `Utils.SshHost`, `Utils.TunnelPid`…) |
| **`Variables`** | état d'UI partagé entre écrans : `Variables.bRemise`, `Variables.Bsel`, `Variables.ArtCode`, `Variables.impr`, `Variables.Qte`… (`.src/Utils/Variables.module`) |
| **`Cbase`** | `Cbase.Table("TabX")` → nom de table physique |
| **`Serveur`** | `Serveur.Pass("Art", "M", code, "")` — échange inter-processus par fichier avec un « serveur » |

Fréquence d'usage : `Start.LocalSettings` 1979, `Start.Societe` 1237, `Utils.db` 7001,
`Utils.cpoint` 859, `Utils.Observers` 252.

**Config** : tout se lit via `Start.LocalSettings["/section/key"]` (objet `gb.settings`, format
INI). Sections : `/Soc`, `/Soc01/...` (par société), `/Coul/...` (couleurs), `/dbase/...`
(type, Name, Prefixe, Login, Password, Host, Port, Maj, backtrace, Con-ssh), `/dbase/ssh/...`,
`/son`, `/Tips`, `/General`. Fichier : `~/.config/gambas3/Laurux.conf` (surchargeable par `-c`).

Au démarrage, `Start.Main()` lit `branch.txt` et `sha1.txt` (écrits par le `Makefile`), puis
`Lancement()` crée la fenêtre principale : `New Cmenu` si `-p` (PDV/POS), sinon `New Fmenu` (Gestion).

**Comportement SQLite non évident** : `DB_Connection.Exec` injecte `COLLATE NOCASE` dans les
clauses `WHERE` (avant `ORDER BY`) pour que les comparaisons soient insensibles à la casse,
et neutralise `LOCK TABLES` / `UNLOCK TABLES` (returns `Null`).

### Types & schéma

- 134 tables. Noms : `Fiches_*` (données métier), `Docs_*` (GED), `Corsage` (paramétrage).
- Clés primaires composites fréquentes : `(num_ligbl, numlig_ligbl)`, `(code, numrecpt, four, daterecpt, nligne)`.
- `Fiches_Mvt` … `Fiches_Mvt5` : **exactement la même structure** (27 colonnes identiques) répliquée
  en 6 versions. `Fiches_MvtM`/`MvtM1-5` (30 col.) et `Fiches_MvtA`/`MvtA1-5` (13 col.) sont des
  variantes proches mais **pas identiques**. Toute modification de schéma sur `Fiches_Mvt`
  doit être répliquée sur les 5 variantes `Mvt1-5`.
- Les colonnes booléennes sont stockées en `tinyint` `0`/`1` **et** lues comme `String` dans
  Gambas (`If validée = "1"`). Vérifie le type réel avant de comparer.

### Mises à niveau de schéma (CRITIQUE)

`.src/Communs/LauruxMaj.module` (6116 lignes, 107 fonctions `MajXXX()`) contient **tous** les scripts
de migration. Le **pattern courant** (depuis la 3.66) se base sur la version stockée en base dans
`Fiches_Parametres.version` :

```gambas
'************************* Maj 3.69 *********************
rResult = Utils.db.Exec("SELECT * from  Fiches_Parametres")
If rResult!version = "3.68" Then
  If Start.LocalSettings["/dbase/Maj"] Then Maj369()
  Try Utils.db.Exec("update Fiches_Parametres set version = &1 ", "3.69")
Endif
```

Le pattern **historique** (migrations 2.04 → 3.66, encore présent en tête de fichier) peuvent ignoré pour le codage actuel.

**Toute modification de schéma doit être écrite ici** : nouvelle fonction `Public Sub MajXYX()` +
nouveau bloc de dispatch dans `Verif_Version()`, avec bump de `Version` dans `.project` et `.version`.
**Ne jamais éditer une migration dont la version du tag existe dans le repo git** : les bases déjà en production l'ont exécutée.

Points d'attention :
- Les migrations s'exécutent **par société** (multi-sociétés, `Fiches_Societes`) dans l'ancien
  pattern ; vérifie si ta migration doit l'être aussi (schéma global vs données par société).
- `Start.LocalSettings["/dbase/Maj"]` (le drapeau « Maj ») peut désactiver la 
  migration automatique (`Maj=0` désactivé, `Maj=1` ou `Maj=-1` activé).
- Le bloc est encadré par un `Catch` global qui affiche un message d'erreur grave et invite à
  restaurer la base : une migration qui plante laisse la base dans un état intermédiaire.

### Contrôle de structure : `DB_Sanity`

`.src/Utils/DB_Sanity.class` compare la structure réelle de la BDD à une **référence CSV**
(`db_control.csv`, 1921 lignes, séparateur `;`, 10 colonnes :
`Table;Engine;Champ;Type;Long.;Def.;Null;Collation;Clée;Valid.`).
Il sert à détecter les écarts après une migration (index manquants, type modifié…) et sait
**aligner** la base sur la référence (`SyncKeys()` : clef primaire, `AUTO_INCREMENT`, index
secondaires).

Accessible depuis le menu **Admin** (`.src/Communs/Fmenu.class`, `Menu142_Click`, protégé par
mot de passe si `Admin` est activé). Le CSV de référence est lu depuis le **répertoire courant** :
`Refresh_Data("db_control.csv", Null)`. C'est l'outil à utiliser quand tu touches au schéma.

## Dépôt Git

- Tu peux modifier les fichiers mais, ne commit rien ou ne stash rien,
seul l'utilisateur a le droit de commiter/stasher ces propres modifications.
- tu peux proposer à l'utilisateur des commandes git modifiant l'historique mais seul 
l'utilisateur pourra les lancer lui-même.
- tu peux consulter l'historique git pour identifier les modifications en cours et comparer 
d'autre référence (branche/tag/sha1).

## Zones d'expérimentation (non versionnées) et temporaire pour la session

L'ensemble des fichier temporaire utilisé pour la memoire du contexte, des scripts, les plans
doivent etre archivé sous "output/<agent_name>/<session_name+date>/<fonctionnalite>"
N'utilise pas les données dans "output" comme référence, sauf si le repertoire est celui de la session courante.
L'utilisateur peut autoriser explicitement la recherche dans un autre répertoire d'output ou en dehors du repository.

## Règles de travail pour un agent

### Avant de coder
1. `git status` + `git branch` — tu es peut-être sur une branche de développement non propre.
2. Cherche la classe voisine qui fait la même chose : **copie son idiome** (requêtes, nommage,
   gestion d'erreur, structure de form). Propose toute factorisation qui permettrait de limiter
   la duplication de code.
3. Vérifie si la donnée est en BDD (`Fiches_*`) ou dans `Start.LocalSettings["/Soc<XX>/..."]`
   (paramétrage local ou overide global via blob `conf` dans `Fiches_Parametres` par société).
4. **Lis les `.class`/`.form` avec Bash** (`sed -n`, `grep -n`), pas avec l'outil `Read` qui les
   refuse comme binaires.

### En codant
5. **SQL paramétré obligatoire** (`&1`, `&2`) + `Cbase.Table("TabX")` pour les noms de tables.
6. **`If Not r.Available Then Return`** avant de lire un `Result`.
7. **Toute modification de schéma** → nouveau bloc `MajXYX()` dans `LauruxMaj.module` + bump de
   version dans `.project`/`.version` + mise à jour de `db_control.csv` et des base de référence
   `Laurux01.{sql,sqlite}` si la structure change.
8. **Modifications multi-sociétés** : `LauruxMaj` n'itère plus sur les différentes sociétés de la
   base pour les versions récentes mais uniquement sur celle sélectionné, applique ce principe.
9. **SQLite** : n'introduis pas de syntaxe MySQL non traduite par `DB_Connection` (les regex ne
   couvrent que `YEAR/MONTH/DAY/NOW/CONCAT/LEFT/RIGHT/MID/ISNULL/ABS/lpad`). Ex. `FIND_IN_SET`,
   `GROUP_CONCAT`, `IFNULL` ne sont **pas** traduits.
10. **Multiplication `Fiches_Mvt`/`Mvt1-5`** (structure identique, 27 col.) : toute modif sur une,
    applies-la aux 6. Idem pour `MvtM*` et `MvtA*` (structures distinctes entre elles).
11. Commentaires et messages utilisateur **en français**, dans le style existant.
12. **Chaînes affichées à l'utilisateur** → forme `("texte")` pour qu'elles soient extraites en i18n.
13. **Si tu touches une classe de logique métier**, ajoute-lui une méthode
    `Public Sub Internal_Test(Test_List As String[]) As Boolean` (convention `Build & Test & Run`) vérifiant des comportement attendus ou bornés de la classe.

### Valider
14. `gbc3 -agt` doit passer sans erreur — **lance-le à la main**, `make` masque les erreurs.
15. `./Laurux -t all` doit sortir en code 0 (harnais `Internal_Test`).
16. `gba3 -o Laurux` si tu as touché à des classes exportées / à `Start.module`.
17. Ne prétends pas avoir testé l'IHP : le harnais `Internal_Test` ne couvre que la logique pure,
    le login MySQL et le pilotage de la caisse restent manuels.

### Règles de communication
18. **Rends compte fidèlement** : si le build passe mais que tu n'as pas lancé l'application,
    dis-le. Si un test n'existe pas, dis-le — ne le présente pas comme vérifié.
19. Ne modifie pas `.gambas/`, `.settings`, `.startup`, `.lang/*.pot` (générés).
20. Ne supprime pas les fichiers `*~` ils sont .gitignore et sont générés par l'IDE de développement gambas.
21. **Ne réécris pas les gros fichiers Legacy** (`Facture.class` = 12 479 lignes,
    `Caisse.class` = 8 734). Ce sont des fichiers stables, à risque élevé de régression.
    Modifie de façon minimale et ciblée.

## 13. Glossaire métier

| Terme | Signification |
|---|---|
| **Société** | Entité légale gérée (code `01`, `02`…) — `Fiches_Societes`, multi-tenant via `Start.Societe` |
| **Exercice** | Année comptable — `LDate.EDeb` / `EFin` / `EInd` |
| **Écriture / Mvt** | Écriture comptable — `Fiches_Mvt` + `Fiches_Mvt1-5` (ventes, achats, banque, caisse…) |
| **Compte** | Plan comptable — `Fiches_Comptes` (code `411xxx`, `512xxx`…) ; postes : `Fiches_Postes` |
| **Client / Fournisseur** | Tiers — `Fiches_Cli` / `Fiches_Four` (contacts : `Fiches_ContactC` / `Fiches_ContactF`) |
| **Article / Matériel** | Article en stock — `Fiches_Art` ; famille : `Fiches_Fam` |
| **Ticket** | Ticket de caisse (PDV ou POS) — `Fiches_HisEntTickets` (entête) / `Fiches_HisLigTickets` (lignes) |
| **BL / Facture / Devis / Commande** | Bon de livraison `Fiches_Bl` (+ `Fiches_Ligbl`), facture `Fiches_HistoFac` (+ `Fiches_HistoLigfac`) |
| **Règlement** | Paiement — `Fiches_Reglements` ; acompte : `Fiches_Acomptes` ; échéance : `Fiches_Echeances` |
| **Lettrage** | Rapprochement d'un règlement avec une facture — `Lettrage.class` (`.src/Compta/Lettrages/`) |
| **Clôture** | Clôture d'exercice comptable — `.src/Compta/Clotures/` (`FCloture`, `FClotureAn`) |
| **Moulinage** | Génération des écritures depuis les documents de vente en caisse (PDV ou POS)  — `Caisse/Moulinage.class` |
| **GED** | Gestion Électronique de Documents — `Docs_Ged`, `Docs_Tag`, `Fiches_Tag` |
| **Mail** | Courriers clients / fournisseurs — `Mails_Cli`, `Mails_Four` (envoi de factures par mail) |
| **Caisse / PDV** | Point de vente (PDV ou POS) — `Caisse/`, lancé par `./Laurux -p` |

