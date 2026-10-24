# Cmoprod — Tests

> Source : `.src/Utils/Cmoprod.class` · Types : `gbtest` (module gb.test, `gbx3 -T`) ou `replay` (log/replay + diff BDD).
> Données de référence : `tests/<nom_du_test>/`.

| Id | Type | Objet | Entrées | Résultat attendu | Répertoire | Statut |
|---|---|---|---|---|---|---|
| CMOPROD-T01 | gbtest | Compilation après suppression | suppression de `Cmoprod.class` | `gbc3 -agt` sans erreur | `tests/suppression/` | à faire |

## Détail des tests

- Classe sans logique ni usage : seul le test de compilation est pertinent.
