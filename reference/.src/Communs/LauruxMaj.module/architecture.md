# LauruxMaj — Architecture

> Source : `.src/Communs/LauruxMaj.module`

## Vue d'ensemble

`LauruxMaj` est le **module de migration du schéma** de la base Laurux. Il contient un dispatcher,
`Verif_Version`, appelé à chaque ouverture de la fenêtre principale de gestion
(`Fmenu.Form_Open`, [Fmenu.class:189](../../../../.src/Communs/Fmenu.class#L189), juste après `Majversion.RecupVersion()`), et 109
fonctions `MajXXX()`, une par version de schéma (de 4.0/5.0 « préhistoriques » à 3.69).

Chaque fonction `MajXXX()` applique sa liste de `CREATE`/`ALTER`/`DROP`/`UPDATE` presque
toujours sous `Try` (une erreur SQL est ignorée en silence), puis positionne le drapeau de module
`bMaj` selon le **dernier** `Try` exécuté (`If Not Error Then bmaj = True`).

**Règle de gel (AGENTS.md + consigne utilisateur)** : les étapes de mise à jour (toutes les
`MajXXX`, y compris `Maj369`) et leur dispatch dans `Verif_Version` ne sont **pas
refactorisables**. Une migration publiée a été exécutée sur les bases de production : toute
évolution ou correction passe par une **nouvelle** fonction `MajXYZ()` et un nouveau bloc de dispatch.
Vérification git : `Maj368` est la dernière migration présente dans un tag (`v3.68.0` à `v3.68.8`) ;
`Maj369` n'est dans aucun tag (version courante 3.69.0, `.project` / `.version`).

Nature globale : **mixte** (SQL de schéma + `ProgBar`, `Message.*`, fenêtres créées à la volée,
`Shell mysql`/`mysqldump`/`xdg-open`, écriture de `Laurux.conf`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `Soc` | var | Private | oui | String | 3 |
| `Tab` | var | Private | oui | String | 4 |
| `Tab1` | var | Private | oui | String | 5 |
| `intitule` | var | Private | oui | String | 6 |
| `Hfile` | var | Private | oui | File | 7 |
| `Lig` | var | Private | oui | String | 8 |
| `code` | var | Private | oui | String | 9 |
| `TabSoc` | var | Private | oui | String | 10 |
| `SocResult` | var | Private | oui | Result | 11 |
| `rResult` | var | Private | oui | Result | 12 |
| `r2Result` | var | Private | oui | Result | 13 |
| `bMaj` | var | Private | oui | Boolean | 14 |
<!-- /AUTO:declarations -->

Toutes les variables sont `Private` au module (donc statiques, partagées par toutes les migrations) :
`Soc`/`TabSoc`/`SocResult` (société en cours du pattern historique), `Tab`/`Tab1` (table
courante), `rResult`/`r2Result`, `code`, `intitule`, `Hfile`/`Lig` (lecture de fichiers dans
`Maj40`, `Maj310`, `Maj311`), `bMaj` (au moins une migration jouée → ouverture du changelog).

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `Verif_Version` | 17-1122 | Public | 332 | 883 | 1 |  |
| `Maj40` | 1124-1456 | Public | 77 | 311 | 0 | portée réductible ? |
| `Maj41` | 1458-1463 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj42` | 1465-1470 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj43` | 1472-1497 | Public | 6 | 24 | 0 | portée réductible ? |
| `Maj44` | 1499-1517 | Public | 7 | 17 | 0 | portée réductible ? |
| `Maj45` | 1519-1528 | Public | 2 | 8 | 0 | portée réductible ? |
| `Maj46` | 1530-1554 | Public | 13 | 19 | 0 | portée réductible ? |
| `Maj50` | 1556-1721 | Public | 20 | 150 | 0 | portée réductible ? |
| `Maj201` | 1723-1730 | Public | 3 | 6 | 0 | portée réductible ? |
| `Maj202` | 1732-1753 | Public | 3 | 19 | 0 | portée réductible ? |
| `Maj203` | 1755-1787 | Public | 10 | 26 | 0 | portée réductible ? |
| `Maj204` | 1789-1807 | Public | 5 | 17 | 0 | portée réductible ? |
| `Maj205` | 1809-1814 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj206` | 1816-1824 | Public | 3 | 6 | 0 | portée réductible ? |
| `Maj207` | 1826-1844 | Public | 9 | 14 | 0 | portée réductible ? |
| `Maj208` | 1846-1872 | Public | 15 | 25 | 0 | portée réductible ? |
| `Maj209` | 1874-1935 | Public | 18 | 54 | 0 | portée réductible ? |
| `Maj210` | 1937-1959 | Public | 9 | 18 | 0 | portée réductible ? |
| `Maj211` | 1961-2022 | Public | 46 | 56 | 0 | portée réductible ? |
| `Maj212` | 2024-2072 | Public | 10 | 43 | 0 | portée réductible ? |
| `Maj213` | 2074-2082 | Public | 1 | 6 | 0 | portée réductible ? |
| `Maj215` | 2084-2100 | Public | 4 | 13 | 0 | portée réductible ? |
| `Maj215a` | 2102-2107 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj216` | 2109-2114 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj217` | 2116-2128 | Public | 2 | 11 | 0 | portée réductible ? |
| `Maj217a` | 2130-2222 | Public | 69 | 81 | 0 | portée réductible ? |
| `Maj218` | 2224-2619 | Public | 244 | 331 | 0 | portée réductible ? |
| `Maj219` | 2621-2633 | Public | 5 | 9 | 0 | portée réductible ? |
| `Maj220` | 2635-2650 | Public | 7 | 14 | 0 | portée réductible ? |
| `Maj221` | 2652-2690 | Public | 14 | 37 | 0 | portée réductible ? |
| `Maj222` | 2692-2709 | Public | 11 | 16 | 0 | portée réductible ? |
| `Maj223` | 2711-2835 | Public | 42 | 118 | 0 | portée réductible ? |
| `Maj224` | 2837-2842 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj225` | 2844-2857 | Public | 6 | 11 | 0 | portée réductible ? |
| `Maj227` | 2859-2923 | Public | 17 | 58 | 0 | portée réductible ? |
| `Maj228` | 2925-2959 | Public | 6 | 31 | 0 | portée réductible ? |
| `Maj229` | 2961-3024 | Public | 14 | 45 | 0 | portée réductible ? |
| `Maj230` | 3026-3039 | Public | 6 | 10 | 0 | portée réductible ? |
| `Maj231` | 3041-3055 | Public | 5 | 10 | 0 | portée réductible ? |
| `Maj301` | 3057-3062 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj302` | 3064-3070 | Public | 3 | 5 | 0 | portée réductible ? |
| `Maj303` | 3072-3093 | Public | 8 | 19 | 0 | portée réductible ? |
| `Maj304` | 3095-3156 | Public | 9 | 54 | 0 | portée réductible ? |
| `Maj305` | 3158-3183 | Public | 5 | 18 | 0 | portée réductible ? |
| `Maj306` | 3185-3203 | Public | 5 | 15 | 0 | portée réductible ? |
| `Maj307` | 3205-3210 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj308` | 3212-3217 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj309` | 3219-3237 | Public | 8 | 15 | 0 | portée réductible ? |
| `Maj310` | 3239-3271 | Public | 14 | 30 | 0 | portée réductible ? |
| `Maj310b` | 3273-3291 | Public | 8 | 15 | 0 | portée réductible ? |
| `Maj311` | 3293-3334 | Public | 6 | 38 | 0 | portée réductible ? |
| `Maj312` | 3336-3345 | Public | 4 | 7 | 0 | portée réductible ? |
| `Maj312a` | 3347-3395 | Public | 38 | 45 | 0 | portée réductible ? |
| `Maj314` | 3397-3407 | Public | 5 | 9 | 0 | portée réductible ? |
| `Maj315` | 3409-3437 | Public | 9 | 23 | 0 | portée réductible ? |
| `Maj316` | 3439-3561 | Public | 13 | 113 | 0 | portée réductible ? |
| `Maj317` | 3563-3576 | Public | 6 | 10 | 0 | portée réductible ? |
| `Maj318` | 3578-3600 | Public | 7 | 19 | 0 | portée réductible ? |
| `Maj319` | 3602-3607 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj320` | 3609-3719 | Public | 28 | 94 | 0 | portée réductible ? |
| `Maj321` | 3721-3749 | Public | 8 | 21 | 0 | portée réductible ? |
| `Maj322` | 3751-3773 | Public | 9 | 16 | 0 | portée réductible ? |
| `Maj323` | 3775-3789 | Public | 5 | 10 | 0 | portée réductible ? |
| `Maj324` | 3791-3796 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj325` | 3798-3847 | Public | 26 | 40 | 0 | portée réductible ? |
| `Maj326` | 3849-3867 | Public | 5 | 15 | 0 | portée réductible ? |
| `Maj327` | 3869-3888 | Public | 4 | 15 | 0 | portée réductible ? |
| `Maj328` | 3890-3896 | Public | 3 | 5 | 0 | portée réductible ? |
| `Maj329` | 3898-3904 | Public | 3 | 5 | 0 | portée réductible ? |
| `Maj330` | 3906-3912 | Public | 3 | 5 | 0 | portée réductible ? |
| `Maj331` | 3914-3929 | Public | 7 | 14 | 0 | portée réductible ? |
| `Maj332` | 3931-3943 | Public | 5 | 11 | 0 | portée réductible ? |
| `Maj333` | 3945-3954 | Public | 5 | 8 | 0 | portée réductible ? |
| `Maj334` | 3956-3965 | Public | 5 | 8 | 0 | portée réductible ? |
| `Maj335` | 3967-3996 | Public | 12 | 28 | 0 | portée réductible ? |
| `Maj336` | 3998-4016 | Public | 4 | 17 | 0 | portée réductible ? |
| `Maj337` | 4018-4061 | Public | 15 | 37 | 0 | portée réductible ? |
| `Maj338` | 4063-4077 | Public | 5 | 10 | 0 | portée réductible ? |
| `Maj339` | 4079-4088 | Public | 4 | 7 | 0 | portée réductible ? |
| `Maj340` | 4090-4103 | Public | 3 | 11 | 0 | portée réductible ? |
| `Maj341` | 4105-4125 | Public | 6 | 15 | 0 | portée réductible ? |
| `Maj342` | 4127-4141 | Public | 3 | 10 | 0 | portée réductible ? |
| `Maj343` | 4143-4152 | Public | 4 | 7 | 0 | portée réductible ? |
| `Maj344` | 4154-4162 | Public | 3 | 7 | 0 | portée réductible ? |
| `Maj345` | 4164-4183 | Public | 10 | 16 | 0 | portée réductible ? |
| `Maj346` | 4185-4190 | Public | 3 | 4 | 0 | portée réductible ? |
| `Maj347` | 4192-4200 | Public | 6 | 7 | 0 | portée réductible ? |
| `Maj348` | 4202-4216 | Public | 8 | 13 | 0 | portée réductible ? |
| `Maj349` | 4218-4222 | Public | 2 | 3 | 0 | portée réductible ? |
| `Maj350` | 4224-4229 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj351` | 4231-4236 | Public | 2 | 4 | 0 | portée réductible ? |
| `Maj352` | 4238-4252 | Public | 7 | 13 | 0 | portée réductible ? |
| `Maj353` | 4254-4271 | Public | 11 | 16 | 0 | portée réductible ? |
| `Maj354` | 4273-4319 | Public | 29 | 41 | 0 | portée réductible ? |
| `Maj355` | 4321-4338 | Public | 4 | 16 | 0 | portée réductible ? |
| `Maj356` | 4340-4358 | Public | 5 | 17 | 0 | portée réductible ? |
| `Maj357` | 4360-4422 | Public | 32 | 57 | 0 | portée réductible ? |
| `Maj358` | 4424-4688 | Public | 45 | 250 | 0 | portée réductible ? |
| `maj359` | 4690-4712 | Public | 13 | 21 | 0 | portée réductible ? |
| `maj360` | 4714-4748 | Public | 22 | 28 | 0 | portée réductible ? |
| `Maj361` | 4750-4775 | Public | 15 | 20 | 0 | portée réductible ? |
| `Maj362` | 4777-4784 | Public | 4 | 5 | 0 | portée réductible ? |
| `Maj363` | 4786-4809 | Public | 8 | 17 | 0 | portée réductible ? |
| `Maj364` | 4811-4849 | Public | 8 | 35 | 0 | portée réductible ? |
| `Maj365` | 4851-4861 | Public | 3 | 8 | 0 | portée réductible ? |
| `Maj366` | 4863-4881 | Public | 5 | 15 | 0 | portée réductible ? |
| `Maj367` | 4883-4892 | Public | 4 | 7 | 0 | portée réductible ? |
| `Maj368` | 4894-5026 | Public | 67 | 110 | 0 | portée réductible ? |
| `Maj369` | 5028-6116 | Public | 550 | 969 | 0 | portée réductible ? |
<!-- /AUTO:fonctions -->

## Flux d'exécution de `Verif_Version`

[LauruxMaj.module:Verif_Version](../../../../.src/Communs/LauruxMaj.module#L17-L1122) [portée : nécessaire, appelée par `Fmenu`] [nature : mixte].

1. **Prologue** : `SET NAMES latin1 COLLATE latin1_swedish_ci` ([LauruxMaj.module:20](../../../../.src/Communs/LauruxMaj.module#L20)) — les
   bases antérieures à 3.69 sont en latin1 ; puis `SELECT * FROM Fiches_Societes` et
   `Soc = cd_sc` de la première ligne (utilisé uniquement par les blocs historiques).
2. **Blocs de dispatch séquentiels**, du plus ancien au plus récent : chaque bloc teste la version
   courante, appelle la migration et écrit la version suivante. Les blocs s'enchaînent dans le même
   appel (« fall-through ») : une base ancienne passe toutes les versions en un seul lancement, sauf
   aux ruptures signalées plus bas. Trois générations de stockage de la version coexistent :

   | Versions | Où est lue/écrite la version | Garde | Portée société |
   |---|---|---|---|
   | 2.04 → 3.09 | `Laurux.conf` : `/dbase/Version` (`"Laurux V2,03"`… puis `"Laurux V2.20"`…) | aucune (2.04-2.20), puis `/dbase/Maj` **ou** `/dbase/Host = "localhost"` | boucle `Repeat … Until SocResult.MoveNext()` sur **toutes** les lignes de `Fiches_Societes` (tables suffixées par code société dans une base unique) ; 3.08 : première société seulement ; 3.09 : société `/Soc` |
   | 3.10 → 3.59 | `Laurux.conf` : `/Societes/Soc<XX>` (+ copie dans `/dbase/Version`) | `/dbase/Maj` (3.10 : Maj ou localhost) | société ouverte (`Start.Societe`) |
   | 3.60 → 3.69 | **base** : `Fiches_Parametres.version` (`"3.61"`…) | `/dbase/Maj` pour l'appel de la migration **seulement** | base de la société ouverte (`Prefixe & "Laurux" & Societe`, [Start.module:109](../../../../.src/Start.module#L109)) |

   - 3.10 ([LauruxMaj.module:Maj310](../../../../.src/Communs/LauruxMaj.module#L3239-L3271)) sépare les sociétés : les tables suffixées `XX` des autres
     sociétés sont supprimées, celles de la société sont renommées sans suffixe. Depuis, **une
     base par société**, migrée lorsqu'elle est ouverte.
   - 3.60 et 3.61 lisent `Majversion.Version` (lu par `Fmenu` avant l'appel) ; `Maj360` crée la
     colonne `version` et y écrit `"3.60"` lui-même. À partir de 3.62, chaque bloc relit
     `SELECT * FROM Fiches_Parametres` puis, si `rResult!version` vaut N :
     `If /dbase/Maj Then MajN+1()` et `Try UPDATE Fiches_Parametres SET version = "N+1"`
     (toutes les lignes ; pas de test `Available`).
3. **Épilogue** : `SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci` ([LauruxMaj.module:1112](../../../../.src/Communs/LauruxMaj.module#L1112)) puis,
   si `bMaj`, `Shell "xdg-open 'http://www.laurux.fr/changelog'"`.
4. **`Catch` global** : toute erreur **non** protégée par `Try` (dans le dispatcher ou dans une
   `MajXXX`) remonte ici ; les instructions suivantes ne sont pas exécutées. Le message « Une erreur
   importante a eu lieu lors de la mise a jour… Il est imperatif de restaurer votre précédente
   version… » n'est affiché que si `Majversion.RecupVersion(False)` (version en base) diffère de
   `Majversion.RecupVersionApp()` (`Application.Version` tronquée à `X.Y`). Aucun `Rollback`.
   `DB_Connection.Exec` affiche au préalable sa propre `Message.Error` si `backtrace` est actif.

### Drapeau `/dbase/Maj`

Lu par `Start.LocalSettings["/dbase/Maj"]` (édité par `LauruxConf`) : `0` = désactivé, `1`/`-1` =
activé. Pour 3.12 → 3.59 et 3.61 → 3.69, il ne conditionne **que l'appel** de la migration : la
version est incrémentée **même si Maj = 0**. Un poste à `Maj = 0` qui ouvre une base N la marque
donc N+1 sans en modifier le schéma (voir dernière section).

### Ruptures et particularités historiques (figées)

- `Maj208` est appelée trois fois (blocs « taux de mo » 2.07→2.07, 2.08 et 2.14) ; `Maj225` deux
  fois (2.25, 2.26) ; `Maj312a` deux fois (3.12a, 3.13) ; il n'existe pas de `Maj214`.
- Le bloc 2.20 écrit `"Laurux V2,20"` (virgule) alors que le bloc 2.21 attend `"Laurux V2.20"`
  (point) : la chaîne s'arrête en 2.20 pour une base plus ancienne.
- `Majversion.Version` n'est pas relu après `Maj360` : une base 3.59 demande deux lancements.
- Une base en SQLite ne passe jamais le prologue : `SET NAMES` n'est pas traduit par
  `DB_Connection.Exec` (à confirmer en phase 2) ; l'erreur saute au `Catch`, silencieux si la
  version en base est déjà celle de l'application.
- Le mode caisse (`./Laurux -p`, `Cmenu`) n'appelle pas `Verif_Version` : aucune migration.

## Tableau synthétique des migrations (pattern historique et récent)

Tables sans préfixe `Fiches_` ; `Docs_*`, `Mails_*`, `Corsage` en clair. Extraction statique des
noms de tables cités dans chaque fonction (hors commentaires).

| Version | Fonction | Stockage version | Garde | Tables touchées |
|---|---|---|---|---|
| 2.04 | `Maj204` | ini /dbase/Version | boucle sociétés | Art, CdBarre |
| 2.06 | `Maj206` | ini /dbase/Version | boucle sociétés | Agenda, Marques |
| 2.07 | `Maj207` | ini /dbase/Version | boucle sociétés | Art, EtiGond, EtiProd, Four |
| 2.07 bis | `Maj208` | ini /dbase/Version | boucle sociétés | Art, Centrales, Four, Ligbl, Mo, Txtmo |
| 2.08 | `Maj208` | ini /dbase/Version | boucle sociétés | Art, Centrales, Four, Ligbl, Mo, Txtmo |
| 2.09 | `Maj209` | ini /dbase/Version | boucle sociétés | Caisses, Carte, EntTickets, EntTicketz, HisEntTickets, LigTickets |
| 2.10 | `Maj210` | ini /dbase/Version | boucle sociétés | Art, Caisses, Carte, LigTickets, LigTicketz |
| 2.11 | `Maj211` | ini /dbase/Version | boucle sociétés | Caisses, Cli, Four, LigTickets, LigTicketz, LigblM |
| 2.12 | `Maj212` | ini /dbase/Version | boucle sociétés | AdrlivC, Caisses, ContactC, ContactF, LigTickets, LigTicketz |
| 2.13 | `—` | ini /dbase/Version | — | aucune (version seule, sans `Save`) |
| 2.13 | `Maj213` | ini /dbase/Version | boucle sociétés | Cli, Four |
| 2.14 | `Maj208` | ini /dbase/Version | boucle sociétés | Art, Centrales, Four, Ligbl, Mo, Txtmo |
| 2.15 | `Maj215` | ini /dbase/Version | boucle sociétés | Acomptes, Caisses, Parametres |
| 2.15a | `Maj215a` | ini /dbase/Version | boucle sociétés | Caisses |
| 2.16 | `Maj216` | ini /dbase/Version | boucle sociétés | Cli |
| 2.17 | `Maj217` | ini /dbase/Version | boucle sociétés | Traites |
| 2.17a | `Maj217a` | ini /dbase/Version | boucle sociétés | Art, Cli, Four, HisEntTickets, HisLigTickets, HisentMat, HistoFac, HistoFacM, HistoLigfac, HistoLigfacM, Materiels |
| 2.18 | `Maj218` | ini /dbase/Version | boucle sociétés | Acomptes, AdrlivC, Agenda, Art, ArtPromo, Avoirs, Bl, BlM, Caisses, Carte, CdBarre, Centrales, Cli, Cli_Vtl, ClientCaisse, Comptes, ContactC, ContactF, … |
| 2.19 | `Maj219` | ini /dbase/Version | boucle sociétés;Host=localhost | Art, BlM, Mo |
| 2.20 | `Maj220` | ini /dbase/Version | boucle sociétés;Host=localhost | HistoLigfac, HistoLigfacM, Libelles, Ligbl, LigblM, Mo |
| 2.21 | `Maj221` | ini /dbase/Version | boucle sociétés;Maj | Docs_Clients, Docs_Fournisseurs, Docs_Produits, Cli, Entcom, Four, HistoFac, HistoFacM |
| 2.22 | `Maj222` | ini /dbase/Version | boucle sociétés;Maj | Docs_Clients, Docs_Fournisseurs, Docs_Produits, Parametres |
| 2.23 | `Maj223` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Fam, ImpArtDef, ImpArtDef2, Mvt, Parametres, TxtMail |
| 2.24 | `Maj224` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Mvt |
| 2.25 | `Maj225` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Art, Cli |
| 2.26 | `Maj225` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Art, Cli |
| 2.27 | `Maj227` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Art, Etiquettes, Lcr, Mvtexpdc, Traites |
| 2.28 | `Maj228` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Lcr, Mvtexpdc, Traites |
| 2.29 | `Maj229` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Cbase:TabDepots, CdFour, Depots, Sdepots, StkDepots, TarFour |
| 2.30 | `Maj230` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Bl, BlM, HistoFac |
| 3.00 | `Maj231` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Inv, InvT, Ligcom, Regltz |
| 3.01 | `Maj301` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Cli |
| 3.02 | `Maj302` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | BlM |
| 3.03 | `Maj303` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Mvt, Parametres |
| 3.04 | `Maj304` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Banques, Bordereaux, Ligabon, RubCompt, TabContact, TabContactF, TxtMailC |
| 3.05 | `Maj305` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | ContactC, ContactF, TarTypcli, Tarcli |
| 3.06 | `Maj306` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Art, Rpl1, Rpl2 |
| 3.07 | `Maj307` | ini /dbase/Version | boucle sociétés;Maj OU Host=localhost | Mvtexp |
| 3.08 | `Maj308` | ini /dbase/Version | 1re société;Maj OU Host=localhost | Mo |
| 3.09 | `Maj309` | ini /dbase/Version | Maj OU Host=localhost | Comptes, Parametres, SousComptes |
| 3.10 | `Maj310` | ini /Societes/SocXX | Maj OU Host=localhost | tables suffixées `XX` des autres sociétés supprimées, tables de la société renommées sans suffixe (`mysql` en Shell) |
| 3.10b | `Maj310b` | ini /Societes/SocXX | Maj | Comptes, Parametres, SousComptes |
| 3.11 | `Maj311` | ini /Societes/SocXX | Maj | moteur de toutes les tables (`show tables` en Shell), Corsage |
| 3.12 | `Maj312` | ini /Societes/SocXX | Maj | Art, Regltz |
| 3.12a | `Maj312a` | ini /Societes/SocXX | Maj | Cequ, HistoFacM, ImpArtDef2 |
| 3.13 | `Maj312a` | ini /Societes/SocXX | Maj | Cequ, HistoFacM, ImpArtDef2 |
| 3.14 | `Maj314` | ini /Societes/SocXX | Maj | Four, Ligbl |
| 3.15 | `Maj315` | ini /Societes/SocXX | Maj | Corsage, CoeffTypec, LigblM, Materiels |
| 3.16 | `Maj316` | ini /Societes/SocXX | Maj | Analytiques, HistoLigfac, HistoLigfacM, Ligbl, LigblM, MvtA, MvtA1, MvtA2, MvtA3, MvtA4, MvtA5, Postes |
| 3.17 | `Maj317` | ini /Societes/SocXX | Maj | Cli, Entrecpt, Four |
| 3.18 | `Maj318` | ini /Societes/SocXX | Maj | Clid, Four, HistoLigfac |
| 3.19 | `Maj319` | ini /Societes/SocXX | Maj | Mvt |
| 3.20 | `Maj320` | ini /Societes/SocXX | Maj | Banques, Bordereaux, Caisses, Comptes, EntTickets, EntTicketz, Entrecpt, Fam, Four, HisEntTickets, Lcr, Ligabon, Mvt, Parametres, Traites |
| 3.21 | `Maj321` | ini /Societes/SocXX | Maj | Corsage, Art, Comptes, Entrecpt, Fam, Parametres |
| 3.22 | `Maj322` | ini /Societes/SocXX | Maj | Cli, ContactC, ContactF, Four |
| 3.23 | `Maj323` | ini /Societes/SocXX | Maj | Cli, ContactC, ContactF, Four |
| 3.24 | `Maj324` | ini /Societes/SocXX | Maj | Art |
| 3.25 | `Maj325` | ini /Societes/SocXX | Maj | Art, Caisses, HisLigTickets, HistoFac, HistoFacM, LigTickets, LigTicketz, Mvt, Postes |
| 3.26 | `Maj326` | ini /Societes/SocXX | Maj | Art, Cli, HisInvT |
| 3.27 | `Maj327` | ini /Societes/SocXX | Maj | Cli, HisEntTickets, Touches |
| 3.28 | `Maj328` | ini /Societes/SocXX | Maj | Art |
| 3.29 | `Maj329` | ini /Societes/SocXX | Maj | Touches |
| 3.30 | `Maj330` | ini /Societes/SocXX | Maj | Touches |
| 3.31 | `Maj331` | ini /Societes/SocXX | Maj | Bl, Cli, Entcom, Entrecpt, Ligcom, Ligrecpt |
| 3.32 | `Maj332` | ini /Societes/SocXX | Maj | Entcom, Entrecpt, Four, Ligbl |
| 3.33 | `Maj333` | ini /Societes/SocXX | Maj | Entcom, Entrecpt |
| 3.34 | `Maj334` | ini /Societes/SocXX | Maj | Entcom, Entrecpt |
| 3.35 | `Maj335` | ini /Societes/SocXX | Maj | Docs_Autres, Docs_Clients, Docs_Compta, Docs_Fournisseurs, Docs_Produits |
| 3.36 | `Maj336` | ini /Societes/SocXX | Maj | Docs_Autres, Docs_Compta |
| 3.37 | `Maj337` | ini /Societes/SocXX | Maj | Cbase:TabCli, Cbase:TabFour, Cbase:TabMailCli, Cbase:TabMailFour, Docactif, Journaux, Mvt, Mails_Cli, Mails_Four |
| 3.38 | `Maj338` | ini /Societes/SocXX | Maj | BlM, LigblM, Mails_Cli, Mails_Four |
| 3.39 | `Maj339` | ini /Societes/SocXX | Maj | Caisses, Touches |
| 3.40 | `Maj340` | ini /Societes/SocXX | Maj | Cli, Commerciaux |
| 3.41 | `Maj341` | ini /Societes/SocXX | Maj | ContactC, ContactF, Docactif, Numabon, Sms |
| 3.42 | `Maj342` | ini /Societes/SocXX | Maj | Cli, Docactif, Four, Numabon |
| 3.43 | `Maj343` | ini /Societes/SocXX | Maj | Docactif, Mvt |
| 3.44 | `Maj344` | ini /Societes/SocXX | Maj | Bl, BlM |
| 3.45 | `Maj345` | ini /Societes/SocXX | Maj | Art, Bl, BlM, Caisses, FamDep, HistoLigfac, HistoLigfacM |
| 3.46 | `Maj346` | ini /Societes/SocXX | Maj | Art, HistoFac |
| 3.47 | `Maj347` | ini /Societes/SocXX | Maj | HistoLigfac, HistoLigfacM, LigTicketz |
| 3.48 | `Maj348` | ini /Societes/SocXX | Maj | Art, Caisses, EntTickets, EntTicketz, HisEntTickets |
| 3.49 | `Maj349` | ini /Societes/SocXX | Maj | Four |
| 3.50 | `Maj350` | ini /Societes/SocXX | Maj | Parametres |
| 3.51 | `Maj351` | ini /Societes/SocXX | Maj | Fam |
| 3.52 | `Maj352` | ini /Societes/SocXX | Maj | Caisses, LigTickets, LigTicketz, Parametres, PrdComp |
| 3.53 | `Maj353` | ini /Societes/SocXX | Maj | Caisses, EntTickets, Ligrecpt, Touches |
| 3.54 | `Maj354` | ini /Societes/SocXX | Maj | Bl, Caisses, EntTickets, EntTicketz, Fam, ImpArtDef2 |
| 3.55 | `Maj355` | ini /Societes/SocXX | Maj | BordereauxC, Cli, Journaux |
| 3.56 | `Maj356` | ini /Societes/SocXX | Maj | BordereauxC, Journaux, Parametres |
| 3.57 | `Maj357` | ini /Societes/SocXX | Maj | Art, Bl, Carte, Comptes, Fam, ImpArtDef2, Ligbl, LigblM, Mo, Taches, Tvaac, Tvaav, Users |
| 3.58 | `Maj358` | ini /Societes/SocXX | Maj | Bl, BlM, HisEntTickets, HistoFac, HistoFacM, Mvt, Mvt1, Mvt2, Mvt3, Mvt4, Mvt5, MvtM, MvtM1, MvtM2, MvtM3, MvtM4, MvtM5 |
| 3.59 | `Maj359` | ini /Societes/SocXX | Maj | Bl, BlM, EntTicketz, HisEntTickets, HistoFac, HistoFacM, Mvt |
| 3.60 | `Maj360` | base | Maj | Bl, BlM, EntTicketz, Etiquettes, HisEntTickets, HisLigTickets, Mvt, MvtM, Parametres |
| 3.61 | `Maj361` | base | Maj | Cli, Four, MvtM, Parametres |
| 3.62 | `Maj362` | base | Maj | Bl, BlM |
| 3.63 | `Maj363` | base | Maj | Caisses, EntTickets, EntTicketz, HisEntTickets, Parametres |
| 3.64 | `Maj364` | base | Maj | Caisses, Materiels, Mvt |
| 3.65 | `Maj365` | base | Maj | ComMail |
| 3.66 | `Maj366` | base | Maj | AdrlivBL, MvtM |
| 3.67 | `Maj367` | base | Maj | Ligbl, LigblM |
| 3.68 | `Maj368` | base | Maj | AdrlivC, Art, Bl, BlM, Caisses, Cli, CoeffTypec, Docactif, EntTickets, EntTicketz, Fam, FamDep, HisLigTickets, HistoFac, HistoFacM, HistoLigfac, … |
| 3.69 | `Maj369` | base | Maj | voir § Maj369 (≈ 60 tables : conversion utf8mb4/InnoDB de toute la base, Reglements, TarTemp, Docs_Ged, Tag, Mvt*/MvtM*/MvtA*, index) |

**Fonctions jamais appelées** (antérieures au premier bloc 2.04, dispatch supprimé) :
[LauruxMaj.module:Maj40](../../../../.src/Communs/LauruxMaj.module#L1124-L1456) (tables `XX` par société, lecture de `CV.txt`), `Maj41` à `Maj46`,
[LauruxMaj.module:Maj50](../../../../.src/Communs/LauruxMaj.module#L1556-L1721) (création des tables de caisse), `Maj201`, `Maj202`, `Maj203`,
`Maj205` (vérifié par `grep` : aucun appel, ni dans le module ni ailleurs). Elles restent figées.

## `Maj369` (version en cours, non taguée)

[LauruxMaj.module:Maj369](../../../../.src/Communs/LauruxMaj.module#L5028-L6116) (CC 550, ~970 lignes) [portée : réductible en théorie, figée par
consigne] [nature : mixte]. Étapes dans l'ordre :

1. **Sauvegarde** `mysqldump … > ~/SauveV368/<base>.sql<aaaammjj>` (mot de passe en ligne de commande).
2. **Conversion utf8mb4/InnoDB** via `information_schema` (schéma `"Laurux" & Start.Societe`) :
   question si aucune colonne non utf8mb4 (« déjà effectuée », saut `Goto end_utf8`), puis requêtes
   générées : moteur, base, tables, contenu (`CONVERT(CAST(CONVERT(… USING latin1) AS BINARY) USING
   utf8mb4)`), type des colonnes ; `ALTER DATABASE … DEFAULT COLLATE`, `SET NAMES utf8mb4`.
3. `/Soc<XX>/Decais = True` dans `Laurux.conf`.
4. **Achats** : `Materiels.mat_ddate` en datetime, `Fiches_TarTemp`, `Ligrecpt`/`Ligcom` en
   DECIMAL (+ `txconv`, `majtarif`), `Entrecpt.validee`.
5. **Règlements** : création et remplissage de `Fiches_Reglements` (codes 01 à 40) depuis
   `Fiches_Parametres` (`jrnal2/3`, `viremc`…) et `/Soc<XX>/Cheque|Carte`, recodage de
   `Fiches_Cli.cli_reg`, dans une transaction (`Begin`/`Commit`).
6. **Caisse** : `Fiches_Caisses` ; contrôle « moulinage effectué » sur `Fiches_EntTickets<XX>` et
   `Fiches_EntTicketz` (sinon `Message.Error` et `Return`) ; suppression des tables par caisse
   (`EntTickets`, `Reglts`, `LigTickets`, `Ticketx`, `Ticketz` + code), `Regltz` ;
   renumérotation des `block` de `Fiches_HisLigTickets`.
7. **Dates** (via `LDate`) : `Art.art_ddate`/`art_cdate`, `Avoirs.dte`, `HistoLigfac(M)`,
   `Ligbl(M)`, `HisEntTickets.date` (+ `HisLigTickets.date`) ; options `/pp` et `/bois`.
8. **Acomptes/avoirs** (`cli_code` = client caisse ou `411027`), comptes `419100`, `419700`,
   `468700` (via `Cbase.Table("TabComptes")`), `Fiches_Parametres` (`dntk`, `cutk`, `dnart`,
   `ecart`, `jrnod`, suppression `viremc`…).
9. **Comptabilité** : `Mvt`/`MvtM`/`MvtA` et leurs copies 1 à 5 (types, `lind` AUTO_INCREMENT,
   suppression `numerop`…) ; `Ligabon`, `Numabon`.
10. **GED** : création `Docs_Ged`, `Fiches_Tag`, `Docs_Tag`, fusion des anciennes tables
    `Docs_Autres|Clients|Compta|Fournisseurs|Produits` puis leur suppression.
11. **Nettoyage** : tables obsolètes (`Corjxs`, `Cpostaux01-09`, `TxtMailC`, `TarFour`), clés
    primaires manquantes, ~150 `DROP INDEX` obsolètes, création des index `idx_*` (`ADD INDEX IF
    NOT EXISTS`), `Sha1Calc.CalcSha1_all("Fiches_Mvt")`, `/Soc<XX>/Fichiers`.

## Autres migrations notables (figées)

- [LauruxMaj.module:Maj218](../../../../.src/Communs/LauruxMaj.module#L2224-L2619) (CC 244) : alignement massif des types (242 `ALTER`).
- [LauruxMaj.module:Maj217a](../../../../.src/Communs/LauruxMaj.module#L2130-L2222) : création des index `id_*` (supprimés pour l'essentiel en 3.69).
- [LauruxMaj.module:Maj358](../../../../.src/Communs/LauruxMaj.module#L4424-L4688) : création de `Fiches_MvtM` et `MvtM1-5` (index `date`, `numero2`,
  `compte2`).
- [LauruxMaj.module:Maj368](../../../../.src/Communs/LauruxMaj.module#L4894-L5026) : copie de `Laurux3.conf` vers `<Application.Name>.conf` (avec
  `Message.Warning`), `Fiches_Docactif`, `Fiches_tourne`, `/Soc<XX>/nbfam|ipr|pp|bois`.
- Vérification git : 34 fonctions historiques (dont `Maj40`, `Maj218`, `Maj358`, `Maj368`) diffèrent
  de leur état au tag ancêtre `v3.68.4` (passage à `Utils.db.AutoIncrement()` /
  `Utils.db.Engine()` pour SQLite : la colonne auto-incrémentée passe en fin de table, suppression de
  la création de `Corjxs`). Une base reconstruite par rejeu complet n'a donc pas le même ordre de
  colonnes que les bases de production.
- `Maj42`, `Maj43`, `Maj44` et `Maj45` ne sont appelées par aucun bloc de `Verif_Version` (signal
  `unused` de `deps.py`, vérifié par grep). Ce sont des migrations figées :
  ni suppression ni rework (règle des migrations), constat seulement.

## État global utilisé

- `Start.LocalSettings` : `/dbase/Version`, `/dbase/Maj`, `/dbase/Host`, `/Soc`, `/Societes/Soc<XX>`,
  `/Soc<XX>/…` (`Faca`, `Decais`, `Cheque`, `Carte`, `pp`, `bois`, `nbfam`, `ipr`, `Fichiers`…) ;
  `Start.Societe`.
- `Utils.db` (`Exec`, `Create9`, `AutoIncrement`, `Engine`, `Begin`/`Commit`, `Tables`, `Login`,
  `Password`, `Name`), `Utils.cpoint`.
- `Majversion.Version`, `RecupVersion`, `RecupVersionApp` (auto-instance du formulaire).
- `LDate`, `LGed` (constantes de type), `Mreglement.lcr_acc|lcr_nacc`, `ProgBar`,
  `Sha1Calc.CalcSha1_all`, `Cbase.Table` (14 appels seulement : les migrations écrivent les noms
  physiques en dur, ce qui est voulu pour une migration).
- Effets externes : `Shell mysql`/`mysqldump`/`xdg-open`, fichiers `~/tmp/tables.txt`,
  `~/SauveV368/`, `~/.config/gambas3/*.conf`.

## Propositions d'amélioration

Par consigne utilisateur, **aucune refactorisation** des étapes de mise à jour ni de leur dispatch.
Le rework se limite à la documentation d'en-tête du module (voir rework.md).

### Réécriture / refactorisation

- Aucune (migrations et dispatcher figés).

### Commonalisation avec d'autres fichiers

- Pour information (hors de ce fichier) : la lecture de la version en base est dupliquée entre
  [`Majversion`](../Majversion.class/architecture.md) (`RecupVersion`/`RecupVersionApp`) et
  [`FRestore`](../FRestore.class/architecture.md) (`Verif_Version`, homonyme sans rapport avec ce module).
- La ligne `mysqldump` de `Maj369` est l'une des 14 copies (FSauve, SauvesAuto, Moulinage, Validinv…) :
  un futur helper commun ne s'appliquerait qu'aux autres fichiers.
- Les futures migrations pourraient s'appuyer sur
  [`DB_Sanity`](../../Utils/DB_Sanity.class/architecture.md) (`SyncKeys`) et `db_control.csv` pour les
  index, plutôt que de lister les `DROP INDEX` à la main.

### Réduction de portée

- Les 109 `MajXXX` sont `Public` sans appelant externe (vérifié par `grep`), mais figées : pas de
  changement. Seul `Verif_Version` est appelé de l'extérieur.

### Séparation traitement / GUI

- Aucune (figé). À retenir pour les **futures** migrations : pas de dialogue modal au milieu d'une
  migration (bloque les tests replay), contrôles préalables avant toute modification.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md. Toute correction ne peut passer que par une
nouvelle migration `MajXYZ()` (changement de schéma) ou par une évolution du dispatcher validée par
l'utilisateur._

Défauts relevés dans les migrations et leur dispatch :

- **Arrêt partiel marqué comme réussi** : sur moulinage non effectué, `Maj369` fait `Return`
  ([LauruxMaj.module:5315](../../../../.src/Communs/LauruxMaj.module#L5315), [LauruxMaj.module:5337](../../../../.src/Communs/LauruxMaj.module#L5337)) mais le dispatcher écrit quand même
  `version = 3.69` ([LauruxMaj.module:1107](../../../../.src/Communs/LauruxMaj.module#L1107)) : base à moitié migrée, jamais reprise. De plus
  [LauruxMaj.module:5314](../../../../.src/Communs/LauruxMaj.module#L5314) teste `If Message.Error(…)` sans `= 1` : « Continuer » arrête aussi, et les
  tables des caisses déjà parcourues sont supprimées avant l'arrêt.
- **`Maj = 0` incrémente la version** sans migrer ([LauruxMaj.module:1106](../../../../.src/Communs/LauruxMaj.module#L1106)-1107 et blocs 3.12 →
  3.59) : un poste client démarré en premier fige la base dans un schéma ancien.
- **SQLite** : `SET NAMES` ([LauruxMaj.module:20](../../../../.src/Communs/LauruxMaj.module#L20)) fait échouer tout le dispatcher ; `Maj369`
  utilise en plus `mysqldump`, `information_schema`, `LAST_INSERT_ID()`, `UPDATE` multi-tables
  ([LauruxMaj.module:5498](../../../../.src/Communs/LauruxMaj.module#L5498)), non traduits.
- **Nom de base** : `information_schema` filtré sur `"Laurux" & Start.Societe`
  ([LauruxMaj.module:5054](../../../../.src/Communs/LauruxMaj.module#L5054)) et `ALTER DATABASE Laurux<XX>` sans `Try` ([LauruxMaj.module:5077](../../../../.src/Communs/LauruxMaj.module#L5077)),
  alors que le nom réel inclut `/dbase/Prefixe` : conversion utf8mb4 ignorée ou erreur (à confirmer).
- **Fusion GED** : `(rResult.Available And rResult.Max) > 0` ([LauruxMaj.module:5817](../../../../.src/Communs/LauruxMaj.module#L5817)) exclut le cas
  d'un seul document, puis les tables `Docs_*` sont supprimées (à confirmer : sémantique de `And`
  booléen/entier).
- **Dates des BL matériel** remplies depuis `Fiches_Bl` au lieu de `Fiches_BlM`
  ([LauruxMaj.module:5494](../../../../.src/Communs/LauruxMaj.module#L5494)).
- **Typo `vatchar(25)`** : la colonne `Fiches_Societes.caution` (option bois) n'est jamais créée
  ([LauruxMaj.module:5508](../../../../.src/Communs/LauruxMaj.module#L5508)).
- **Empreintes Sha1** recalculées pour `Fiches_Mvt` seulement ; l'appel pour `Fiches_Mvt1` est
  commenté « A REMETTRE AVANT COMMIT : DO NOT PUSH » ([LauruxMaj.module:6106](../../../../.src/Communs/LauruxMaj.module#L6106)).
- **`ADD INDEX IF NOT EXISTS`** ([LauruxMaj.module:6077](../../../../.src/Communs/LauruxMaj.module#L6077) à 6100) : syntaxe MariaDB ; sous MySQL les
  index `idx_*` ne sont pas créés (`Try` silencieux).
- **Index historiques résiduels** absents de `db_control.csv` et non supprimés par `Maj369` :
  `HistoFac`/`HistoFacM` `id_numfac…id_numserie` et `HisEntTickets` `id_date`, `id_montanttc`
  ([LauruxMaj.module:Maj217a](../../../../.src/Communs/LauruxMaj.module#L2130-L2222)), `MvtM`/`MvtM1-5` `date`, `numero2`, `compte2`
  ([LauruxMaj.module:Maj358](../../../../.src/Communs/LauruxMaj.module#L4424-L4688)). Présents dans `Laurux01.sql` de `v3.68.4` : écart DB_Sanity attendu
  après migration (corrigeable par `DB_Sanity.SyncKeys`).
- **Types ajoutés si absents** différents de la référence : `HistoFac.mtreg` ajouté en `VarChar(12)`
  ([LauruxMaj.module:5906](../../../../.src/Communs/LauruxMaj.module#L5906)) alors que `db_control.csv` attend `char(12)` ; `Entcom.commentaire`
  ajouté en `TEXT` après la conversion ([LauruxMaj.module:5911](../../../../.src/Communs/LauruxMaj.module#L5911)), référence `mediumtext`.
- **Transaction** des règlements (`Begin` [LauruxMaj.module:5210](../../../../.src/Communs/LauruxMaj.module#L5210)) sans `Rollback` en cas d'erreur.
- **Message** du compte `468700` libellé « compte d'avoir client » (copier-coller, [LauruxMaj.module:5597](../../../../.src/Communs/LauruxMaj.module#L5597)).
- **Migrations taguées modifiées a posteriori** (34 fonctions, voir plus haut) : décision utilisateur à
  prendre (revenir à l'état tagué ou entériner) ; impacte la reproductibilité d'un rejeu complet.
- **Fonctions mortes** `Maj40`…`Maj205` (12) : leur suppression déroge au gel, décision utilisateur.
- **Chaîne historique** : rupture `V2,20`/`V2.20`, `Maj208` ×3, double lancement 3.59 → 3.61
  (bases hors support, pas de correction recommandée).
- Référentiels : `db_control.csv` et `Laurux01.sql` (HEAD) sont cohérents (mêmes tables et colonnes ;
  seuls écarts : `unsigned` sur `Fiches_LibelFac.mind` et `Fiches_Mvtexp.mind`, ordre de colonnes
  de `Bl`, `BlM`, `Mvt*`, `MvtM*`). Les colonnes d'options (`tipp*`, `ident`, `arrete`,
  `Fiches_ligregie`) sont absentes de la référence : DB_Sanity les signale chez les clients concernés.
  `Laurux01.sql` du tag `v3.68.0` porte `version = 3.67` (base de référence en retard d'une version).
