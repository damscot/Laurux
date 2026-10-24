# Start — Architecture

> Source : `.src/Start.module`

## Vue d'ensemble

`Start` est le **module de démarrage** du projet (`Startup=Start` dans `.project`). Il porte trois
responsabilités distinctes :

1. **Cycle de vie de l'application** : `Main` (boucle de redémarrage), `Lancement` (création de la
   fenêtre principale `Fmenu` ou `Cmenu` puis boucle d'attente), fichier verrou
   `~/Laurux.lock` (`Lock`/`UnLock`), gestion de `SIGINT` (`Application_Signal`).
2. **Ligne de commande** (`Parse_Args`, composant `gb.args`) et fonctions associées : rejeu d'un
   log (`-r`, `ReplayTimer_Timer`), restauration de base (`--restore`, `Restore_Args`), harnais de
   tests internes (`-t`, `Start_Test`).
3. **État global de l'application** : 51 variables `Public` d'un module, donc des singletons
   globaux (`Start.LocalSettings`, `Start.Societe`, `Start.son`, `Start.Musique`, `Start.R/G/B`…),
   lues dans environ 300 fichiers. C'est la principale source de couplage du projet.

Il n'émet **aucun SQL** directement. Les seuls accès à la base passent par `Utils.ControlTunnel`
(réplication) et `Utils.Clear/Create/Fill_DataBase` (restauration, via le client `mysql`).

Nature globale : **mixte**. Le démarrage est très lié à la GUI (`Message.Warning`, `Application.Font`,
création de fenêtres) ; le traitement des arguments, le verrou et les couleurs sont extractibles.

### Séquence de démarrage

```
Main
 ├─ lit branch.txt / sha1.txt (répertoire courant)            → version_branch, version_sha1
 └─ While Not Start.Exit                                       (boucle de redémarrage)
     ├─ Success = True, Restart = False
     ├─ Parse_Args()                                           → Arg_*
     ├─ niveaux de log (-d "console,fichier"), purge de ~/tmp/Debug/*.log
     ├─ LocalSettings = New Settings(Arg_Config_File)
     ├─ Societe : -s/--societe (écrit /Soc et /dbase/Name) sinon /Soc sinon "01"
     ├─ contrôle de réplication (Con-ssh + Replique + Breplique) → Utils.ControlTunnel
     ├─ son, Musique, chaînes de couleur /Coul/*, valeurs /Coul par défaut si absentes
     ├─ police de l'application (/Soc<XX>/Font), Coul() → R,G,B / R2,G2,B2
     ├─ ~/Laurux.lock : processus vivant ? → Message.Warning « Ne pas ouvrir / Ouvrir »
     ├─ Lancement()
     │    ├─ Lock()
     │    ├─ New Cmenu (-p) ou New Fmenu ; Show ; MainWindow
     │    ├─ FTips (hors caisse, /Tips)
     │    ├─ -r : lecture du log (lignes « ;GUI; »), Timer ReplayTimer (2 s)
     │    ├─ -t : Start_Test() → Utils.Exit(success)
     │    ├─ Signal[SIGINT].Catch
     │    └─ While Not Start.Exit : Wait Next (Wait 60 avec --devel)
     └─ Restart ? → nouvelle itération ; Exit ? → Quit (Not Success) ; sinon Message.Error + Continue
```

