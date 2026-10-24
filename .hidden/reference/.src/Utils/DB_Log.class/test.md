# DB_Log — Tests

> Source : `.src/Utils/DB_Log.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Fenêtre sans accès SQL : tests `replay` sur des fichiers de log préparés, avec comparaison des
fichiers produits (sauvegarde, filtres) ; un test `gbtest` après extraction de `LireLog`. Valeurs
attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DB_LOG-T01 | replay | Ouverture et affichage | log préparé : lignes `Exec_SQL`, `GUI`, `Log` ; Gestion → menu Log | aucune erreur ; nombre de lignes de la grille (capture) | `tests/affichage_log/` | à faire |
| DB_LOG-T02 | replay | Lignes atypiques | log avec SQL contenant `;` et SQL multiligne | figer le comportement (troncature ; erreur d'indice éventuelle) | `tests/lignes_atypiques/` | à faire |
| DB_LOG-T03 | replay | Activation / vidage | **Enable** décoché puis coché, **Vider** | taille du fichier de log ; présence de lignes après réactivation | `tests/activation_vidage/` | à faire |
| DB_LOG-T04 | replay | Sauvegarde | **Sauvegarder**, choix d'un répertoire, **Enregistrer** | fichier `Laurux_log.csv` copié (emplacement réel, voir `DirChooser1_Change`) | `tests/sauvegarde/` | à faire |
| DB_LOG-T05 | replay | Filtres | **Filtres**, saisie `Exec_SQL:SELECT` puis ligne invalide, **Enregistrer** | texte de `FiltresStatus` ; lignes journalisées ensuite | `tests/edition_filtres/` | à faire |
| DB_LOG-T06 | replay | Niveaux par module | `-d 3,3`, ouverture d'un écran utilisant `Utils.Log` ; **Niveau** ; clics colonnes 1, 2, 3 | état `Enabled` et niveaux affichés | `tests/niveaux_modules/` | à faire |
| DB_LOG-T07 | gbtest | `LireLog` (après DB_LOG-002) | fichiers de log préparés (T01, T02) | tableau de champs de référence | `tests/lecture_log/` | à faire |

## Détail des tests

- **Données** : fichiers de log écrits à la main dans `tests/<nom>/data/` (format de
  `DB_Connection`) ; aucune base n'est nécessaire hormis la connexion ouverte au démarrage
  (`Laurux01.sql`).
- **Non testable automatiquement** : le contenu visuel de la grille et les couleurs (capture manuelle) ;
  le panneau `RemoteInfo` qui dépend d'un serveur de log distant.
- **Remarque replay** : la fenêtre `DB_Log` agit elle-même sur le log en cours d'écriture (`Refresh`
  recrée le logger) ; le scénario doit utiliser un `--logfile` distinct du fichier affiché.
