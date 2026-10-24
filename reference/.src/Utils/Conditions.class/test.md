# Conditions — Tests

> Source : `.src/Utils/Conditions.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONDITIONS-T01 | gbtest | Compilation après suppression | suppression de `Conditions`, `Condition` et de `CondFormats` dans `RichDataGrid` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |
| CONDITIONS-T02 | gbtest | `Compute` : 7 opérateurs (si conservé) | `Result` `SELECT 5 AS n, 'abc' AS s` ; conditions sur `n` et `s` | booléens et `Value` de référence | `tests/operateurs/` | à faire |
| CONDITIONS-T03 | gbtest | Combinaison ET, liste vide, champ inconnu, opérateur inconnu | idem | `False`/`True` figés ; `Value` inchangée après `Catch` | `tests/combinaisons/` | à faire |
| CONDITIONS-T04 | replay | Non-régression `Remisec` | ouverture de la table des remises (`Remisec`) | affichage identique de la grille (log GUI) | `tests/remisec_grille/` | à faire |

## Détail des tests

- T02/T03 n'ont de sens que si la suppression (CONDITIONS-001) est refusée ; ils demandent une
  connexion `Utils.db` (base Docker) pour obtenir un `Result`.
- T04 vérifie que `RichDataGrid` (seul utilisateur) affiche toujours la même grille après le rework.
