# DB_Log — Tests

> Source : `.src/Utils/DB_Log.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre sans accès SQL : tests `replay` sur des fichiers de log préparés, avec comparaison des
fichiers produits (sauvegarde, filtres) ; un test `gbtest` après extraction de `LireLog`. Valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DB_LOG-T01 | replay | Ouverture et affichage | log préparé : lignes `Exec_SQL`, `GUI`, `Log` ; Gestion → menu Log | aucune erreur ; nombre de lignes de la grille (capture) | `tests/affichage_log/` | implémenté (aucune erreur ; nombre de lignes de la grille non capturé) |
| DB_LOG-T02 | replay | Lignes atypiques | log avec SQL contenant `;` et SQL multiligne | figer le comportement (troncature ; erreur d'indice éventuelle) | `tests/lignes_atypiques/` | à faire : le journal affiché est celui du rejeu (--logfile) ; injecter un journal préparé demande un outillage (journal distinct du scénario) |
| DB_LOG-T03 | replay | Activation / vidage | **Enable** décoché puis coché, **Vider** | taille du fichier de log ; présence de lignes après réactivation | `tests/activation_vidage/` | implémenté (effet lu dans sql.log : seules les requêtes du dernier Agenda restent journalisées ; taille du fichier non comparée) |
| DB_LOG-T04 | replay | Sauvegarde | **Sauvegarder**, choix d'un répertoire, **Enregistrer** | fichier `Laurux_log.csv` copié (emplacement réel, voir `DirChooser1_Change`) | `tests/sauvegarde/` | à faire : copie vers User.Home/Laurux_log.csv (vrai répertoire personnel, non isolé) ; DirChooser non observé ; fichier produit non comparé |
| DB_LOG-T05 | replay | Filtres | **Filtres**, saisie `Exec_SQL:SELECT` puis ligne invalide, **Enregistrer** | texte de `FiltresStatus` ; lignes journalisées ensuite | `tests/edition_filtres/` | implémenté (INSERT filtré, SELECT journalisés ; texte de FiltresStatus non capturé) |
| DB_LOG-T06 | replay | Niveaux par module | `-d 3,3`, ouverture d'un écran utilisant `Utils.Log` ; **Niveau** ; clics colonnes 1, 2, 3 | état `Enabled` et niveaux affichés | `tests/niveaux_modules/` | à faire : DebugView (TableView) non observé ; niveaux affichés non capturés par le runner |
| DB_LOG-T07 | gbtest | `LireLog` (après DB_LOG-002) | fichiers de log préparés (T01, T02) | tableau de champs de référence | `tests/lecture_log/` | à faire : après extraction de LireLog (DB_LOG-002) |

## Détail des tests

- **Données** : fichiers de log écrits à la main dans `tests/<nom>/data/` (format de
  `DB_Connection`) ; aucune base n'est nécessaire hormis la connexion ouverte au démarrage
  (`Laurux01.sql`).
- **Non testable automatiquement** : le contenu visuel de la grille et les couleurs (capture manuelle) ;
  le panneau `RemoteInfo` qui dépend d'un serveur de log distant.
- **Remarque replay** : la fenêtre `DB_Log` agit elle-même sur le log en cours d'écriture (`Refresh`
  recrée le logger) ; le scénario doit utiliser un `--logfile` distinct du fichier affiché.
- **Scénarios (phase 2)** : `.hidden/Tests/Utils/assets/db_log_affichage_log/` (T01 : ouverture, Mise à jour, Quitter ; le nombre de
  lignes de la grille n'est pas capturé), `.hidden/Tests/Utils/assets/db_log_activation_vidage/` (T03 : l'effet de Vider / Activer
  Logging se lit dans le `sql.log` comparé, le journal affiché étant celui du rejeu) et
  `.hidden/Tests/Utils/assets/db_log_edition_filtres/` (T05 : filtre `Exec_SQL:SELECT` + ligne invalide `xyz`, puis création
  Agenda : l'INSERT ne doit plus être journalisé).
