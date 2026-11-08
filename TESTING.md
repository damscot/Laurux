# Tests

## Tests unitaires : gb.test (`.src/Tests/<lot>/*.test`)

Depuis la phase 2 du rework (voir `.hidden/reference/PLAN.md` §4), les tests de logique sont des **modules gb.test**
(fichiers `.test`) rangés par lot dans `.src/Tests/<lot>/`, avec leurs données dans
`.src/Tests/<lot>/assets/<nom>/`. L'ancien harnais `Internal_Test` / `./Laurux -t` est **retiré** : les deux
classes qui l'implémentaient (`LPrix`, `LScript`) ont été converties en `Utils/LPrixTest.test` et
`Utils/LScriptTest.test`.

```bash
gbc3 -ag .                    # compile aussi les modules .test
./Laurux -T list              # liste les modules de test (relais vers « gbx3 -T »)
./Laurux -T all               # exécute tout ; code de sortie 0 = succès
./Laurux -T LPrixTest         # un module ; « LPrixTest.Matrice » pour un seul test
gbx3 -T "*"                   # équivalent direct, depuis le répertoire du projet
```

`-T` exige les sources (`.src/Tests`) à côté de l'exécutable. Les tests gb.test n'ont accès qu'aux membres
`Public`.

### Valeurs attendues (tests de caractérisation)

