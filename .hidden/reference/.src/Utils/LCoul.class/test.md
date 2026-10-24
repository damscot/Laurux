# LCoul — Tests

> Source : `.src/Utils/LCoul.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LCOUL-T01 | gbtest | Fragments SQL avec configuration complète | `Laurux.conf` de test avec `/Coul/Stk`, `Nstk`, `Eps`, `Spd` renseignés | chaînes exactes de `Art_DB_bgcolor`, `Fac_DB_bgcolor`, `Ecr_DB_bgcolor(False/True)` | `tests/fragments_conf/` | à faire |
| LCOUL-T02 | gbtest | Configuration absente | `Laurux.conf` sans section `/Coul` | chaînes figées (couleurs `Null` → `''`) | `tests/fragments_sans_conf/` | à faire |
| LCOUL-T03 | gbtest | Configuration mal formée (anomalie A01) | `/Coul/Eps = "fond rouge"` (sans `:`) | erreur figée ou chaîne figée (à observer dans le clone non modifié) | `tests/conf_malformee/` | à faire |
| LCOUL-T04 | gbtest (BDD) | Exécution des fragments | `SELECT art_code, <Art_DB_bgcolor> FROM Fiches_Art`, idem `Fiches_Bl` et `Fiches_Mvt` (`Laurux01.sql`, MySQL puis SQLite) | couleurs par ligne de référence | `tests/execution_sql/` | à faire |

## Détail des tests

- **Valeurs attendues** : produites dans le clone non modifié avec la même configuration de test
  (`-c` vers le `Laurux.conf` du répertoire du test).
- **Données** : `Laurux01.sql` (MySQL) et `Laurux01.sqlite` pour T04 (vérifie les littéraux entre
  guillemets doubles sous SQLite).
- Rendu visuel des listes : non testé automatiquement (les replays des écrans `TriArticles`,
  `TriFacture` et `Listextcpt` comparent les requêtes du log, ce qui suffit).
