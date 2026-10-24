# ReplayObserver — Tests

> Source : `.src/Utils/ReplayObserver.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

`ReplayObserver` est à la fois l'objet testé et l'outil de test `replay`. Les tests vérifient donc la
**fidélité** : un scénario capturé (`-l`) puis rejoué (`-r`) doit produire les mêmes lignes `GUI` et
`Exec_SQL` (normalisées) dans `<logfile>.out` et le même état de base. Les valeurs attendues sont
produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| REPLAYOBSERVER-T01 | gbtest | Analyse d'une ligne de log (après REPLAYOBSERVER-003) | lignes réelles `Click`, `Keypress`, `Focus`, `Close`, `MouseWheel` ; date sans millisecondes ; valeur avec `;`/`#`/`=` | champs extraits ou erreur figée | `tests/analyse_ligne/` | à faire |
| REPLAYOBSERVER-T02 | replay | Capture et rejeu de boutons et menus | menu principal → fiche client → bouton **Fermer** ; menus imbriqués | `.out` : mêmes lignes `GUI` ; diff BDD vide | `tests/boutons_menus/` | à faire |
| REPLAYOBSERVER-T03 | replay | Saisie clavier | création d'un client : `TextBox` (texte, Tab, Return, BackSpace, Delete, accents) | `Fiches_Cli` identique au log capturé ; figer la perte des accents | `tests/saisie_clavier/` | à faire |
| REPLAYOBSERVER-T04 | replay | Listes et grilles | sélection dans `GridView` (liste articles), `ColumnView`, `ListBox`, `ComboBox`, `TabStrip` | même ligne sélectionnée (requêtes `Exec_SQL` identiques) | `tests/listes_grilles/` | à faire |
| REPLAYOBSERVER-T05 | replay | Cases à cocher, radios, `ToolButton`, `Label` cliquable | écran des préférences (sans enregistrer) | lignes `GUI` identiques | `tests/cases_labels/` | à faire |
| REPLAYOBSERVER-T06 | replay | Fenêtre inattendue | log modifié : fenêtre active différente | sortie de l'application (code et message console figés) | `tests/fenetre_inattendue/` | à faire |
| REPLAYOBSERVER-T07 | replay | Délais | log avec écarts de 0 ms, 500 ms, 30 s | délais programmés (traces console `Next event in …`) | `tests/delais/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker, réimporté avant la capture **et** avant le rejeu ;
  `Laurux.conf` de test dans `tests/<nom>/` (`-c`). Les captures sont faites une fois dans le clone de
  référence et versionnées dans `tests/<nom>/data/*.log`.
- **Normalisation** (`check_output.py`) : suppression de la date, de l'utilisateur, de l'hôte, du
  machine-id, du pid et de la backtrace ; comparaison des champs type + message.
- **Environnement** : session X11 (Xvfb) requise ; Wayland non couvert (ydotool, test manuel).
- **Non testable** : `MouseWheel` (non rejoué par conception) ; événements de contrôles non observés
  par `Utils.Recursive_Observers`.
