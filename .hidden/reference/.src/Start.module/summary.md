# Start — Synthèse

> Source : `.src/Start.module` · Synthèse des autres documents (~100 lignes max, sans case à cocher).

## Rôle

Module de démarrage de Laurux (`Startup=Start`). Il lit la ligne de commande, charge la
configuration (`Start.LocalSettings`), choisit la société, contrôle le verrou `~/Laurux.lock`,
crée la fenêtre principale (`Fmenu`, ou `Cmenu` avec `-p`) puis attend la sortie. Il porte aussi le
rejeu de log (`-r`), la restauration de base (`--restore`) et le harnais de tests internes (`-t`).
Ses 51 variables `Public` forment l'essentiel de l'état global du projet.

## Points clés

- Boucle de redémarrage dans `Main` (`Start.Restart`, posé par `LauruxConf`) ; sortie par
  `Utils.Exit` → `SIGINT` → `Application_Signal` → `Quit (Not Start.Success)`.
- Options : `-c`, `-p`, `-l`, `-r`, `--devel`, `--logfile`, `-d`, `--version-full`, `-s`,
  `--restore`, `-t`. Sans l'option, la variable `Arg_*` vaut `Null` (le 4ᵉ argument de `Args.Get` est
  le nom affiché dans l'aide).
- `-t list|all|<Classe>[,…]` : seules `LPrix` et `LScript` (chargées de force) sont testées ;
  `list` affiche les classes, `all` ou le nom joue les tests, les autres classes affichent
  `SKIPPED`. Aucun test n'a d'assertion aujourd'hui ; les tests ne tournent qu'après l'ouverture
  complète de `Fmenu` (base et affichage nécessaires).
- Aucun SQL direct ; dépendances système : `ps`, client `mysql` (restauration), fichiers
  `branch.txt`, `sha1.txt`, `~/tmp/Debug`.
- Fonctions les plus complexes : `Lancement` (CC 35) et `Main` (CC 34).

## Globales (réduction visée)

- Très partagées, à conserver : `LocalSettings` (187 fichiers), `son` (193), `Musique` (176),
  `Societe` (159), `R/G/B` (31).
- Mortes : `Nstockes`, `Suspendus`, `StartDate` (+ `Private hpb`, `hlb`) ; `$cai` est en fait utilisée par la
  caisse (`Svendeur` l'écrit, `Caisse` la lit : corrigé après le lot Caisse).
- Sans lecteur externe, à passer `Private` : 4 `Arg_*` et 5 variables de rejeu.
- Écrites ailleurs (protocoles implicites) : `Societe` (`Fsoc`), `Motdepasse` (`MDP`, `Fmenu`,
  `Fsoc`), `$tcai` (`Ouverture`, `Fmenu`), `Success`/`Exit` (`Utils`), `Restart` (`LauruxConf`),
  `GlobalSettings` (`Fmenu`, `Prefs`).

## Dépendances principales

- Utilise : `Utils` (`Exit`, `ControlTunnel`, `*_DataBase`), `ReplayObserver.Replay_Event`, `LLog`,
  `Fmenu`/`Cmenu`/`FTips` (création dynamique), `LPrix`/`LScript` (tests).
- Utilisé par : environ 300 fichiers via les globales ; fonctions appelées de l'extérieur :
  `UnLock` (7 fichiers), `Restore_Args` (`Fmenu`), `Main` (`Fsoc`, appel récursif).

## Risques

- Rejeu : la borne `Evc <= Evl` signalée par le lot Utils ne déborde pas au premier rejeu, car
  `Evl = Evc = 0` initialise `Evl` à `-1` ; en revanche `Evc` n'est jamais remis à zéro
  (redémarrage) et la locale `ev` masque la globale `Ev` (START-A01).
- `Utils.Exit` est appelé par `-t` avant l'installation du `Catch` de `SIGINT` : code de sortie de
  `-t all` à confirmer (START-A02).
- `UnLock` peut corrompre le PID d'une autre instance (remplacement de sous-chaîne, START-A04).
- `Coul` écrit son repli dans les mauvaises variables (START-A03) ; couleurs par défaut dupliquées
  dans 4 fichiers avec des séparateurs différents.
- Appel récursif de `Start.Main` par `Fsoc` (START-A07).

## KPI

<!-- AUTO:kpi -->
| KPI | Valeur |
|---|---|
| Lignes de code (hors commentaires) | 411 |
| Lignes de commentaire | 21 |
| Fonctions | 10 |
| Fonctions Public | 10 |
| Complexité cyclomatique totale | 115 |
| Complexité max (fonction) | 35 (`Lancement`) |
| Variables globales | 51 |
| Variables Public | 51 |
| Couverture des tests (`gbx3 -t`) | n/a (phase 2) |
| Durée des tests / profil (`gbx3 -p`) | n/a (phase 2) |
<!-- /AUTO:kpi -->

## Tests

17 tests prévus (START-T01 à T17) : 15 scénarios `replay` de ligne de commande (version, config,
`-t list/all/<Classe>`, société, verrou, couleurs par défaut, rejeu, restauration, logs,
réplication, caisse, redémarrage) et 2 `gbtest` (`Lock`/`UnLock`, `Coul`). Valeurs attendues
produites dans le clone Laurux non modifié, avec `HOME` isolé et Xvfb.

## Rework

13 étapes sans changement de comportement (START-001 à 013) : documentation, suppression de
4 globales mortes et du code dupliqué, réduction de portée (4 fonctions, 11 variables), extraction
de `RetirePid`, découpage de `Main` et `Lancement`, commonalisations (couleurs par défaut,
`ReplicationOK`, `DebugDir`, parseur de log), remplacement de `-t` par gb.test, `Musique` en
constante. 8 anomalies (START-A01 à A08) soumises à validation utilisateur.
