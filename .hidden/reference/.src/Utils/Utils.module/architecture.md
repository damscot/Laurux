# Utils — Architecture

> Source : `.src/Utils/Utils.module`

## Vue d'ensemble

`Utils` est le **module fourre-tout historique** de Laurux. Il réunit, sans découpage thématique :

1. **l'état global de connexion** : le singleton `db As New DB_Connection` (seul handle BDD du projet,
   environ 7 500 usages dans 347 fichiers), `de As New DB_Desktop` (détection du bureau), les quatre
   `Result` partagés `rs1`…`rs4` qui alimentent les `GridView` en mode virtuel, et l'état du tunnel SSH
   (`MysqlServeur`, `SshHost`, `TunnelPid`…) ;
2. **des conversions de format** (nombres virgule/point, dates en une douzaine de formats, booléens) ;
3. **des helpers GUI** : couleurs du thème (`Fcolr`, `Observers`, `ObsGotf`/`ObsLstf`), remplissage de
   grilles (`Base`…`Base4`), enregistrement des `ReplayObserver` (log/replay) ;
4. **quelques fonctions métier ou SQL** : échéance (`Calcech`, CC 77, max du fichier), code-barres
   (`Calcode`, `Find_cbarre`), quantité commandée (`Commande`), option bois (`Option`, `orientation`) ;
5. **de l'administration MySQL par shell** (`Fill_DataBase`, `Clear_DataBase`, `Create_DataBase`) et des
   utilitaires système (`Exit`, `Mkdir_p`, `Rmdir_rf`, `Log`, son, curseur souris).

Les 76 fonctions sont toutes `Public`. Une partie des appels passe par `With Utils … End With`
(194 fichiers, environ 820 blocs) avec la forme `.cpoint(…)`, `.Cdate_Aff(…)`, `.rs1!champ` : ces appels
**échappent à `deps.py`** (voir dependencies.md) et doivent être recherchés par grep sur `\.nom\b` à
l'intérieur des blocs `With Utils`.

