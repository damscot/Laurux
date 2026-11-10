# Expart — Tests

> Source : `.src/Utils/Exports-Imports/Expart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPART-T01 | replay | Export nominal | `Laurux01.sql`, répertoire de sortie de test, `Button2` | `Liste_articles.csv` identique à la référence | `tests/export_nominal/` | à faire : CSV produit non capturé par le runner (écrit dans User.Home) |
| EXPART-T02 | replay | Décimales 0/2/3 et `art_stocke` | jeu dérivé : 3 articles `art_nbd` = 0, 2, 3, stocké/non stocké | lignes de référence (dont colonne « Nb dcm » = format) | `tests/decimales/` | à faire : CSV produit non capturé par le runner (écrit dans User.Home) |
| EXPART-T03 | replay | Prix `Null` | article avec `art_pbht` NULL | figer : erreur et fichier partiel | `tests/prix_null/` | à faire : CSV partiel non capturé ; erreur non gérée dans un gestionnaire d'événement |
| EXPART-T04 | replay | Table vide | `Fiches_Art` vide | fichier vide créé + `Message.Error` | `tests/table_vide/` | implémenté (`assets/expart_table_vide/`) : `Message.Error` vérifié par le rejeu (une boîte FMessage) ; fichier vide non comparé |
| EXPART-T05 | replay | SQLite | `Laurux01.sqlite`, même scénario que T01 | fichier identique à T01 (à confirmer : valeur de `art_stocke`) | `tests/export_sqlite/` | à faire : SQLite non disponible dans l'infrastructure de test (MariaDB seule) |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; le chemin de sortie est saisi dans `Sauves`.
  Comparaison : fichier CSV produit, diff BDD vide.
- La locale (séparateur décimal de `Format$`) doit être fixée (`LANG=fr_FR.UTF-8`) dans le runner.
- Jeux dérivés T02-T04 générés par `gen_input.py`.
- **Phase 2 (implémentation)** : T04 = scénario `.hidden/Tests/Utils/assets/expart_table_vide/` (`Menu281`, jeu
  `datasets/articles_vide.sql`). T01-T03 : le CSV est écrit dans `Sauves` (par défaut `User.Home`, vrai HOME
  non isolé) et n'est pas capturé par le runner (besoin d'outillage : capture des fichiers produits).
