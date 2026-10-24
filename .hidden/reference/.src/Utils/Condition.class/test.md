# Condition — Tests

> Source : `.src/Utils/Condition.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CONDITION-T01 | gbtest | Compilation après suppression | voir CONDITIONS-T01 | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |

## Détail des tests

- Structure sans logique : couverte par les tests de `Conditions` (CONDITIONS-T02/T03) si elle est
  conservée.
