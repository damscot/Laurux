# Tests

## Tests : la convention `Internal_Test`

Il **existe** un harnais de test, mais il est **opt-in par classe** : une classe s'inscrit en
définissant `Public Sub Internal_Test(Test_List As String[]) As Boolean`.

```gambas
Public Sub Internal_Test(Test_List As String[]) As Boolean
  If Test_List.Find("list") <> -1 Then
    Print "Internal Test for Class " & Object.Class(Me).Name & ": " & Object.Class(Me).Name
    Return True
  Endif
  If ((Test_List.Find("all") = -1) And (Test_List.Find(Object.Class(Me).Name) = -1)) Then
    Print "Internal Test for Class : " & Object.Class(Me).Name & " => SKIPPED"
    Return True
  Endif
  ' ... assertions ; Return True/False
End
```

`Start.Start_Test()` (`.src/Start.module`) parcourt **toutes** les classes chargées, appelle
`Internal_Test` sur celles qui l'ont, et sort avec `Utils.Exit(success)` → code de sortie 0/1.

```bash
./Laurux -t list    # liste les classes testables
./Laurux -t all     # exécute tout  (exit 0 = succès)
```

**Aujourd'hui, 2 classes l'implémentent** : `Utils/LPrix.class` et `Utils/LScript.class`.
La convention existe et fonctionne — **ajoute `Internal_Test` à toute classe de logique métier
que tu écris ou modifies**, c'est le moyen de la tester ici.

Autres fichiers de test : `.src/Tests/TriTest.class` (prototype manuel du widget `TriGen`),
`.src/Utils/CTestTVA.class` (validation TVA), `.src/Caisse/TestCaisses.module` (`TestCai()`).
Il n'y a **ni framework unitaire ni CI** : le harnais `Internal_Test` est le seul mécanisme,
et le pilotage de l'IHP (login MySQL, caisse) reste manuel.

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
```

- Seules les lignes contenant `;GUI;` sont retenues ; les autres (`Exec_SQL`, `Log`) sont ignorées.
- Le rejeu démarre après un délai initial de 2 s. Chaque événement est rejoué par un `Timer` à usage unique
  (`ReplayTimer_Timer` dans `.src/Start.module`), ce qui évite de bloquer sur les `ShowModal`.
- Le délai avant l'événement suivant est l'écart entre les horodatages du log, plafonné à 1 s si l'écart dépasse 20 s.
- Avant chaque événement, `Replay_Event` (`.src/Utils/ReplayObserver.class`) vérifie que la fenêtre active
  correspond à la fenêtre enregistrée. Si ce n'est pas le cas, le rejeu s'arrête (`Quit`). Les événements `Close`
  ne sont pas soumis à cette condition.
- Le contrôle est retrouvé par son nom en parcourant la hiérarchie enregistrée (`Children`, puis `Menus`).
- Le fichier de sortie est le fichier d'entrée suffixé par `.out` : l'entrée n'est jamais écrasée.

### Limites à connaître

- Le rejeu dépend des **noms** des contrôles et de la fenêtre active : renommer un contrôle casse le scénario.
- Les frappes (`Keypress`) passent par `Utils.De.SendKeys` et dépendent de l'environnement de bureau.
- Les clics sur les labels utilisent `xdotool` (X11) ou `ydotool` (Wayland, selon `Utils.de.wayland`).
- Sous `--devel`, les observateurs ne sont pas créés : rien n'est enregistré ni rejoué.
- Pour un `Button`, le rejeu affecte `Value = True` (`Replay_Click`) ; cela ne déclenche pas forcément
  `_Click` comme un clic utilisateur. À vérifier sur un cas réel avant de s'appuyer dessus.
- Les événements `MouseWheel` ne sont pas rejoués.
