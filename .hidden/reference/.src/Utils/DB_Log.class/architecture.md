# DB_Log — Architecture

> Source : `.src/Utils/DB_Log.class` (+ `DB_Log.form`)

## Vue d'ensemble

`DB_Log` est la fenêtre de **consultation et de pilotage du journal** produit par
[`DB_Connection`](../DB_Connection.class/architecture.md). Elle est ouverte depuis le menu Gestion
(`Fmenu.Menu330_Click`) et depuis la caisse (`Cmenu.mdp_admin3`, protégé par mot de passe si
`/Soc<XX>/caisse/admin2`). Elle reçoit la connexion (`New DB_Log(Utils.db)`).

Fonctions offertes :
- afficher le fichier de log local dans une `GridView` à 9 colonnes (Date, Level, Type, User, Host,
  Machine, Process, Trace, Message), après copie dans un fichier temporaire ;
- activer/désactiver la journalisation (`Enable`), vider le fichier (`Vider`), rafraîchir (`MAJ`) ;
- sauvegarder le log dans un répertoire choisi (`Sauvegarder` → `DirChooser1` → `Enregistrer`) ;
- éditer les filtres `Clé:regex` (`Filtres` → `FiltresEval` → `Enregistrer`) ;
- régler les niveaux console/fichier des loggers par module [`LLog`](../LLog.class/architecture.md)
  (`Niveau` → `DebugView`).

Nature globale : **GUI**. Le seul traitement est le découpage des lignes du log (`Refresh`).

## Déclarations

<!-- AUTO:declarations -->
| Nom | Nature | Portée | Static | Type | Ligne |
|---|---|---|---|---|---|
| `DB_Con` | var | Private |  | DB_Connection | 3 |
| `Data` | var | Private |  | String[][] | 4 |
| `Dbgmodule` | var | Private |  | String[] | 5 |
<!-- /AUTO:declarations -->

## Fonctions

<!-- AUTO:fonctions -->
| Fonction | Lignes | Portée | CC | LOC | Appelants externes | Remarque |
|---|---|---|---|---|---|---|
| `_new` | 8-46 | Public | 1 | 34 | 0 | méthode spéciale |
| `Refresh` | 48-89 | Public | 5 | 33 | 0 | portée réductible ? |
| `Form_Open` | 91-99 | Public | 1 | 7 | 0 | handler GUI |
| `GridView1_Data` | 101-105 | Public | 1 | 3 | 0 | handler GUI |
| `Enable_Click` | 108-118 | Public | 2 | 7 | 0 | handler GUI |
| `Quitter_Click` | 120-135 | Public | 2 | 14 | 0 | handler GUI |
| `MAJ_Click` | 137-141 | Public | 1 | 3 | 0 | handler GUI |
| `Vider_Click` | 143-148 | Public | 1 | 4 | 0 | handler GUI |
| `Sauvegarder_Click` | 150-164 | Public | 2 | 12 | 0 | handler GUI |
| `DirChooser1_Change` | 168-174 | Public | 2 | 5 | 0 | handler GUI |
| `Enregistrer_Click` | 176-193 | Public | 4 | 16 | 0 | handler GUI |
| `Filtres_Click` | 195-222 | Public | 2 | 26 | 0 | handler GUI |
| `Niveau_Click` | 224-241 | Public | 3 | 15 | 0 | handler GUI |
| `DebugView_Data` | 243-259 | Public | 6 | 16 | 0 | handler GUI |
| `DebugView_Click` | 261-290 | Public | 9 | 26 | 0 | handler GUI |
<!-- /AUTO:fonctions -->

## Description des fonctions

- **`_new(dbconnection)`** [portée : nécessaire] [nature : GUI] : configure les colonnes de
  `GridView1` et de `DebugView`, masque les panneaux secondaires, fixe le nom de sauvegarde par
  défaut `~/Laurux_log.csv`, puis `Refresh()`.
