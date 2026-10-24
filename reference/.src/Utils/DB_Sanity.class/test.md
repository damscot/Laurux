# DB_Sanity — Tests

> Source : `.src/Utils/DB_Sanity.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

Classe de fenêtre : les tests actuels sont des `replay` (contrôle, export, correction) avec
comparaison du dump de structure (`SHOW CREATE TABLE` normalisé) et du CSV exporté. Après la
séparation traitement/GUI (DB_SANITY-003/004), les fonctions pures deviennent testables en gb.test
(T07, T08). Valeurs attendues produites dans le clone **Laurux non modifié**.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| DB_SANITY-T01 | replay | Contrôle base conforme | `Laurux01.sql` ; Admin → contrôle ; bouton **Contrôle**, radio **Tous** ; export CSV | `~/tmp/db_control.csv` identique à la référence (après défilement complet, voir A03) | `tests/controle_conforme/` | à faire |
| DB_SANITY-T02 | replay | Contrôle base dégradée | jeu dérivé : type modifié, défaut modifié, `NULL` modifié, collation, champ en trop, champ et table manquants, index manquant, `AUTO_INCREMENT` absent | CSV exporté (réel et attendu) ; codes couleurs relevés par capture | `tests/controle_ecarts/` | à faire |
| DB_SANITY-T03 | replay | Filtres d'affichage | même jeu que T02 ; radios **Contrôlés**, **Contrôlés en erreur**, **Supplémentaires**, **Manquants** | nombre de lignes et CSV exporté par filtre | `tests/filtres_affichage/` | à faire |
| DB_SANITY-T04 | replay | Correction (`Corriger`) | jeu de T02 ; **Contrôle** puis **Corriger** | dump de structure après correction ; dump des données (`RenumAI`) | `tests/correction/` | à faire |
| DB_SANITY-T05 | replay | Correction des clés (`SyncKeys`, `RenumAI`) | table avec clé primaire absente, doublons et 0 dans la colonne `PRI_AI`, index secondaire différent | `SHOW INDEX` et données renumérotées | `tests/correction_cles/` | à faire |
| DB_SANITY-T06 | replay | Nettoyage (`Nettoyer`) | jeu avec champ en trop et table entièrement en trop | structure après nettoyage | `tests/nettoyage/` | à faire |
| DB_SANITY-T07 | gbtest | `SortKeys`, `AddKeyCol`, `KeyDef`, `KeyCols` (après DB_SANITY-004) | listes `PRI(2),idx_a(1)`, `PRI_AI`, types `text`/`blob` | chaînes de référence | `tests/clefs_pures/` | à faire |
| DB_SANITY-T08 | gbtest | `ComparerLigne` (après DB_SANITY-003) | lignes réelles/attendues avec jokers `?`, `integer` SQLite | tableau de codes de validité | `tests/comparaison/` | à faire |
| DB_SANITY-T09 | replay | Contrôle sous SQLite | `Laurux01.sqlite` ; **Contrôle** ; export | CSV exporté (moteur et collation simulés) | `tests/controle_sqlite/` | à faire |

## Détail des tests

- **Données** : `Laurux01.sql` dans MariaDB Docker ; le jeu dégradé de T02/T04 est produit par un
  script SQL `degrade.sql` appliqué après import (`ALTER TABLE` ciblés). `db_control.csv` du dépôt est
  copié dans le répertoire de lancement.
- **Comparaison** : `check_output.py` normalise le dump `SHOW CREATE TABLE` (ordre des index,
  `AUTO_INCREMENT=n`) et compare les CSV ligne à ligne.
- **Non testable automatiquement** : les couleurs de la grille (capture d'écran manuelle), les
  boîtes `Message.Warning` de confirmation (le replay rejoue le clic sur le bouton de la boîte, à
  confirmer avec le harnais) ; l'anomalie A01 (`ENGINE` sans espace) n'est atteignable qu'avec un
  moteur différent dans le jeu dégradé (MyISAM), à inclure dans T02.
