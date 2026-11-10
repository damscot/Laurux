# Conditions — Tests

> Source : `.src/Utils/Conditions.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONDITIONS-T01 | gbtest | Compilation après suppression | suppression de `Conditions`, `Condition` et de `CondFormats` dans `RichDataGrid` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire : relève de la phase 4 (suppression de la classe) |
| CONDITIONS-T02 | gbtest | `Compute` : 7 opérateurs (si conservé) | `Result` `SELECT 5 AS n, 'abc' AS s` ; conditions sur `n` et `s` | booléens et `Value` de référence | `tests/operateurs/` | implémenté |
| CONDITIONS-T03 | gbtest | Combinaison ET, liste vide, champ inconnu, opérateur inconnu | idem | `False`/`True` figés ; `Value` inchangée après `Catch` | `tests/combinaisons/` | implémenté |
| CONDITIONS-T04 | replay | Non-régression `Remisec` | ouverture de la table des remises (`Remisec`) | affichage identique de la grille (log GUI) | `tests/remisec_grille/` | à faire : affichage de la grille non comparé par le runner (dump + SQL seulement) |

## Détail des tests

- T02/T03 n'ont de sens que si la suppression (CONDITIONS-001) est refusée ; ils demandent une
  connexion `Utils.db` (base Docker) pour obtenir un `Result`.
- T04 vérifie que `RichDataGrid` (seul utilisateur) affiche toujours la même grille après le rework.
- **Phase 2 (implémentation)** : `.src/Tests/Utils/ConditionsTest.test` (T02, T03) sur
  `SELECT 5 AS n, 'abc' AS s`. T01 relève de la phase 4 (suppression, CONDITIONS-001).