- **`Refresh()`** (CC 5) [portée : réductible] [nature : mixte ; extractible : lecture/découpage].
  Appelle `DB_Con.Refresh()` : **ferme et recrée le logger** (et retente la connexion distante) à
  chaque rafraîchissement. Copie le fichier de log vers `Temp$("Laurux_log_copy")` et découpe chaque
  ligne par `Split(sLine, ";")`.
  ⚠️ `Copy` sans `Try` : erreur si le fichier de log n'existe pas encore (à confirmer : le
  `FileHandler` le crée-t-il à l'ouverture ?). ⚠️ `hFile` n'est jamais fermé. ⚠️ Une requête SQL
  contenant `;` déborde au-delà de la 9e colonne (message tronqué à l'affichage) ; une requête
  multiligne produit des lignes de moins de 9 champs, et `GridView1_Data` lève alors une erreur
  d'indice (`Data[Row][Column]`).
- **`Form_Open`** : remplit les libellés (chemin local, état distant, filtres, erreurs de filtres) et
  la case `Enable` ; duplique une partie de `Refresh`.
- **`GridView1_Data(Row, Column)`** : `Data[Row][Column]` (voir l'anomalie ci-dessus).
- **`Enable_Click`** : `DB_Con.Set_Log(Enable.Value)` si l'état change.
- **`Quitter_Click`** : si le sélecteur de répertoire est visible, revient à la grille ; sinon ferme.
- **`MAJ_Click`** → `Refresh()`. **`Vider_Click`** → `DB_Con.Clear()` puis `Refresh()`.
- **`Sauvegarder_Click`** : bascule vers le sélecteur de répertoire (variable `Dir` inutilisée).
- **`DirChooser1_Change`** : met à jour le nom de sauvegarde `<répertoire>/Laurux_log.csv`.
  ⚠️ Utilise `DirChooser1.Root` (racine du sélecteur, fixée à `User.Home`) et non le répertoire
  sélectionné (`Value`) : le nom proposé reste `~/Laurux_log.csv` (à confirmer à l'écran).
- **`Enregistrer_Click`** (CC 4) : en mode sauvegarde, copie le log vers `SaveName.Text` (`Try`) et
  revient à la grille ; en mode filtres, `DB_Con.Set_Filter(FiltresEval.Text)` et affiche les erreurs.
- **`Filtres_Click`** : bascule grille ↔ éditeur de filtres (visibilités et `Raise`).
- **`Niveau_Click`** : bascule `DebugView` ; liste les clés de `Start.LLogColl` dans `Dbgmodule`
  (variable de boucle `logd` inutilisée en dehors de l'itération).
- **`DebugView_Data`** (CC 6) : nom du module, `*` si actif, niveaux console et fichier
  (`Level_Name(...) & "-" & niveau`).
- **`DebugView_Click`** (CC 9) : colonne 1 bascule `Enabled` ; colonnes 2 et 3 font tourner le niveau
  du handler console ou fichier (`Level_Id` du libellé + 1, retour à `Critical` en bout de cycle ou si
  le libellé est inconnu). Les colonnes 2 et 3 sont deux copies du même code.

## État global utilisé

- `Start.LLogColl` (collection des `LLog` par module), constantes `LLog.console`, `LLog.file`,
  `LLog.Critical`, `LLog.Max`.
- `DB_Connection` : `Refresh`, `Clear`, `Get_Localfile_Path`, `Get_Remotefile_Path`, `Get_Filter`,
  `Set_Filter`, `Get_Filter_Error`, `Get_Log`, `Set_Log`.
- Fichiers : log local, `Temp$("Laurux_log_copy")`, fichier de sauvegarde choisi.

## Propositions d'amélioration

### Réécriture / refactorisation

- Extraire `LireLog(chemin) As String[][]` (pure) : lecture, fermeture du fichier, découpage en
  **9 champs maximum** (le dernier gardant les `;`), complétion des lignes courtes. Le découpage
  borné change l'affichage des lignes contenant `;` : c'est l'anomalie A01, à valider.
- Factoriser les trois bascules de visibilité (`Quitter_Click`, `Enregistrer_Click`,
  `Sauvegarder_Click`/`Filtres_Click`) dans `AfficherPanneau(mode)` (mêmes contrôles, mêmes états).
- Factoriser les colonnes 2 et 3 de `DebugView_Click` dans `NiveauSuivant(handler)`.
- `Form_Open` : réutiliser une fonction `MajLibelles()` partagée avec `Refresh`.

### Commonalisation avec d'autres fichiers

- Le découpage d'une ligne de log est aussi fait par
  [`ReplayObserver.Replay_Event`](../ReplayObserver.class/architecture.md) et par `Start.module`
  (filtre `*;GUI;*`) : une fonction commune de découpage et l'énumération des positions de champs
  (DB_CONNECTION-013) éviteraient trois interprétations du format.

### Réduction de portée

- `Refresh` → `Private` (aucun appelant externe, vérifié par grep).

### Séparation traitement / GUI

- `LireLog` sans accès aux contrôles ; `Refresh` ne fait plus que l'affichage.

## Optimisations possibles (changement de schéma futur)

_Pour information uniquement : non reportées dans rework.md._

- Aucune : pas d'accès SQL. Un log structuré (CSV avec quotes ou JSON par ligne) supprimerait les
  ambiguïtés de découpage, mais c'est un changement de format de fichier, pas de schéma.