La sortie normale passe par `Utils.Exit(succès)` (`Utils.module:30`) : `Start.Success` et
`Start.Exit` sont positionnés, puis le processus s'envoie `SIGINT` ; `Application_Signal` appelle
`Quit (Not Start.Success)` sauf en cas de redémarrage (`Start.Restart`, posé par
`LauruxConf.Form_Close`, `LauruxConf.class:462`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Societe` | var | Public | oui | String | 3 |
| `LocalSettings` | var | Public | oui | Settings | 4 |
| `GlobalSettings` | var | Public | oui | Settings | 5 |
| `version_sha1` | var | Public | oui | String | 6 |
| `version_branch` | var | Public | oui | String | 7 |
| `son` | var | Public | oui | Integer | 8 |
| `Musique` | var | Public | oui | String | 9 |
| `Caisse` | var | Public | oui | Boolean | 10 |
| `Proform` | var | Public | oui | String | 11 |
| `Commande` | var | Public | oui | String | 12 |
| `Devis` | var | Public | oui | String | 13 |
| `Devis2` | var | Public | oui | String | 14 |
| `Bon` | var | Public | oui | String | 15 |
| `Facture` | var | Public | oui | String | 16 |
| `Epuises` | var | Public | oui | String | 17 |
| `Stockes` | var | Public | oui | String | 18 |
| `Nstockes` | var | Public | oui | String | 19 |
| `Suspendus` | var | Public | oui | String | 20 |
| `Lig2` | var | Private | oui | String[] | 21 |
| `Fontes` | var | Private | oui | String | 22 |
| `hpb` | var | Private | oui | ProgressBar | 23 |
| `R` | var | Public | oui | Integer | 24 |
| `G` | var | Public | oui | Integer | 25 |
| `B` | var | Public | oui | Integer | 26 |
| `R2` | var | Public | oui | Integer | 27 |
| `G2` | var | Public | oui | Integer | 28 |
| `B2` | var | Public | oui | Integer | 29 |
| `Motdepasse` | var | Public | oui | String | 30 |
| `hlb` | var | Private | oui | Label | 31 |
| `NoTips` | var | Public | oui | Boolean | 32 |
| `StartDate` | var | Public | oui | Date | 33 |
| `MainWindow` | var | Public | oui | Window | 34 |
| `$cai` | var | Public | oui | String | 35 |
| `$tcai` | var | Public | oui | String | 36 |
| `Arg_Config_File` | var | Public | oui | String | 39 |
| `Arg_Log` | var | Public | oui | Boolean | 40 |
| `Arg_Replay` | var | Public | oui | Boolean | 41 |
| `Arg_Pos` | var | Public | oui | Boolean | 42 |
| `Arg_Test` | var | Public | oui | String | 43 |
| `Arg_Start_Societe` | var | Public | oui | String | 44 |
| `Arg_Restore_DB` | var | Public | oui | String | 45 |
| `Arg_LogFile` | var | Public | oui | String | 46 |
| `Arg_Debug` | var | Public | oui | String | 47 |
| `Arg_Devel` | var | Public | oui | Boolean | 48 |
| `hReplayTimer` | var | Public | oui | Timer | 52 |
| `Evens` | var | Public | oui | String[] | 53 |
| `Ev` | var | Public | oui | Date | 54 |
| `Evc` | var | Public | oui | Integer | 55 |
| `Evl` | var | Public | oui | Integer | 56 |
| `Success` | var | Public | oui | Boolean | 58 |
| `Exit` | var | Public | oui | Boolean | 59 |
| `Restart` | var | Public | oui | Boolean | 60 |
| `LLogColl` | var | Public | oui | Collection | 62 |
| `ConsoleLogLevel` | var | Public | oui | Integer | 63 |
| `FileLogLevel` | var | Public | oui | Integer | 64 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Main` | 67-207 | Public | 34 | 122 | 1 |  |
| `Coul` | 209-242 | Public | 15 | 31 | 0 | portée réductible ? |
| `UnLock` | 244-261 | Public | 4 | 13 | 7 |  |
| `Lock` | 263-270 | Public | 2 | 5 | 0 | portée réductible ? |
| `Lancement` | 273-377 | Public | 35 | 86 | 0 | portée réductible ? |
| `Application_Signal` | 379-385 | Public | 4 | 5 | 0 | handler GUI |
| `ReplayTimer_Timer` | 387-406 | Public | 2 | 12 | 0 | handler GUI |
| `Parse_Args` | 409-455 | Public | 7 | 36 | 0 | portée réductible ? |
| `Restore_Args` | 457-471 | Public | 3 | 13 | 1 |  |
| `Start_Test` | 473-516 | Public | 9 | 33 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Description des fonctions

### Cycle de vie

- **`Main()`** [portée : nécessaire, point d'entrée + appel de `Fsoc.Soclist_Click`, `Fsoc.class:625`]
  [nature : mixte] (CC 34). Voir la séquence ci-dessus. Effets de bord :
  - **fichiers** : supprime `~/tmp/Debug/*.log` à chaque démarrage, crée `~/tmp` et `~/tmp/Debug` ;
  - **configuration** : `-s` écrit `/Soc` et `/dbase/Name` (`<Prefixe>Laurux<XX>`) ; en l'absence
    de `/Coul/Fnets`, écrit 23 clés `/Coul/*` par défaut puis `Save`/`Reload` ;
  - **état global** : `Societe`, `son`, `Proform`…`Suspendus`, `R/G/B/R2/G2/B2`, `StartDate`,
    `LLogColl`, `ConsoleLogLevel`, `FileLogLevel`, `Application.Font`.
  Points notables :
  - ⚠️ ligne 132 : `If Error Or If IsNull(…/Coul/Fnets)` ; `Error` reflète le **dernier `Try`**
    exécuté, c'est-à-dire `Try Son = …/son` (l. 120). Une valeur `/son` invalide réécrit donc toutes
    les couleurs par défaut (à confirmer, effet de bord peu probable).
  - Les clés `/Coul/Coulfonds` et `/Coul/Others` sont écrites deux fois (l. 138-139 puis 142-143,
    la seconde valeur, au format `R;G;B;`, l'emporte). Ces valeurs par défaut existent aussi, avec
    d'autres séparateurs, dans `Fmenu.preferences`, `SetColors.Button2_Click` et `LauruxConf`
    (voir Commonalisation).
  - Contrôle de réplication (l. 112-118) : en échec, `Message.Error` puis `Return` ; `Main` se termine
    sans fenêtre, donc l'application s'arrête. Même test dupliqué dans `Fmenu` (14 menus) et
    `Facture` (FMENU-004/005).
  - Verrou : `Shell "ps -p " & Pids` (l. 173) avec le contenu brut du fichier verrou, qui peut contenir
    plusieurs PID séparés par des espaces (`ps -p 12 34`, comportement de `ps` à confirmer).
  - Appel **récursif** depuis `Fsoc.Soclist_Click` (`Fsoc.class:625`) : `Start.Main()` est appelé
    pendant le traitement d'un événement, à l'intérieur de la boucle `Wait Next` de `Lancement`. La
    pile d'appels s'empile à chaque changement de société par cette voie (à rapprocher du mécanisme
    `Start.Restart` utilisé par `LauruxConf`, qui est propre).
  - Variables locales inutilisées : `$cle`, `$cle2`, `txt`, `sha`, `bcle`.
- **`Lancement()`** [portée : réductible] [nature : mixte] (CC 35, max du fichier).
  - Valeurs par défaut `&HF9F9BD&` des chaînes de couleur nulles : le bloc `Proform`→`Facture`
    est écrit **deux fois** (l. 284-288 et 289-293) ; `Commande = "&HF9F9BD&" ""` utilise la
    concaténation implicite de deux littéraux.
  - Caisse (`-p`) : `New Cmenu`, police `/Soc<XX>/caisse/Font`, `$tcai` = premier code de
    `/caisse/Ncai` si `/caisse/choixtouches`, sinon `0` (Integer affecté à une String → `"0"`).
  - `Caisse = True` si `/Soc<XX>/Caisse` (jamais remis à `False` lors d'un redémarrage).
  - Création de la fenêtre par appel dynamique : `Object.Call(Menu, "Show")`,
    `Object.GetProperty(Menu, "Window")` (`Menu As Object`).
  - Rejeu (`-r`) : lit `Arg_LogFile` (défaut `~/tmp/Laurux.log`), garde les lignes `*;GUI;*` dans
    `Evens`, arme `hReplayTimer` (2 s). Le fichier n'est jamais fermé. Fichier absent :
    `Print` + `Utils.Exit(False)`.
  - ⚠️ `Dim ev As Date` (l. 277) masque la globale `Ev` : `Ev = Now` (l. 343) affecte la locale ;
    la globale `Start.Ev` reste à sa valeur initiale (date nulle) pour le premier événement rejoué.
    `ReplayObserver.Replay_Event` calcule alors un délai invalide et retombe sur 1000 ms
    (`ReplayObserver.class:331-334`) : effet limité au délai du premier événement.
  - ⚠️ `Evl = Evc = 0` (l. 344) n'est **pas** une double affectation : Gambas affecte à `Evl` le
    booléen `(Evc = 0)`, soit `-1` au premier lancement. Voir `ReplayTimer_Timer`.
  - `-t` : `Start_Test()` est appelé **avant** `Signal[Signal.SIGINT].Catch` (l. 363-367).
  - Boucle d'attente : `Wait Next` (ou `Wait 60` avec `--devel`) tant que `Start.Exit` est faux.
- **`Application_Signal(Sig)`** [portée : nécessaire, événement `Application` levé par
  l'interpréteur ; `deps.py` le classe à tort réductible] [nature : calcul]. `Quit (Not Success)` sur
  `SIGINT` si `Exit` et pas `Restart`. En cas de redémarrage, le signal est ignoré et la boucle de
  `Lancement` se termine parce que `Exit` est vrai.
- **`Lock()`** [portée : réductible] [nature : calcul]. Ajoute `Application.Id` au fichier
  `~/Laurux.lock` (séparateur espace).
- **`UnLock()`** [portée : nécessaire, 11 appels dans 7 fichiers : `Cmenu`, `FRestore`, `Fmenu`,
  `Fsoc`, `LauruxConf`, `ClotureF`, `FCloture`] [nature : calcul]. Retire `Application.Id` du fichier
  verrou par trois `Replace$` successifs (`" " & id`, `id & " "`, `id`), puis supprime le fichier s'il
  est vide. ⚠️ Remplacement de sous-chaîne : avec le PID 123, un verrou `"5123 7"` devient `"57"`
  (anomalie START-A04, le commentaire du code reconnaît le risque).
- **`Coul()`** [portée : réductible, aucun appel externe] [nature : calcul]. Découpe `/Coul/Others`
  sur `;` → `R`, `G`, `B` et `/Coul/Coulfonds` → `R2`, `G2`, `B2`. ⚠️ En cas d'erreur sur
  `/Coul/Others`, les valeurs de repli sont écrites dans `R2/G2/B2` au lieu de `R/G/B` (l. 220-224) ;
  seul le dernier `Try` (`B` ou `B2`) est testé. Les chaînes à virgules écrites par `Fmenu.preferences`
  provoquent ce repli (FMENU-A03).

### Ligne de commande

- **`Parse_Args()`** [portée : réductible] [nature : calcul]. `Args.Begin`/`Args.End` (`gb.args`).
  Le 4ᵉ argument de `Args.Get` est le **nom d'argument affiché dans l'aide**, pas une valeur par
  défaut : sans l'option, la variable vaut `Null`.

  | Option | Variable | Effet |
  |---|---|---|
  | `-c`, `--config <fichier>` | `Arg_Config_File` | fichier de configuration ; défaut `~/.config/gambas3/Laurux.conf` ; fichier absent → `Print` + `Quit` |
  | `-p`, `--pos` | `Arg_Pos` | démarre la caisse (`Cmenu`) |
  | `-l`, `--log` | `Arg_Log` | active la journalisation (`DB_Connection.Start`) |
  | `-r`, `--replay` | `Arg_Replay` | rejoue les lignes `;GUI;` du log |
  | `--devel` | `Arg_Devel` | `Wait 60` au lieu de `Wait Next` ; pas d'observateurs récursifs (`Utils.module:1022`) |
  | `--logfile <fichier>` | `Arg_LogFile` | fichier de log ; chemin relatif préfixé par `$PWD` |
  | `-d`, `--debug <c,f>` | `Arg_Debug` | niveaux console et fichier (`LLog.console` = 0, `LLog.file` = 1) ; non vide → tous les `LLog` actifs (`Utils.module:1675`) |
  | `--version-full` | — | affiche nom, version, branche, sha1 puis `Quit` |
  | `-s`, `--societe <XX>` | `Arg_Start_Societe` | société de démarrage, persistée dans `/Soc` et `/dbase/Name` |
  | `--restore <fichier.sql>` | `Arg_Restore_DB` | restauration au démarrage (voir `Restore_Args`) |
  | `-t`, `--test <liste>` | `Arg_Test` | tests internes (voir `Start_Test`) |

  Les arguments restants sont affichés (`Print "Arg: …"`). `Parse_Args` est rappelé à chaque
  itération de la boucle de redémarrage (second `Args.Begin` : comportement à confirmer).
- **`Restore_Args()`** [portée : nécessaire, `Fmenu.Form_Open`, `Fmenu.class:172`] [nature : calcul].
  Si `--restore` est fourni : fichier absent → `Print` + `Quit` ; sinon `Utils.Clear_DataBase`,
  `Create_DataBase`, `Fill_DataBase` sur `"Laurux" & Societe`. ⚠️ Ignore `/dbase/Prefixe`, que
  `Main` utilise pour `/dbase/Name` (à confirmer : base restaurée ≠ base ouverte si un préfixe est
  défini). Réservé au mode debug (message affiché).
- **`ReplayTimer_Timer()`** [portée : nécessaire, handler du `Timer` « ReplayTimer »] [nature : mixte].
  Crée un nouveau `Timer` à chaque tick (pour supporter les `ShowModal` qui ne rendent pas la main),
  rejoue `Evens[Evc - 1]` par `ReplayObserver.Replay_Event` puis recopie le délai calculé dans
  `hReplayTimer.Delay`. Arrête le timer quand `Evc > Evl`.
  **Analyse de la borne (signalée par le lot Utils)** : avec `Evc <= Evl` et `Inc Evc`, l'indice
  `Evc - 1` atteindrait `Evl` si `Evl` valait le nombre d'événements. Or `Evl` part de `-1`
  (`Evl = Evc = 0`, voir `Lancement`) : `Evl` vaut N-1 et les indices lus vont de 0 à N-1.
  **Il n'y a donc pas de dépassement au premier rejeu**, mais par compensation de deux défauts.
  ⚠️ `Evc` n'est jamais remis à zéro : lors d'un second `Lancement` (redémarrage), `Evl` vaut
  `(Evc = 0)` = `0`, donc N, et les indices repartent de l'ancien `Evc` (événements sautés ou
  dépassement d'indice). Anomalie START-A01.
- **`Start_Test()`** [portée : réductible] [nature : mixte]. Harnais `-t` (à remplacer par gb.test
  en phase 2, `./Laurux -T`) :
  1. affiche un bandeau ; `List_Test = Split(Arg_Test, ",")` ;
  2. force le chargement de `LPrix` et `LScript` (`Class.Load`) ;
  3. parcourt `Classes` (classes **déjà chargées**) ; pour chaque classe qui expose `Internal_Test`,
     `Try obj = cla.AutoCreate()` puis `Object.Call(obj, "Internal_Test", [List_Test])` ;
     `success = success And résultat` (`And` non court-circuité : toutes les classes sont jouées) ;
  4. bandeau `*****` ou `!!!!!` puis `Utils.Exit(success)`.

  Comportement de chaque `Internal_Test` (`LPrix.class:685`, `LScript.class:90`) selon `-t` :
  - `-t list` : la classe affiche `Internal Test for Class <Nom>: <Nom>` et renvoie `True` ;
  - `-t all` : la classe joue ses tests ; aujourd'hui **aucune assertion** (`err` jamais incrémenté),
    seulement des `Print` ; `LScript` lance des commandes shell réelles (`/bin/bash`, `/bin/false`,
    script `scanbatch` de la configuration) ;
  - `-t <Classe>[,<Classe>…]` : la classe nommée joue ses tests, les autres affichent `=> SKIPPED`.
    Une classe inconnue n'est pas signalée.
  Points importants pour la phase 2 :
  - seules `LPrix` et `LScript` sont testées : les classes non chargées sont ignorées ;
  - les tests ne tournent qu'**après** l'ouverture complète de `Fmenu` (connexion à la base,
    `LauruxMaj.Verif_Version`, donc migration éventuelle) : `-t` exige une base et un affichage ;
  - `Utils.Exit` envoie `SIGINT` **avant** que `Lancement` ait installé `Signal[SIGINT].Catch`.
    Si `gb.signal` n'intercepte pas encore le signal, le processus est tué par `SIGINT` (code 130
    côté shell) au lieu de `Quit (Not success)` (code 0/1) : **à confirmer** par exécution
    (START-T04, START-A02). `TESTING.md` annonce un code 0/1.

## État global

### Variables `Public` : lecteurs et écrivains (grep, commit `6b6b9dfc`)

« Écrivains externes » : affectations `Start.X = …` hors de `Start.module`. Les nombres de fichiers
comptent les fichiers `.class`/`.module` qui citent `Start.X`.

| Variable | Écrit dans Start | Écrivains externes | Lecteurs externes | Proposition |
|---|---|---|---|---|
| `Societe` | `Main` | `Fsoc` (l. 566, 616) | 159 fichiers (1237 occurrences) | garder (état société) |
| `LocalSettings` | `Main` | aucun (le contenu est modifié partout) | 187 fichiers (≈2000 occurrences) | garder |
| `GlobalSettings` | — | `Fmenu` (l. 193, 1174), `Prefs` (l. 1448) | `Fmenu` | garder ; jamais initialisé par `Start` |
| `version_sha1`, `version_branch` | `Main` | — | `FAbout:13`, `Cmenu:28` | garder (lecture seule) |
| `son` | `Main` | — | 193 fichiers, dont 155 `Private son … = Start.son` | garder ; candidat propriété en lecture seule |
| `Musique` | constante d'initialisation | — | 176 fichiers (`Music.Load(Start.Musique)`) | candidat `Const` (jamais modifiée) |
| `Caisse` | `Lancement` | — | `TriHistos` (l. 62, 307) | garder |
| `Proform`, `Commande`, `Devis`, `Devis2`, `Bon`, `Facture` | `Main`, `Lancement` | — | `Facture.class:193-198` (initialiseurs) | garder (ou lecture directe de `/Coul/*` dans `Facture`) |
| `Epuises`, `Stockes` | `Main`, `Lancement` | — | `Materiel.class:63-64` | idem |
| `Nstockes`, `Suspendus` | `Main`, `Lancement` | — | **aucun** | code mort |
| `R`, `G`, `B` | `Coul` | — | 31 fichiers (états `Reports/C*`, `ObjFac`, `Extrait`…) | garder |
| `R2`, `G2`, `B2` | `Coul` | — | `Cdocuments`, `Cdocuments3`, `ObjFac:268` | garder |
| `Motdepasse` | — | `MDP` (l. 39, 43), `Fmenu` (9 menus), `Fsoc:404` | `Fmenu`, `Fsoc` | à remplacer par une valeur de retour de `MDP` (hors périmètre) |
| `NoTips` | — | `Fmenu` (l. 150, 284) | `Lancement` | garder |
| `StartDate` | `Main` | — | **aucun** | code mort |
| `MainWindow` | `Lancement` | — | `LauruxConf:464`, `Fsoc:576`, `Utils:1643-1655` | garder |
| `$cai` | `Svendeur:45` | `Caisse:921`, `Caisse:977` | — | utilisée (corrigé après le lot Caisse : accès `Start.$Cai`, non vu au départ par deps.py) |
| `$tcai` | `Lancement` | `Ouverture` (l. 194-212), `Fmenu:2544-2546` | `Cmenu:176`, `Attrib:171` | garder (nom `$` trompeur pour un membre Public) |
| `Arg_Config_File`, `Arg_Test`, `Arg_Start_Societe`, `Arg_Restore_DB` | `Parse_Args` | — | **aucun** | réductible `Private` |
| `Arg_Log`, `Arg_Replay`, `Arg_LogFile` | `Parse_Args`, `Lancement` | — | `DB_Connection` (l. 43-65) | garder |
| `Arg_Pos` | `Parse_Args` | — | `Cmenu` (l. 206-214) | garder |
| `Arg_Debug`, `Arg_Devel` | `Parse_Args` | — | `Utils.module` (l. 1675, 1022) | garder |
| `hReplayTimer`, `Evens`, `Ev`, `Evc`, `Evl` | `Lancement`, `ReplayTimer_Timer` | — | **aucun** | réductible `Private` |
| `Success`, `Exit` | `Main` | `Utils.Exit` (l. 32-33) | `Utils.module` | garder (protocole de sortie) |
| `Restart` | `Main` | `LauruxConf:462` | — | garder |
| `LLogColl` | `Main` | — (collection modifiée par `Utils.Log`) | `Utils.module:1679-1684`, `DB_Log` (l. 233-284) | garder ; à déplacer vers `Utils`/`LLog` (phase 3) |
| `ConsoleLogLevel`, `FileLogLevel` | `Main` | — | `LLog:37-38`, `DB_Connection:43` | garder |

Variables `Private` inutilisées : `hpb` (ProgressBar), `hlb` (Label). `Lig2` et `Fontes` ne servent
que localement (`Coul`, `Main`, `Lancement`).

Bilan : sur 51 globales, **4 sont mortes** (`Nstockes`, `Suspendus`, `StartDate`, plus les
`Private` `hpb`/`hlb` ; `$cai` retirée après le lot Caisse) et **9 peuvent devenir `Private`** (4 `Arg_*`
+ 5 variables de rejeu), soit une réduction de 13 globales sans toucher aux appelants.

### Dépendances d'état entrantes

- `Utils.ControlTunnel`, `Utils.Clear/Create/Fill_DataBase`, `Utils.Exit` ;
- `ReplayObserver.Replay_Event` ; `LLog.console`/`LLog.file` ;
- fichiers : `branch.txt`, `sha1.txt` (répertoire courant), `~/Laurux.lock`, `~/tmp/Debug/*.log`,
  `son/warning.ogg`, le fichier de configuration.

## Propositions d'amélioration

### Réécriture / refactorisation

- `Main` : extraire `InitLogs()`, `InitSociete()`, `InitCouleurs()`, `ControleVerrou() As Boolean`
  (CC 34 → environ 10 par fonction) sans changer l'ordre des effets.
- `Lancement` : supprimer le bloc dupliqué des valeurs par défaut ; extraire `ChargeReplay()` et
  `InitCaisse()` (CC 35).
- `UnLock`/`Lock` : extraire une fonction pure `RetirePid(sPids, iPid) As String` testable en
  gb.test (comportement actuel conservé), la correction du remplacement de sous-chaîne étant une
  anomalie (START-A04).
- `Start_Test` : à remplacer par le harnais gb.test (`./Laurux -T`, PLAN §0) ; en attendant,
  documenter le contrat de `Internal_Test`.

### Commonalisation avec d'autres fichiers

- **Couleurs par défaut `/Coul/*`** : mêmes clés écrites par
  [`Fmenu.preferences`](../Communs/Fmenu.class/architecture.md) (FMENU-013),
  [`SetColors.Button2_Click`](../Utils/SetColors.class/architecture.md) (SETCOLORS-005) et
  [`LauruxConf`](../Communs/LauruxConf.class/architecture.md) (LAURUXCONF-010), avec des
  séparateurs différents (`;` ici, `,` ailleurs). Proposition : un jeu de constantes commun, chaque
  appelant conservant ses chaînes exactes tant que FMENU-A03 n'est pas validée.
- **Contrôle de réplication** : `Utils.ReplicationOK(Optional sMessage)` proposé par FMENU-004/005,
  utilisé ici (l. 112-118, même message) ; voir [`Fmenu`](../Communs/Fmenu.class/rework.md) et
  [`Utils`](../Utils/Utils.module/architecture.md) (UTILS-A01 : `ControlTunnel` renvoie
  vraisemblablement toujours `False`).
- **Répertoire de debug** : `User.Home & "/tmp/Debug"` en dur ici (l. 94-97), dans
  [`LLog`](../Utils/LLog.class/architecture.md) et
  [`DB_Connection`](../Utils/DB_Connection.class/architecture.md) → `Utils.DebugDir()`.
- **Format de ligne de log** : le filtre `sLine Like "*;GUI;*"` dépend du format écrit par
  `DB_Connection.GUI_Event` et relu par `ReplayObserver.Replay_Event` et `DB_Log` → parseur commun
  et `Enum` des positions (DB_CONNECTION-013).
- **Société de démarrage** : la séquence « `/Soc`, `/dbase/Name`, `Save`, `Reload`, `Start.Societe` »
  existe aussi dans [`Fsoc`](../Communs/Fsoc.class/rework.md) (deux copies) : helper
  `Utils.ChangeSociete(code)` possible.

### Réduction de portée

- `Coul`, `Lock`, `Lancement`, `Parse_Args`, `Start_Test` : aucun appelant externe (grep) →
  `Private`. `Application_Signal` et `ReplayTimer_Timer` restent `Public` (handlers).
- `Arg_Config_File`, `Arg_Test`, `Arg_Start_Societe`, `Arg_Restore_DB`, `hReplayTimer`, `Evens`,
  `Ev`, `Evc`, `Evl` → `Private` (aucun lecteur externe).
- `Musique` : aucun écrivain trouvé ; `Public Const Musique As String = "son/warning.ogg"` resterait
  accessible comme `Start.Musique` (à confirmer avec `gbc3`).

### Séparation traitement / GUI

- Extraire de `Main` la décision « faut-il réinitialiser les couleurs ? » et l'écriture des clés
  (calcul pur sur `Settings`), le `Message.Warning` du verrou restant dans `Main`.
- `Restore_Args` : déjà sans GUI (sorties `Print`).

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : `Start` n'accède pas directement à la base.
