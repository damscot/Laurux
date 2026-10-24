# Expart — Tests

> Source : `.src/Utils/Exports-Imports/Expart.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| EXPART-T01 | replay | Export nominal | `Laurux01.sql`, répertoire de sortie de test, `Button2` | `Liste_articles.csv` identique à la référence | `tests/export_nominal/` | à faire |
| EXPART-T02 | replay | Décimales 0/2/3 et `art_stocke` | jeu dérivé : 3 articles `art_nbd` = 0, 2, 3, stocké/non stocké | lignes de référence (dont colonne « Nb dcm » = format) | `tests/decimales/` | à faire |
| EXPART-T03 | replay | Prix `Null` | article avec `art_pbht` NULL | figer : erreur et fichier partiel | `tests/prix_null/` | à faire |
| EXPART-T04 | replay | Table vide | `Fiches_Art` vide | fichier vide créé + `Message.Error` | `tests/table_vide/` | à faire |
| EXPART-T05 | replay | SQLite | `Laurux01.sqlite`, même scénario que T01 | fichier identique à T01 (à confirmer : valeur de `art_stocke`) | `tests/export_sqlite/` | à faire |

## Détail des tests

- Capture dans le clone **Laurux non modifié** ; le chemin de sortie est saisi dans `Sauves`.
  Comparaison : fichier CSV produit, diff BDD vide.
- La locale (séparateur décimal de `Format$`) doit être fixée (`LANG=fr_FR.UTF-8`) dans le runner.
- Jeux dérivés T02-T04 générés par `gen_input.py`.