Nature globale : **mixte**. Environ la moitié des fonctions sont des calculs purs testables en gb.test ;
les autres touchent des contrôles, `Message`, `Music`, le shell ou la base.

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `db` | var | Public | oui | New DB_Connection | 9 |
| `de` | var | Public | oui | New DB_Desktop | 10 |
| `rs1` | var | Public | oui | Result | 11 |
| `rs2` | var | Public | oui | Result | 12 |
| `rs3` | var | Public | oui | Result | 13 |
| `rs4` | var | Public | oui | Result | 14 |
| `MysqlServeur` | var | Public | oui | String | 15 |
| `mysqlPort` | var | Public | oui | String | 16 |
| `SshPort` | var | Public | oui | String | 17 |
| `SshPassw` | var | Public | oui | String | 19 |
| `SshPassphrase` | var | Public | oui | String | 20 |
| `SshHost` | var | Public | oui | String | 21 |
| `SshUser` | var | Public | oui | String | 22 |
| `RemotePort` | var | Public | oui | String | 23 |
| `TunnelPid` | var | Public | oui | String | 24 |
| `ROArray` | var | Public | oui | ReplayObserver[] | 26 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Exit` | 30-36 | Public | 1 | 5 | 3 |  |
| `Base` | 39-49 | Public | 2 | 9 | 28 |  |
| `Base2` | 51-61 | Public | 2 | 9 | 10 |  |
| `Base3` | 63-73 | Public | 2 | 9 | 2 |  |
| `Base4` | 75-85 | Public | 2 | 9 | 2 |  |
| `glb` | 93-129 | Public | 3 | 27 | 2 |  |
| `monteTunnel` | 136-191 | Public | 8 | 42 | 3 |  |
| `fermeTunnel` | 197-208 | Public | 3 | 10 | 5 |  |
| `do_pcre_extract` | 216-232 | Public | 3 | 14 | 0 | portée réductible ? |
| `Form_Close` | 239-243 | Public | 1 | 3 | 0 | portée réductible ? |
| `ControlTunnel` | 248-263 | Public | 2 | 12 | 3 |  |
| `cpoint` | 267-275 | Public | 2 | 7 | 126 |  |
| `CDec` | 277-292 | Public | 7 | 14 | 22 |  |
| `CSlash` | 294-298 | Public | 1 | 3 | 1 |  |
| `PointBase` | 300-304 | Public | 1 | 3 | 29 |  |
| `Cdate2_Dbase` | 306-314 | Public | 2 | 7 | 1 |  |
| `Cdate_Dbase` | 316-324 | Public | 2 | 7 | 61 |  |
| `Cdate_Comp` | 326-377 | Public | 16 | 49 | 17 |  |
| `Cdate_Comp2` | 379-388 | Public | 2 | 8 | 0 | portée réductible ? |
| `Cdate_Carte` | 390-398 | Public | 2 | 7 | 1 |  |
| `Cdate_Aff` | 400-407 | Public | 2 | 7 | 76 |  |
| `Cdate_Com` | 409-418 | Public | 2 | 8 | 0 | portée réductible ? |
| `Cdate_Ciel` | 420-428 | Public | 2 | 7 | 1 |  |
| `Cdate_Cador` | 430-438 | Public | 2 | 7 | 1 |  |
| `Cdate_Sage` | 440-448 | Public | 2 | 7 | 1 |  |
| `Cdate_calc` | 450-480 | Public | 12 | 28 | 42 |  |
| `convBool` | 482-493 | Public | 3 | 9 | 12 |  |
| `convStr` | 495-506 | Public | 3 | 9 | 0 | portée réductible ? |
| `Calc_mois` | 508-534 | Public | 3 | 23 | 20 |  |
| `SetEditColor` | 539-581 | Public | 7 | 29 | 78 |  |
| `Calcode` | 586-608 | Public | 4 | 20 | 3 |  |
| `Find_cbarre` | 613-632 | Public | 4 | 17 | 20 |  |
| `Find_nbdec` | 637-652 | Public | 3 | 13 | 27 |  |
| `Calcech` | 657-772 | Public | 77 | 106 | 6 |  |
| `Remplace` | 774-781 | Public | 4 | 6 | 16 |  |
| `ReplaceLb` | 783-789 | Public | 3 | 5 | 9 |  |
| `Replace` | 791-807 | Public | 13 | 15 | 3 |  |
| `Nsoc` | 809-818 | Public | 1 | 7 | 0 | portée réductible ? |
| `Fcolr` | 820-842 | Public | 7 | 20 | 79 |  |
| `Fcoulfond` | 844-866 | Public | 7 | 20 | 0 | portée réductible ? |
| `Recursive_Observers` | 869-1008 | Public | 48 | 122 | 0 | portée réductible ? |
| `Observers` | 1011-1054 | Public | 19 | 40 | 230 |  |
| `ObsGotf` | 1056-1070 | Public | 3 | 12 | 40 |  |
| `ObsLstf` | 1072-1087 | Public | 6 | 13 | 43 |  |
| `ObsLstf2` | 1089-1102 | Public | 2 | 11 | 2 |  |
| `Obstch` | 1104-1115 | Public | 4 | 10 | 10 |  |
| `Formattage` | 1117-1121 | Public | 1 | 3 | 1 |  |
| `Coulfonds` | 1123-1133 | Public | 3 | 9 | 1 |  |
| `Commande` | 1135-1170 | Public | 10 | 33 | 2 |  |
| `Coulfd` | 1172-1179 | Public | 1 | 5 | 44 |  |
| `chkEmail` | 1181-1196 | Public | 7 | 14 | 4 |  |
| `Accent` | 1198-1211 | Public | 10 | 12 | 3 |  |
| `mois` | 1213-1246 | Public | 13 | 30 | 4 |  |
| `lastday` | 1248-1260 | Public | 3 | 9 | 5 |  |
| `Next_Code` | 1262-1324 | Public | 18 | 55 | 2 |  |
| `Option` | 1326-1336 | Public | 5 | 8 | 21 |  |
| `orientation` | 1339-1379 | Public | 13 | 35 | 2 |  |
| `totobs` | 1381-1396 | Public | 4 | 13 | 16 |  |
| `arrondi` | 1398-1437 | Public | 9 | 37 | 8 |  |
| `fam` | 1439-1452 | Public | 4 | 11 | 2 |  |
| `PageFormatSupported` | 1454-1458 | Public | 1 | 3 | 1 |  |
| `PageFormatGetX` | 1460-1478 | Public | 5 | 16 | 0 | portée réductible ? |
| `PageFormatGetY` | 1480-1498 | Public | 5 | 16 | 0 | portée réductible ? |
| `Fill_DataBase` | 1500-1530 | Public | 7 | 27 | 3 |  |
| `Clear_DataBase` | 1532-1536 | Public | 1 | 3 | 2 |  |
| `Create_DataBase` | 1538-1542 | Public | 1 | 3 | 2 |  |
| `FloatParse` | 1544-1575 | Public | 7 | 27 | 2 |  |
| `Ciel` | 1578-1602 | Public | 7 | 22 | 3 |  |
| `Fill_Civilite` | 1604-1620 | Public | 7 | 14 | 3 |  |
| `Play` | 1622-1633 | Public | 3 | 10 | 0 | portée réductible ? |
| `Bip` | 1635-1639 | Public | 1 | 3 | 6 |  |
| `MouseProcessing` | 1641-1650 | Public | 3 | 8 | 3 |  |
| `MouseDefault` | 1652-1661 | Public | 3 | 8 | 3 |  |
| `Log` | 1663-1686 | Public | 4 | 18 | 2 |  |
| `Mkdir_p` | 1688-1699 | Public | 4 | 8 | 1 |  |
| `Rmdir_rf` | 1701-1716 | Public | 6 | 10 | 1 |  |
<!-- /AUTO:fonctions -->

## Description des fonctions

Les usages indiqués (« n occ. / f fichiers ») cumulent les appels `Utils.X` et les appels `.X` dans
un bloc `With Utils` (grep au commit `6b6b9dfc`).

### 1. Système, sortie, journalisation

- **`Exit(Optional Success = True)`** [portée : nécessaire] [nature : calcul/système]. Positionne
  `Start.Success` et `Start.Exit`, puis envoie `SIGINT` au processus pour sortir de la boucle
  d'attente de 60 s. Appelants : `Start.module` (2), `FRestore` (3), `Fmenu` (1).
- **`Log(Obj, sMessage, level)`** [portée : nécessaire] [nature : calcul]. Crée à la demande un `LLog`
  par nom de classe dans `Start.LLogColl` (activé par défaut si `Start.Arg_Debug`) puis journalise.
  Appelants : `LScript` (3), `TriArticles` (1).
- **`Mkdir_p(Dir, OwnerShip)`** / **`Rmdir_rf(Dir)`** [portée : nécessaire] [nature : système].
  `Shell "mkdir -p " & Dir` puis `Chmod` ; `Shell "rm -rf " & Dir` avec une garde (`Null`, `/`,
  `User.Home`). Renvoient `True` en cas d'**échec**. ⚠️ Chemin non quoté : un chemin contenant un
  espace est découpé par le shell ; pour `Rmdir_rf`, cela peut supprimer **d'autres** répertoires
  (anomalie UTILS-A07). Appelant unique : [`LGed`](../LGed.class/architecture.md) (5 + 2).
- **`MouseProcessing()`** / **`MouseDefault()`** [portée : nécessaire] [nature : GUI]. Curseur sablier /
  normal sur `Start.MainWindow` et `Application.ActiveWindow`. Appelants : `Moulinage`, `Calcsolde`,
  `DB_Connection`.
- **`Play(Optional Sound)`** [portée : réductible, seul appelant `Bip`] [nature : GUI/son]. Charge
  `son/<Sound>.ogg` (défaut `warning.ogg`) et le joue si `Start.son`.
- **`Bip()`** [portée : nécessaire] [nature : GUI/son]. Alias de `Play()`. 41 occ. / 6 fichiers
  (`Pointage`, `Moulinage`, `Caisse`, `Articles`, `DocActif`, `Abont`).

### 2. Grilles virtuelles : `Base`…`Base4` et `rs1`…`rs4`

- **`Base(tbv, qry)`**, **`Base2`**, **`Base3`**, **`Base4`** [portée : nécessaire] [nature : mixte].
  Exécutent `db.Exec(qry)` (requête **déjà construite par concaténation** chez l'appelant, sans
  paramètre `&N`), rangent le `Result` dans `rs1`/`rs2`/`rs3`/`rs4`, puis fixent `tbv.Rows.Count`.
  Le handler `GridView_Data` de l'appelant lit ensuite `Utils.rsN` (`.rs1.MoveTo(Row)`). Les quatre
  fonctions sont **strictement identiques** au nom du `Result` près.
  Appelants : `Base` 28 fichiers (dont `Archives` 26 occ., `FClient`, `ConsultArt`, `TriEcritures`…),
  `Base2` 10 fichiers (famille `Tri*`, `DocActif`, `RelMoprod`), `Base3` 3 fichiers (`Ccomptes`,
  `Facture`, `Archives`), `Base4` 2 fichiers (`TriMo`, `Facture`).
  ⚠️ Couplage global : deux écrans ouverts simultanément qui utilisent la même `BaseN` partagent le
  même `Result` ; le premier écran affiche alors les données du second. C'est la raison d'être des
  quatre variantes (un numéro par « niveau » d'écran). Partie extractible : l'exécution SQL ; la
  partie GUI se limite à `Rows.Count`.

### 3. Connexion BDD et tunnel SSH

- **`glb()`** [portée : nécessaire] [nature : calcul/config]. Copie la section `/dbase/*` de
  `Start.LocalSettings` dans `db` (type, nom préfixé, login, mot de passe déchiffré par
  `hexdblKey.Crypt("de", …, "Laurux")`, hôte, port) ; si `/dbase/Con-ssh`, l'hôte devient
  `127.0.0.1` sur le port local et les variables SSH globales sont remplies (mot de passe SSH
  déchiffré avec la clé `"LauruX2012"`). En SQLite : `Name & ".sqlite"`. Termine par
  `db.Backtrace(...)`. Appelants : `Fmenu`, `Cmenu`.
  Doublon : [`LauruxConf`](../../Communs/LauruxConf.class/architecture.md) lignes 245-251 recopie la
  partie SSH de `glb`.
- **`monteTunnel()`** [portée : nécessaire] [nature : système + GUI]. Cherche un tunnel existant
  (`ps u -C ssh | grep port:serveur:port`) ; sinon lance `ssh -N -f user@host -p port -L …` et extrait
  le PID de la sortie `ps` (premier champ non vide après l'utilisateur). Si un tunnel existe déjà,
  `Message.Question` demande s'il faut le fermer en fin d'application. Traces par `Print`. Appelants :
  `Fmenu`, `Cmenu`, `LauruxConf`. ⚠️ `For i = 1 To $array_pid.Count` : dépassement d'indice si aucun
  champ non vide n'est trouvé (UTILS-A06).
- **`fermeTunnel()`** [portée : nécessaire] [nature : système]. `Exec ["kill", TunnelPid]` si
  `TunnelPid` est renseigné. Appelants : `FRestore` (3), `Fmenu`, `LauruxConf`, `ClotureF`, `FCloture`.
- **`do_pcre_extract(cible, regex)`** [code mort] [nature : calcul]. Extraction des captures d'une
  regex ; ses seuls appels sont commentés dans `monteTunnel`.
- **`Form_Close()`** [code mort] [nature : GUI]. Handler d'événement placé dans un **module** : il
  n'est jamais déclenché et aucun code ne l'appelle.
- **`ControlTunnel()`** [portée : nécessaire] [nature : système]. Malgré son nom, vérifie l'**état de
  la réplication MySQL** (`show slave status \G | grep Slave_SQL_Running`, cherche `YES`).
  Appelants : `Start.module:113`, `Fmenu` (14 occ.), `Facture` (1). ⚠️ La commande est mal formée :
  clé `Start.LocalSettings[" / dbase / Host "]` (espaces, donc toujours vide), options `- p` et
  `- e` séparées par des espaces, hôte passé sans `-h`. Le résultat est probablement **toujours
  `False`** quand la réplication est configurée (UTILS-A01, à confirmer sur une installation
  répliquée). Le mot de passe apparaît en clair dans la ligne de commande.

### 4. Administration MySQL par shell

- **`Fill_DataBase(Tab, filepath)`** [portée : nécessaire] [nature : système + SQL]. Copie le dump
  dans un répertoire temporaire (le fichier peut être embarqué dans l'exécutable), retire la ligne
  `sandbox` des dumps MariaDB récents (`sed -i`), l'importe par `mysql -h … -u … -p<mdp> <base> <`,
  renvoie la sortie d'erreur, puis émet `SET @@global.sql_mode`, `ALTER DATABASE … COLLATE
  utf8mb4_unicode_ci` et `SET NAMES`. Appelants : `Start.module:468` (restauration en ligne de
  commande), `FRestore`, `LauruxConf`. MySQL uniquement.
- **`Clear_DataBase(Tab)`** / **`Create_DataBase(Tab)`** [portée : nécessaire] [nature : système].
  `mysql -e "Drop database <Tab>;"` / `"Create database <Tab>;"`. Appelants : `Start.module:466-467`,
  `FRestore`.
  Ces trois fonctions et [`Mmysql.Process_List`](../Mmysql.module/architecture.md) construisent la
  même ligne `mysql -h -u -p` : mot de passe visible dans `ps`, nom de base non échappé.
- **`Ciel()`** [portée : nécessaire] [nature : SQL, DDL]. Crée les tables `Ciel_Lrx` et `Ciel_Lrx_Jo`
  (`Try CREATE TABLE … & db.Engine()`), puis ajoute la colonne `imp_ciel` à `Fiches_Parametres` si
  elle est absente. **Modification de schéma hors de `LauruxMaj`** ; ces objets sont absents de
  `db_control.csv`. Appelants : `Cielcorsp`, `Cielcorspj`, `impfec`.

### 5. Conversions numériques

- **`cpoint(mtt)`** [portée : nécessaire] [nature : calcul]. `Null` → `"0"`, sinon `LTrim` puis
  `.` → `,` (préparation à `Val()`, qui est localisé). **Fonction la plus appelée du module après
  `db`** : environ 2 100 occ. / 170 fichiers (1 006 en `Utils.cpoint`, 1 119 en `.cpoint`).
  Doublons locaux sans le test `Null` ni le `LTrim` : `Cpostaux`, `Marques`, `Lettrage`, `FTvac`,
  `FComptes`, `ArchivesTck` (voir Commonalisation).
- **`PointBase(mtt)`** [nature : calcul]. `,` → `.` (format base). 155 occ. / 30 fichiers.
- **`CSlash(mtt)`** [nature : calcul]. `.` → `/`. 1 occ. (`ExportJdv`, via `With Utils`).
- **`CDec(nbdec, Decm)`** [nature : calcul]. Formate `Decm` avec 0, 2 ou 3 décimales selon `nbdec`
  (`"0"`, `"2"`, `"3"`) ; toute autre valeur renvoie `Decm` inchangé. Conversion en `Try` : une
  valeur invalide est renvoyée telle quelle. 54 occ. / 27 fichiers.
- **`Find_nbdec(nbd)`** [nature : calcul]. Masque de format : `"0"` → `"0"`, `"2"` → `"0.00"`,
  sinon `"0.000"`. Même table que `CDec`, mais défaut différent (3 décimales). 51 occ. / 34 fichiers.
- **`FloatParse(Val)`** [nature : mixte]. Lit une chaîne « ±1 234,56 » ou « 1 234.5 » par regex et
  renvoie un `Float`. Échec → `Message.Error` puis 0 (GUI dans une fonction de calcul). Appelants :
  [`LPrix`](../LPrix.class/architecture.md) (8), [`LTaxe`](../LTaxe.class/architecture.md) (1). Le
  test `$reg.Count = 3` (motif à 3 groupes) est à confirmer par les tests de caractérisation.
- **`arrondi(montant, ndec)`** [nature : calcul]. Arrondi « demi vers le haut » sur la valeur absolue,
  implémenté par conversion `Str` → `Split(",")`. ⚠️ Dépend de la locale (séparateur décimal de
  `Str$`, à confirmer) ; `If Round(retour, -ndec) = 0` force 0. 58 occ. / 8 fichiers (`ObjFacB` 18,
  `ObjFac` 12, `calculdroit`, `EcrAuto`, `SaiReg`, `VarEcr`, `Listextcpt`, plus un fichier via
  `With Utils`).
  Homonymes **différents** (arrondi au 0,05 en chaîne) : `Caisse.arrondi`, `Moulinage.arrondi`,
  `Facture.arrondi`, `Articles`, `Movr`, `Materiel`, `FTvav` ; et `LPrix.Arrondi_Calc`.
- **`totobs(tot As String[])`** [nature : calcul]. Somme des éléments numériques (`.` → `,`, puis
  `IsNumber`/`Val`, dépendants de la locale). 80 occ. / 16 fichiers (`Stockmvt`, `Saisiedecons`,
  `Mvtex`, `gridvi`, `Facture`…).
- **`convBool(bln)`** [nature : calcul]. `"0"`/`""` → `"0"`, sinon `"1"` (drapeaux tinyint). 47 occ. /
  12 fichiers. Doublon local de signature différente : `Lettrage.convBool(bln As Boolean)`.
- **`convStr(bln)`** [code mort] [nature : calcul]. Comme `convBool` mais renvoie `"False"`/`"True"`
  (conversion implicite Boolean → String).

### 6. Dates

Toutes ces fonctions acceptent un `Date` (formaté par `Format$`) **ou** une chaîne découpée par
position. Le format de chaîne attendu diffère d'une fonction à l'autre :

| Fonction | Chaîne attendue | Sortie | Usage (occ. / fichiers) |
|---|---|---|---|
| `Cdate_Dbase` | `dd.mm.yyyy` | `yyyymmdd` | 256 / 69 |
| `Cdate2_Dbase` | `dd.mm.yyyy` | `yyyy-mm-dd` | 4 / 1 (`EcrM`) |
| `Cdate_Aff` | `mm/dd/yyyy` (`CStr` d'une date Gambas) | `dd.mm.yyyy` | 257 / 86 |
| `Cdate_Comp` | `yyyy-mm-dd`, `mm-dd-yyyy`, idem avec `.` ou `/`, entier | `yyyymmdd` | 61 / 18 |
| `Cdate_Comp2` | `yyyy-mm-dd` | `yyyymmdd` | **0 (code mort)** |
| `Cdate_Carte` | `yyyymmdd` | `dd.mm.yyyy` | 1 (`ArchivesTck`) |
| `Cdate_Com` | `mm/dd/yyyy` | `yyyy.mm.dd` | **0 (code mort)** |
| `Cdate_Ciel` | `mm/dd/yyyy` | `dd/mm/yyyy` | 1 (`ExportJdv`, `With`) |
| `Cdate_Cador` | `mm/dd/yyyy` | `yymmdd` (Date : `Format "YYmmdd"`) | 1 (`ExportJdv`, `With`) |
| `Cdate_Sage` | `mm/dd/yyyy` | `ddmmyy` | 2 / 1 (`ExportJdv`) |

[nature : calcul] pour toutes. Remarques :
- **`Cdate_Comp`** (CC 22) : les trois branches séparateur (`-`, `.`, `/`) sont identiques au
  séparateur près. La branche entière est défectueuse (UTILS-A04) : plages `999901..999912` et
  `99990101..99991231` (année 9999 uniquement), `Lsl` (décalage de bits) au lieu d'une division,
  et `ld = LDate(...).L` affecte une `String` à une variable `LDate`.
- **`Cdate_Sage`** : paramètre déclaré `String`, donc la branche `TypeOf(dte) = gb.Date` est morte.
- **`Cdate_Cador`/`Cdate_Sage`** : masques `"YYmmdd"`/`"ddmmYY"` en majuscules ; le comportement de
  `Format$` sur `YY` est à confirmer (UTILS-A05).
- **`Cdate_calc(Datej)`** [nature : mixte]. Saisie libre de date (`jj`, `jjmm`, `jjmmaa`,
  `jjmmaaaa`, séparateurs `.` `/` retirés) complétée par le mois et l'année courants → `Date` à 12 h
  (contournement UTC/GMT). Erreur → son (`Start.Son`, `Start.Musique`) + `Message.Error`. `Music.Load`
  à chaque appel. Entrée `Null` → `Date` nulle sans message. 78 occ. / 46 fichiers.
- **`Calc_mois(dte)`** [nature : calcul]. Premier jour du mois suivant, `01.mm.yyyy`. 68 occ. /
  21 fichiers (famille `Stat*`, `Histo*`).
- **`mois(n)`** [nature : calcul]. Nom français du mois 1-12, `""` sinon. 4 fichiers (`gridv`,
  `gridvi`, `gridvi2`, `Tregie`).
- **`lastday(dte)`** [nature : calcul]. Dernier jour du mois par essais `Date(y, m, d)` décroissants.
  5 fichiers.
- **`Calcech(dureech, jours, finmois, datef)`** (CC 77, **max du fichier**, 115 lignes) [portée :
  nécessaire] [nature : calcul]. Date d'échéance `jj.mm.aaaa` à partir de la date de facture `datef`
  (`jj.mm.aaaa`), d'une durée en jours (`"00"`, `"30"`, `"45"`, `"60"`…), d'un jour de paiement
  (`jours`, `"00"` = aucun) et du drapeau fin de mois. Cas particulier codé en dur pour 45 jours ;
  calcul par manipulation de chaînes et `Try Date(...)` en cascade ; années bissextiles traitées à
  la fin. Appelants : `Facture`, `ObjFac`, `ValidBR`, `Saisecrit`, `Echeances`, `Facturergbl`.
  Règle métier critique (échéances clients) : à couvrir exhaustivement avant tout rework.

### 7. Chaînes et codes

- **`Remplace(mtt)`** [nature : calcul]. `"` → `''`, `&` → `et`, suppression des `\n`. Héritage du SQL
  par concaténation. 72 occ. / 20 fichiers.
- **`ReplaceLb(mtt)`** [nature : calcul]. Identique à `Remplace` sans la suppression des `\n`.
  12 occ. / 9 fichiers.
- **`Replace(mtt)`** [nature : calcul]. Translittération des accents vers la page de code **CP850**
  (imprimantes ticket) : `ç` → `&H80`, `é` → `&H82`… 23 occ. / 4 fichiers (`Bordrx`, `Caisse`,
  `Moulinage`). Le nom masque la fonction native `Replace` à l'intérieur du module (les appels
  internes utilisent `Replace$`, sauf `totobs` et `arrondi` qui appellent `Replace(txt, ".", ",")` :
  à confirmer, Gambas résout probablement vers la fonction native à 3 arguments).
- **`Accent(mtt)`** [nature : calcul]. Retire quelques accents, supprime `\n`, échappe `'`.
  ⚠️ `ô` → `e` (et non `o`). 7 occ. / 3 fichiers (`SaiTableau`…).
- **`Nsoc(numero)`** [code mort]. Premier segment de `Scan(numero, "*:*")` ; renvoie un `String`
  dans une fonction déclarée `String[]`.
- **`chkEmail(sMail)`** [nature : mixte]. Contrôle sommaire (longueur ≥ 5, `@` non initial, un `.`
  vers la fin) ; `Message.Warning` sinon. Appelants : `FClient`, `FFournisseur`, `FClientcarte`, `Fsoc`.
  Partie extractible : le prédicat booléen.
- **`Next_Code(code, max_length = 15)`** [nature : mixte]. Code suivant : incrément du suffixe
  numérique en conservant la largeur (`A009` → `A010`), sinon incrément alphabétique base 26 avec
  retenue (`AZ` → `BA`, `Z` → `AA`) ; ajoute `1` si impossible ; tronque à `max_length` avec
  `Message.Warning`. Appelants : `Impart` (2), `Articles` (1). Bien couvrable par gb.test.
- **`Calcode(Cbarre)`** [nature : calcul]. Clé de contrôle EAN (somme pondérée 3/1). Le dernier
  chiffre est obtenu par `Right$(Str(Cle), 1)`. Appelants : `FClientcarte`, `FFournisseur`, `Articles`.

### 8. Thème, couleurs, focus et observateurs (GUI)

- **`Fcolr(sFormat)`** [nature : calcul]. Parse `"background: n; font: …; foreground: n"` en
  `String[3]`. Format strict `"clé: valeur"` (espace obligatoire, motif `Scan "*: *"`). 208 occ. /
  82 fichiers.
- **`Fcoulfond(sFormat)`** [code mort]. Variante `R,G,B` ; inopérante : `LCase` puis comparaison à
  `"R"`/`"G"`/`"B"` majuscules.
- **`Coulfd()`** [nature : calcul]. `Fcolr(/Coul/Others)`. 44 fichiers (éditions).
- **`SetEditColor(oObj, objLast)`** [nature : GUI]. Parcours récursif des enfants : le contrôle de
  même type et même `Tag` que `objLast` prend la couleur de focus, les autres la couleur de saisie
  (sauf fond gris `&HD4D0C8&`). Le test de conteneur passe par `Try hCont = hClass`.
  88 occ. / 78 fichiers.
- **`Observers(hCont As Form)`** [nature : GUI]. Appelée dans le constructeur ou `Form_Open` de
  **231 fichiers** (quasiment chaque écran). 1) Hors mode `--devel`, appelle `Recursive_Observers`
  pour enregistrer les `ReplayObserver` (log/replay). 2) Si `/Soc<XX>/Coul_fen`, applique les
  couleurs du thème (`/Coul/Fnets`, `Btns`, `Znss`, `Znaff`) à tous les contrôles selon leur type.
- **`Recursive_Observers(hCont, Source)`** [portée : réductible, usage interne] [nature : GUI].
  Descend l'arbre des contrôles et crée un `ReplayObserver` pour 20 types de contrôles, ajouté à
  `ROArray`. Deux longues cascades de `If … Is …` (CC 48). ⚠️ `ROArray` n'est jamais vidé : chaque
  ouverture d'écran ajoute des observateurs qui gardent une référence aux contrôles (croissance
  mémoire, UTILS-A08, à confirmer).
- **`ObsGotf(TBox)`** [nature : GUI]. Couleur de focus sur un contrôle éditable, sélectionne le texte,
  renvoie l'ancienne couleur. 132 occ. / 40 fichiers.
- **`ObsLstf(TBox, coul)`** [nature : GUI]. Restaure la couleur passée ou la couleur de saisie.
  161 occ. / 43 fichiers.
- **`ObsLstf2(CBox)`** [nature : GUI]. Idem pour une `ComboBox` (gris si lecture seule). 3 fichiers.
- **`Obstch(sel)`** [nature : GUI]. Construit un filtre de recherche au clavier à partir de `Key`.
  ⚠️ `Key.code <> Key.Return Or Key.code <> Key.Enter` est toujours vrai (UTILS-A03). 10 fichiers.
- **`Formattage(TBox)`** / **`Coulfonds(TBox)`** [nature : GUI]. Format `0.00` ; fond rouge si ≤ 0,
  vert sinon. Appelant unique : `Suivi`.
- **`Fill_Civilite(obj)`** [nature : mixte]. `SELECT * FROM Fiches_Identite` (nom en dur, sans
  `Cbase.Table("TabIdentite")`) puis `Object.Call(obj, "Add", [libelle])` (appel dynamique).
  Appelants : `FClient`, `FFournisseur`, `FClientcarte`.
- **`fam(champs, TreeView1)`** [nature : mixte]. Construit `" AND <champs> IN('a','b')"` à partir des
  nœuds sélectionnés (`db.Subst`). ⚠️ Si aucun nœud n'est sélectionné, `Left(rq, -1)` retire la
  parenthèse ouvrante et produit `" AND champ IN)"`, donc un SQL invalide (UTILS-A02). Appelants :
  `Histocliart` (15), `Stockmvt` (10).

### 9. Métier et SQL

- **`Find_cbarre(Codabarre)`** [nature : calcul + SQL]. `SELECT * FROM Cbase.Table("TabCdBarre")
  WHERE codeb = &1` → `codep`, sinon `SELECT art_code FROM TabArt WHERE art_code = &1`, sinon `""`.
  Entrée `Null` → aucune valeur renvoyée (`""`). 34 occ. / 20 fichiers.
- **`Commande(codart, decm, uv, org)`** [nature : calcul + SQL]. Somme `qte × uv` des lignes de
  commande fournisseur (`Fiches_Ligcom`, **nom en dur**, `WHERE code = &1`), formatée par `CDec`.
  La branche `org <> "Four"` interroge `Fiches_Ligbl` avec des colonnes `code`/`qte` qui
  **n'existent pas** (`code_ligbl`, `qte_ligbl`) ; elle n'est appelée par personne (les deux appelants,
  `Facture:5260` et `Articles:385`, passent `"Four"`).
- **`Option()`** [nature : calcul]. Option métier de la société : `N` (aucune), `B` (bois), `P`
  (`/pp`), `T` (les deux), lue dans `Start.LocalSettings["/Soc<XX>/bois"|"/pp"]`. 23 occ. / 21 fichiers,
  dont `DB_Connection`.
- **`orientation(numrec, choix, nom)`** [nature : calcul + SQL]. Option bois : détermine si une
  facture (`F`) ou un BL (`B`, `FM` = tous les BL du client) relève des consignes (`Fiches_ligcons`)
  ou de la régie (`Fiches_ligregie`, `Fiches_Ligbl` × `Fiches_Art.art_dra`). Tables en dur, hors
  `Cbase` et hors `db_control.csv` (tables de l'option bois, à confirmer). ⚠️ La branche `FM`
  interroge une table `Bl` (sans préfixe `Fiches_`) ; `resregie` reste `Null` si `choix` n'est ni `F`
  ni `B`. Appelants : `Facturefm`, `Archives`.

### 10. Formats de page

- **`PageFormatSupported()`** [nature : calcul]. `["A4 Portrait", "A4 Paysage", "A5 Portrait",
  "A5 Paysage"]`. Appelant : `Etiquettes`.
- **`PageFormatGetX(Page)`** / **`PageFormatGetY(Page)`** [code mort] [nature : calcul]. Dimensions en
  dixièmes de mm (défaut A4 portrait).

## État global utilisé

- **Déclaré ici et partagé** : `db` (handle unique), `de`, `rs1`…`rs4` (contrat implicite entre
  `BaseN` et les handlers `_Data` des écrans), `MysqlServeur`, `RemotePort`, `SshPort`, `SshHost`,
  `SshUser` (écrits par `glb` et `LauruxConf`, lus par `monteTunnel`), `SshPassw`, `SshPassphrase`
  (écrits mais **jamais lus**), `mysqlPort` (écrit par `glb`, jamais lu), `TunnelPid` (interne),
  `ROArray` (interne).
- **Lu** : `Start.LocalSettings` (`/dbase/*`, `/Coul/*`, `/Soc<XX>/Coul_fen|bois|pp`), `Start.Societe`,
  `Start.son`, `Start.Son`, `Start.Musique`, `Start.Arg_Devel`, `Start.Arg_Debug`, `Start.MainWindow`,
  `Start.LLogColl`.
- **Écrit** : `Start.Success`, `Start.Exit` (`Exit`), `Start.LLogColl` (`Log`).
- Classes utilisées : `DB_Connection`, `DB_Desktop`, `ReplayObserver`, `LLog`, `LDate`, `hexdblKey`,
  `Cbase`, `Fmenu` (test `Is Fmenu` dans `Recursive_Observers`).

## Propositions d'amélioration

### Réécriture / refactorisation

- **`Base`…`Base4`** : un helper privé `RemplitGrille(tbv, qry) As Result` appelé par les quatre
  fonctions publiques ; signatures et variables `rsN` conservées.
- **Couleurs du thème** : un helper privé `CouleurTheme(cle) As Integer` (= `Val(Fcolr(LocalSettings[cle])[0])`)
  remplace les 9 répétitions dans `SetEditColor`, `Observers`, `ObsGotf`, `ObsLstf`, `ObsLstf2`.
  Les réglages restent relus à chaque appel (la fenêtre Préférences peut les modifier).
- **`Recursive_Observers` / `Observers`** : remplacer les cascades `If hCtrl Is X` par des boucles
  sur des tableaux de noms de classes (`Object.Is(hCtrl, sClasse)`) ; CC 48 → < 10, ordre de parcours
  identique.
- **`Cdate_Comp`** : une seule branche paramétrée par le séparateur détecté.
- **`Calcech`** : découper en sous-fonctions privées (durée en mois, cas 45 jours, fin de mois,
  février/bissextile) **après** une campagne de tests de caractérisation exhaustive (matrice
  durées × jours × fin de mois × dates de fin de mois/février/décembre).
- **`Remplace`** = `ReplaceLb` + suppression des `\n` : `Remplace` appelle `ReplaceLb`.
- **`Replace`**, **`Accent`**, **`mois`** : tables de correspondance au lieu des cascades de `If`/`Case`.
- **`Commande`** : les deux branches ne diffèrent que par le nom de table ; une seule boucle.
- **`SetEditColor`** : `If hClass Is Container` au lieu de `Try hCont = hClass` (même effet).
- **Shell MySQL** : un helper privé `MysqlCmd(args) As String` commun à `Fill_DataBase`,
  `Clear_DataBase`, `Create_DataBase` (et à terme `Mmysql.Process_List`), avec le mot de passe passé
  par la variable d'environnement `MYSQL_PWD` (`Exec … With env`) plutôt que sur la ligne de commande.

### Commonalisation avec d'autres fichiers

- **`cpoint`** : copies locales dans [`Cpostaux`](../../Gestion/Tables/Cpostaux.class/architecture.md),
  [`Marques`](../../Gestion/Tables/Marques.class/architecture.md),
  [`Lettrage`](../../Compta/Lettrages/Lettrage.class/architecture.md),
  [`FTvac`](../../Compta/Tables/FTvac.class/architecture.md),
  [`FComptes`](../../Compta/Tables/FComptes.class/architecture.md),
  [`ArchivesTck`](../../Archivages/ArchivesTck.class/architecture.md). Elles diffèrent sur `Null`
  (`""` au lieu de `"0"`) et l'espace initial : à traiter dans le rework de chaque fichier, après
  vérification que les entrées ne sont jamais nulles.
- **`convBool`** : [`Lettrage.convBool(Boolean)`](../../Compta/Lettrages/Lettrage.class/architecture.md).
- **Arrondis** : `Utils.arrondi`, [`LPrix.Arrondi_Calc`](../LPrix.class/architecture.md),
  [`Caisse.arrondi`](../../Caisse/Caisse.class/architecture.md),
  [`Moulinage.arrondi`](../../Caisse/Moulinage.class/architecture.md),
  [`Facture.arrondi`](../../Gestion/Facturation/Facture.class/architecture.md) (et `Articles`, `Movr`,
  `Materiel`, `FTvav`) : la logique « arrondi au 0,05 par le dernier chiffre » est copiée au moins
  quatre fois. Candidat phase 3 : une fonction unique (dans `LPrix` ou `Utils`).
- **Dates** : les `Cdate_*` recouvrent [`LDate`](../LDate.class/architecture.md) (`.D`, `.DT`, `.L`).
  À terme, les appelants devraient passer par `LDate` ; dans ce plan, seule une factorisation interne
  est proposée.
- **SSH** : `glb` et [`LauruxConf`](../../Communs/LauruxConf.class/architecture.md) (l. 245-251)
  dupliquent l'initialisation des variables SSH → `Utils.ChargeParamSsh()` commun.
- **Shell MySQL** : [`Mmysql.Process_List`](../Mmysql.module/architecture.md), `Fill_DataBase`,
  `Clear_DataBase`, `Create_DataBase`.
- **`FloatParse`** et `cpoint`/`totobs` : trois façons de lire un nombre saisi ; `FloatParse` (pur,
  insensible à la locale) devrait devenir la référence. Voir `Utils.VariantToFloat` proposé par LPrix.

### Réduction de portée

Vérifié par grep, y compris dans les blocs `With Utils` :
- **Code mort** (aucun appel) : `do_pcre_extract`, `Form_Close`, `Cdate_Comp2`, `Cdate_Com`,
  `convStr`, `Nsoc`, `Fcoulfond`, `PageFormatGetX`, `PageFormatGetY` ; variables `mysqlPort`,
  `SshPassw`, `SshPassphrase` (écrites, jamais lues ; `SshPassw`/`SshPassphrase` sont aussi écrites
  par `LauruxConf`).
- **Public → Private** : `Recursive_Observers`, `Play`, `TunnelPid`, `ROArray`.
- **Faux positifs de `deps.py`** (à garder Public) : `CSlash`, `Cdate_Ciel`, `Cdate_Cador`, `rs3`.

### Séparation traitement / GUI

- `Cdate_calc` : fonction pure `Cdate_Parse(Datej, ByRef ok)` + son et `Message.Error` dans
  `Cdate_calc`.
- `FloatParse` : le `Message.Error` sort dans un wrapper ; le cœur renvoie un indicateur d'erreur.
- `Next_Code` : calcul pur + `Message.Warning` de troncature dans l'enveloppe.
- `chkEmail` : prédicat `EmailValide(s) As Boolean` + `Message.Warning` dans `chkEmail`.
- `fam`, `Fill_Civilite` : séparer la lecture SQL (liste de libellés / de clés) du remplissage du
  contrôle.
- `BaseN` : la requête est déjà isolée ; seule la ligne `Rows.Count` est GUI.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- `Ciel()` crée `Ciel_Lrx`, `Ciel_Lrx_Jo` et la colonne `Fiches_Parametres.imp_ciel` hors migration :
  ces objets devraient être créés par une fonction `MajXYX()` de `LauruxMaj` et ajoutés à
  `db_control.csv`.
- Les tables de l'option bois (`Fiches_ligcons`, `Fiches_ligregie`, `Bl`) devraient être déclarées dans
  `Cbase` et dans `db_control.csv`.
- Dates stockées en `datetime` mais manipulées en chaînes `dd.mm.yyyy` : un format unique (`DATE` ISO)
  rendrait inutiles la plupart des `Cdate_*`.
- Les drapeaux booléens `tinyint` lus en `String` justifient `convBool` ; un type `BOOLEAN` lu en
  `Boolean` le rendrait inutile.