Le module `TestKit` (`.src/Tests/Framework/TestKit.module`) compare chaque valeur à
`assets/<Module>/expected.txt` (`TestKit.Check("clé", valeur)`). Les valeurs attendues sont **produites dans le
clone de référence** (code d'origine) avec `LAURUX_TEST_RECORD=1`, jamais déduites de la lecture du code :
anomalies comprises, elles figent le comportement actuel. `TestKit.Init()` prépare l'état global attendu
hors de `Start.Main` (`Start.LocalSettings` depuis `Laurux-test.conf`, société, journaux).

```gambas
Public Sub _Setup()
  TestKit.Begin("Utils", "LPrixTest")
End

Public Sub Conversion()
  TestKit.Check("Conversion/L", LPrix("-3,1500", 1, LPrix.Arr_01).L)
End
```

### Runner de non-régression

`.src/Tests/Framework/runner.py` (Python 3, voir `.src/Tests/Framework/README.md`) pilote la base MariaDB
Docker de test, les tests gb.test et les scénarios GUI rejoués, et compare le clone retravaillé au clone de
référence.

Autres fichiers de test : `.src/Tests/TriTest.class` (banc d'essai manuel de `TriGen`, à enrichir : TRITEST-002),
`.src/Utils/CTestTVA.class` (validation TVA), `.src/Caisse/TestCaisses.module` (`TestCai()`, contrôle des
verrous de caisse, pas un test).

## Tests : utilisation du mode logging/replay

Laurux peut enregistrer les événements GUI (clics, saisies, sélections, fermetures) dans un fichier de log,
puis les rejouer. Cela permet de produire des scénarios synthétiques, de rejouer des use-cases réalisés par
l'utilisateur, et de servir de base à des tests de non-régression.

**Important** : le rejeu ne vérifie rien par lui-même. Il reproduit uniquement les actions d'interface.
La vérification de la base de données ou des objets (valeurs attendues) doit être faite à part, à partir
des lignes `Exec_SQL` / `Log` du fichier de log ou par un harnais dédié.

### Enregistrement (capture)

L'enregistrement est **désactivé par défaut**. Il s'active avec `-l` ou depuis le formulaire de logs (`DB_Log`,
bouton `Enable`, qui appelle `DB_Connection.Set_Log`).

```bash
./Laurux -l --logfile /chemin/scenario.log
```

- `--logfile <chemin>` : fichier de log (sinon `~/tmp/Debug/<App>.log`). Le chemin relatif est résolu depuis le répertoire courant.
- `-d "console,file"` : niveaux de log (voir `Start.module`).
- Les contrôles sont observés à l'ouverture de chaque formulaire via `Utils.Observers(Me)`, qui crée un
  `ReplayObserver` par contrôle (`Menu`, `Button`, `CheckBox`, `TextBox`, `ListBox`, `ComboBox`, `GridView`,
  `TreeView`, `TabStrip`, `Label`, etc.), voir `Recursive_Observers` dans `Utils/Utils.module`.
- Chaque événement est écrit par `DB_Connection.GUI_Event` sous la forme :

```
<date> <heure>;<niveau>;GUI;<user>;<host>;<machine>;<pid>;<backtrace>;<Action>=<Valeur>@<Hôte><Ctrl>#<Fenêtre>#<ctrl1>#<ctrl2>...
```

Les actions enregistrées sont : `Click`, `Keypress` (uniquement si le contrôle a le focus), `GotFocus`
(zones de saisie), `MouseDown`/`MouseUp` (labels et toolbuttons), `Close`. La molette est tracée comme « unsupported ».

- Filtres : la chaîne stockée dans `Temp$(Application.Name & "_filter")` contient des lignes `Nom:regex`.
  Un filtre `GUI:...` restreint ce qui est écrit. Sans filtre, tout est accepté. Le filtre se règle dans l'écran
  de logs (`Filtres`).
- Au démarrage, `Start.module` purge les `~/tmp/Debug/*.log`. Un fichier de log utilisé pour un scénario doit donc être
  conservé en dehors de ce répertoire (ou passé avec `--logfile`).

### Rejeu (playback)

```bash
./Laurux -r --logfile /chemin/scenario.log
./Laurux -r --replay-exit --logfile /chemin/scenario.log   # quitte à la fin (code 0) ; 3 si un événement échoue
```

- Seules les lignes contenant `;GUI;` sont retenues ; les autres (`Exec_SQL`, `Log`) sont ignorées.
- Le rejeu démarre après un délai initial de 2 s. Chaque événement est rejoué par un `Timer` à usage unique
  (`ReplayTimer_Timer` dans `.src/Start.module`), ce qui évite de bloquer sur les `ShowModal`.
- Le délai avant l'événement suivant est l'écart entre les horodatages du log, plafonné à 1 s si l'écart dépasse 20 s.
- Avant chaque événement, `Replay_Event` (`.src/Utils/ReplayObserver.class`) vérifie que la fenêtre active
  correspond à la fenêtre enregistrée. Si ce n'est pas le cas, le rejeu s'arrête (`Quit 3`). Avec
  `--replay-exit`, une fenêtre ou un contrôle introuvable arrête aussi le rejeu avec le code 3. Les événements `Close`
  ne sont pas soumis à cette condition.
- Le contrôle est retrouvé par son nom en parcourant la hiérarchie enregistrée (`Children`, puis `Menus`).
- Le fichier de sortie est le fichier d'entrée suffixé par `.out` : l'entrée n'est jamais écrasée.

### Limites à connaître

- Le rejeu dépend des **noms** des contrôles et de la fenêtre active : renommer un contrôle casse le scénario.
- Les frappes (`Keypress`) passent par `Utils.De.SendKeys` et dépendent de l'environnement de bureau.
- Les clics sur les labels utilisent `xdotool` (X11) ou `ydotool` (Wayland, selon `Utils.de.wayland`).
- Sous `--devel`, les observateurs ne sont pas créés : rien n'est enregistré ni rejoué.
- Les écrans qui n'appelaient pas `Utils.Observers(Me)` appellent `Utils.ReplayObservers(Me)` (harnais de la
  phase 2) : observateurs de rejeu seuls, sans les couleurs du thème. Non rejoués : les touches `ImageButton`
  de la caisse et les clics de grilles sans handler `<Grille>_Click` (REPLAYOBSERVER-A06, non retenue).
- `Fmenu` lance `mysql -h <hôte>` sans port au démarrage (sql_mode global) ; le runner de test place des
  enveloppes `mysql`/`mysqldump` en tête du `PATH` pour viser la base de test.
- Pour un `Button`, le rejeu affecte `Value = True` (`Replay_Click`) ; cela ne déclenche pas forcément
  `_Click` comme un clic utilisateur. À vérifier sur un cas réel avant de s'appuyer dessus.
- Les événements `MouseWheel` ne sont pas rejoués.
