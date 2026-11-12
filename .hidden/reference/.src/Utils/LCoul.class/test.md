# LCoul — Tests

> Source : `.src/Utils/LCoul.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| LCOUL-T01 | gbtest | Fragments SQL avec configuration complète | `Laurux.conf` de test avec `/Coul/Stk`, `Nstk`, `Eps`, `Spd` renseignés | chaînes exactes de `Art_DB_bgcolor`, `Fac_DB_bgcolor`, `Ecr_DB_bgcolor(False/True)` | `tests/fragments_conf/` | implémenté |
| LCOUL-T02 | gbtest | Configuration absente | `Laurux.conf` sans section `/Coul` | chaînes figées (couleurs `Null` → `''`) | `tests/fragments_sans_conf/` | implémenté |
| LCOUL-T03 | gbtest | Configuration mal formée (anomalie A01) | `/Coul/Eps = "fond rouge"` (sans `:`) | erreur figée ou chaîne figée (à observer dans le clone non modifié) | `tests/conf_malformee/` | implémenté |
| LCOUL-T04 | gbtest (BDD) | Exécution des fragments | `SELECT art_code, <Art_DB_bgcolor> FROM Fiches_Art`, idem `Fiches_Bl` et `Fiches_Mvt` (`Laurux01.sql`, MySQL puis SQLite) | couleurs par ligne de référence | `tests/execution_sql/` | implémenté |

## Détail des tests

- **Valeurs attendues** : produites dans le clone non modifié avec la même configuration de test
  (`-c` vers le `Laurux.conf` du répertoire du test).
- **Données** : `Laurux01.sql` (MySQL) et `Laurux01.sqlite` pour T04 (vérifie les littéraux entre
  guillemets doubles sous SQLite).
- Rendu visuel des listes : non testé automatiquement (les replays des écrans `TriArticles`,
  `TriFacture` et `Listextcpt` comparent les requêtes du log, ce qui suffit).
- **Implémentation (phase 2)** : `.src/Tests/Utils/LCoulTest.test` (configuration posée en mémoire avant le
  premier accès à la classe statique), attendus dans `assets/LCoulTest/expected.txt`. T04 : jeu
  `.hidden/Tests/Utils/assets/LCoulTest/lcoul_couleurs.sql` (articles, `Fiches_Bl` et `Fiches_Mvt` dans chaque état) sous MySQL ;
  partie SQLite sur une copie de `Laurux01.sqlite` sans jeu dérivé (`Fiches_Bl`/`Fiches_Mvt` vides).
  T03 figé : « Type mismatch: wanted SColor » au premier accès, puis « Null object ».
